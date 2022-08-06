/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import management.dao.CertificateDAO;
import management.dto.CertificateDTO;

/**
 *
 * @author VyNT
 */
public class UpdateCertPageController extends HttpServlet {

    private final String SUCCESS = "updateCertEmp.jsp";
    private final String ERROR = "Hall.jsp";

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
            String cerID = request.getParameter("cerID");
            String imgPath = request.getParameter("imgPath");
            String cerName = request.getParameter("cerName");
            String cerDoi = request.getParameter("cerDoi");
            String cerType = request.getParameter("cerType");
            if (cerID != null && cerDoi != null && cerName != null && cerType != null && imgPath != null) {
                request.setAttribute("cerID", cerID);
                request.setAttribute("imgPath", imgPath);
                request.setAttribute("cerName", cerName);
                request.setAttribute("cerDoi", cerDoi.split(" ")[0]);
                request.setAttribute("cerType", cerType);
                CertificateDAO dao = new CertificateDAO();
                ArrayList<CertificateDTO> listType = dao.listTypeCertificate();
                request.setAttribute("listTypeCer", listType);
                url = SUCCESS;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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

}
