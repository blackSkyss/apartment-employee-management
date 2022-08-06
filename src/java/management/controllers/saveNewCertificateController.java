/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package management.controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
import management.dao.CertificateDAO;
import management.regex.RegexEmp;

/**
 *
 * @author AD
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
public class saveNewCertificateController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession ss = request.getSession();
            /* TODO output your page here. You may use following sample code. */
            String nameCer = request.getParameter("nameCer");
            String doi = request.getParameter("doi");
            String type = request.getParameter("type");
            String idEmp = request.getParameter("idEmp");
            String flag = request.getParameter("flag");
            Part part = request.getPart("imgPath");
            String fileName = extractFileName(part);
            boolean checkName = RegexEmp.checkEmpName(nameCer);
            boolean checkDoi = RegexEmp.checkValidationCertiDate(doi);
            int i = 0;
            if(flag != null){
                request.setAttribute("EmpId", idEmp);
            }
            if (nameCer.equals("") || doi.equals("1900-01-01")) {
                request.setAttribute("filedBlank", "Do not leave any fields blank,  Add fail");
                request.getRequestDispatcher("addNewCertificateController").forward(request, response);
                i++;
            } else if (checkName == false) {
                request.setAttribute("nameInvalid", "Only contain Alphabet(Upper case or Lower case) and space and length 4 -> 30");
                request.getRequestDispatcher("addNewCertificateController").forward(request, response);
                i++;
            } else if (checkDoi == false) {
                request.setAttribute("checkDoi", "Can only enter the date from 1950 to today !");
                request.getRequestDispatcher("addNewCertificateController").forward(request, response);
                i++;
            } else if (fileName.isEmpty() || fileName.equals("")) {
                request.setAttribute("filedBlank", "Choose a Image!!");
                request.getRequestDispatcher("addNewCertificateController").forward(request, response);
                i++;
            }

            if (i == 0) {
                boolean result = false;
                if (!fileName.isEmpty() || !fileName.equals("")) {
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
                    String savePath = path2 + "\\images\\" + File.separator + fileName;
                    File fileSaveDir = new File(savePath);
                    part.write(savePath + File.separator);
                    result = CertificateDAO.insertCertificate(nameCer, doi, fileName, idEmp, type);

                }
                if (result == true) {
                    if (flag == null) {
                        ss.setAttribute("Success", "Success");
                        response.sendRedirect("listCertificateController");
                    } else {
                        ss.setAttribute("Success", "Success");
                        response.sendRedirect("mainController?action=passidemp&empid="+idEmp+"&type=detail");
                    }

                } else {
                    if (flag == null) {
                        ss.setAttribute("Success", "Error");
                        response.sendRedirect("listCertificateController");
                    } else {
                        ss.setAttribute("Success", "Error");
                        response.sendRedirect("mainController?action=passidemp&empid="+idEmp+"&type=detail");
                    }
                }
            }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(saveNewCertificateController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(saveNewCertificateController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
}
