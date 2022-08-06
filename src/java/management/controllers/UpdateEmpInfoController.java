/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package management.controllers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import management.dao.EmployeeDAO;
import management.dto.EmployeeDTO;
import management.regex.RegexEmp;

/**
 *
 * @author lehon
 */
@MultipartConfig
public class UpdateEmpInfoController extends HttpServlet {

    private static final int DEFAULT_BUFFER_SIZE = 8192;
    private static final String URL_SAVE_IMAGE = "/images/";
    private static String RETURN = "updateEmpInfo.jsp";
    private static final String DONE_UPDATE = "EmployeeHome.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "error.jsp";
        try (PrintWriter out = response.getWriter()) {
            String idemp = request.getParameter("idemp");
            String name = request.getParameter("empname");
            String salary = request.getParameter("empsalary");
            String address = request.getParameter("empadd");
            String gender = request.getParameter("empgen");
            String phone = request.getParameter("empphone");
            String dob = request.getParameter("empdob");
            String oldimg = request.getParameter("oldimg");
            Part part = request.getPart("empimg");
            String fileName = extractFileName(part);
            boolean checkUpdate = false;
            EmployeeDTO emp = new EmployeeDTO();
            if (RegexEmp.checkFieldNullUpdate(name, salary, address, phone, dob)) {
                url = RETURN;
                request.setAttribute("WARNINGFIELD", "You have not filled in the information completely");
            } else {
                if (RegexEmp.checkEmpValidationUpdate(name, salary, address, phone, dob)) {

                    if (!fileName.isEmpty() || !fileName.equals("")) {
                        //Remove old file image
                        String path = request.getServletContext().getRealPath("/");
                        String[] list = path.split("\\\\");
                        String path2 = "";
                        for (int j = 0; j < list.length; j++) {
                            if (!list[j].toString().equals("apartment-employee-management")) {
                                path2 = path2 + list[j].toString() + "\\";
                            } else {
                                path2 = path2 + list[j].toString() + "\\" + "web";
                                break;
                            }
                        }
                        File deletefile = new File(path2 + "\\images\\" + oldimg);
                        deletefile.delete();

                        //Add new file image
                        String savePath = path2 + "\\images" + File.separator + fileName;
                        File fileSaveDir = new File(savePath);
                        part.write(savePath + File.separator);

                        //Update with new image
                        try {
                            checkUpdate = EmployeeDAO.UpdateEmpImg(name, salary, address, gender, phone, dob, fileName, idemp);
                        } catch (SQLException ex) {
                            Logger.getLogger(updateEmpController.class.getName()).log(Level.SEVERE, null, ex);
                        }

                    } else {

                        try {
                            checkUpdate = EmployeeDAO.UpdateEmpNoImg(name, salary, address, gender, phone, dob, idemp);
                        } catch (SQLException ex) {
                            Logger.getLogger(updateEmpController.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }

                    if (checkUpdate) {
                        url = DONE_UPDATE;
                        emp = EmployeeDAO.showEmpByID(Integer.valueOf(idemp));
                        HttpSession ss = request.getSession(true);
                        ss.setAttribute("USER_LOGGIN", emp);
                        ss.setAttribute("COMPLETED", "Successful");
                        response.sendRedirect(url);
                    }
                } else {
                    url = RETURN;
                    if (RegexEmp.checkEmpName(name) == false) {
                        request.setAttribute("WARNINGNAME", "Names contains only letters and space and can be between 4 and 30 characters long");
                    } else if (RegexEmp.checkSalary(salary) == false) {
                        request.setAttribute("WARNINGSALARY", "Salary contains only number and from 100$ to 10000$");
                    } else if (RegexEmp.checkEmpAddress(address) == false) {
                        request.setAttribute("WARNINGADD", "Address between 5 and 40 characters long");
                    } else if (RegexEmp.checkPhone(phone) == false) {
                        request.setAttribute("WARNINGPHONE", "Phone contain only letters and length 5 to 15");
                    } else if (RegexEmp.checkValidationDob(dob) == false) {
                        request.setAttribute("WARNINGDOB", "Age must be from 18 to 65");
                    }

                }
            }

            if (!url.equals(DONE_UPDATE)) {
                request.setAttribute("namereg", name);
                request.setAttribute("salaryreg", salary);
                request.setAttribute("addreg", address);
                request.setAttribute("genreg", gender);
                request.setAttribute("phonereg", phone);
                request.setAttribute("dobreg", dob);
                request.setAttribute("imgreg", oldimg);
                request.setAttribute("idreg", idemp);
                request.getRequestDispatcher(url).forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UpdateEmpInfoController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String extractFileName(Part part) {//This method will print the file name.
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    public static void writeImage(HttpServletRequest request, String imageName, Part filePart) throws IOException, ServletException {
        InputStream fileContent = filePart.getInputStream();
        String path = request.getServletContext().getRealPath("/");
        FileOutputStream fos = new FileOutputStream(path + URL_SAVE_IMAGE + imageName, false);

        try {
            int read;
            byte[] bytes = new byte[DEFAULT_BUFFER_SIZE];
            while ((read = fileContent.read(bytes)) != -1) {
                fos.write(bytes, 0, read);
            }
        } finally {
            if (fos != null) {
                fos.close();
            }
            if (fileContent != null) {
                fileContent.close();
            }
        }

    }
}
