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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import management.dao.ContractDAO;

/**
 *
 * @author lehon
 */
public class updateConController extends HttpServlet {

    private static final String DONE_UPDATE = "mainController?action=showlist&type=con";
    private static final String FAIL_UPDATE = "mainController?action=passidcon&idcon=";

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
        String url = "error.jsp";
        try (PrintWriter out = response.getWriter()) {
            String idcon = request.getParameter("idcon");
            String typecon = request.getParameter("typecon");
            String expday = request.getParameter("expday");
            String nameEmp = request.getParameter("nameEmp");
            boolean checkexp = false;
            boolean checkupdate = false;
            try {
                checkexp = ContractDAO.checkValidExpDay(expday);
            } catch (SQLException ex) {
                Logger.getLogger(updateConController.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (checkexp) {
                try {
                    checkupdate = ContractDAO.updateContractNoFile(idcon, typecon, expday);
                } catch (SQLException ex) {
                    Logger.getLogger(updateConController.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (checkupdate) {
                    try {
                        ContractDAO.changeConToOK(Integer.parseInt(idcon));
                    } catch (SQLException ex) {
                        Logger.getLogger(updateConController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    request.setAttribute("COMPLETE", "Completed");
                    url = DONE_UPDATE;
                }
            } else {
                request.setAttribute("WARNING", "Expiration date must be from tomorrow onwards");
                url = FAIL_UPDATE + idcon + "&flag=update&nameEmp=" + nameEmp;
            }

            request.getRequestDispatcher(url).forward(request, response);
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
