/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package management.controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import management.dao.CertificateDAO;
import management.dto.CertificateDTO;
import management.regex.RegexEmp;

/**
 *
 * @author VyNT
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
public class SaveCertEmpController extends HttpServlet {

    private final String SUCCESS = "listCertEmpController";
    private final String ERROR = "updateCertEmp.jsp";

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = ERROR;
        try {
            HttpSession ss = request.getSession();
            String cerID = request.getParameter("cerID");
            String cerName = request.getParameter("cerName");
            String doi = request.getParameter("cerDoi");
            String idEmp = request.getParameter("empID");
            String idTypeCer = request.getParameter("idTypeCer");
            String oldImg = request.getParameter("oldImg");
            Part part = request.getPart("imgPath");
            String fileName = extractFileName(part);
            int i = 0;
            boolean checkName = RegexEmp.checkEmpName(cerName);
            boolean checkDoi = RegexEmp.checkValidationCertiDate(doi);
            if (cerName.equals("") || doi.equals("")) {
                ArrayList<CertificateDTO> listTypeCer = CertificateDAO.listTypeCertificate();
                request.setAttribute("listTypeCer", listTypeCer);
                request.setAttribute("filedBlank", "Do not leave any fields blank!");
                i++;
            } else {
                if (checkName == false) {
                    ArrayList<CertificateDTO> listTypeCer = CertificateDAO.listTypeCertificate();
                    request.setAttribute("listTypeCer", listTypeCer);
                    request.setAttribute("nameInvalid", "Certificate name only contain Alphabet(Upper case or Lower case) and space and length 4 -> 30");
                    i++;
                }

                if (checkDoi == false) {
                    ArrayList<CertificateDTO> listTypeCer = CertificateDAO.listTypeCertificate();
                    request.setAttribute("listTypeCer", listTypeCer);
                    request.setAttribute("checkDoi", "Can only enter the date from 1950 to today !");
                    i++;
                }
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
                    File deletefile = new File(path2 + "\\image\\" + oldImg);
                    deletefile.delete();

                    //Add new file image                    
                    String savePath = path2 + "\\images\\" + File.separator + fileName;
                    File fileSaveDir = new File(savePath);
                    part.write(savePath + File.separator);
                    result = CertificateDAO.saveChangeCertificate(cerName, doi, fileName, idTypeCer, cerID, idEmp);
                } else {
                    result = CertificateDAO.saveChangeCertificateNoImg(cerName, doi, idTypeCer, cerID, idEmp);
                }

                if (result == true) {
                    ss.setAttribute("updateSuccess", "Update success");
                    url = SUCCESS;
                    response.sendRedirect(url);
                } else {
                    url = SUCCESS;
                    ss.setAttribute("updateFail", "Update fail, date wrong format");
                    response.sendRedirect(url);
                }
            } else {
                request.setAttribute("cerID", cerID);
                request.setAttribute("imgPath", oldImg);
                request.setAttribute("cerName", cerName);
                request.setAttribute("cerDoi", doi);
                request.setAttribute("idTypecer", idTypeCer);
                CertificateDAO dao = new CertificateDAO();
                ArrayList<CertificateDTO> listType = dao.listTypeCertificate();
                request.setAttribute("listTypeCer", listType);
                request.getRequestDispatcher("updateCertEmp.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            out.close();
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
}
