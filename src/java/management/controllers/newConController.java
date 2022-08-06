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
import management.dao.ContractDAO;
import management.dao.HistoryContractDAO;

/**
 *
 * @author lehon
 */
public class newConController extends HttpServlet {

    private static final String DONE = "createNewCon.jsp";
    private static final String OKE = "mainController?action=showlist&type=con";

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
        try ( PrintWriter out = response.getWriter()) {
            HttpSession ss = request.getSession();
            String typeCon = request.getParameter("typecon");
            String expDay = request.getParameter("expday");
            String idEmp = request.getParameter("idemp");
            boolean checkexp = false;
            boolean check = false;
            String checkInsert = "";
            try {
                checkexp = ContractDAO.checkValidExpDay(expDay);
            } catch (SQLException ex) {
                Logger.getLogger(newConController.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (checkexp) {
                try {
                    checkInsert = ContractDAO.insertNewContract(expDay, "...", typeCon);
                    HistoryContractDAO.insertHisCon(checkInsert, idEmp);
                    check = true;
                } catch (SQLException ex) {
                    Logger.getLogger(newConController.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (check) {
                    ss.setAttribute("COMPLETED", "COMPLETED");
                    url = OKE;
                    response.sendRedirect(url);
                    return;
                }

            } else {
                request.setAttribute("WARNING", "Expiration date must be from tomorrow onwards");
                url = DONE;
            }

            request.setAttribute("empreg", idEmp);
            request.setAttribute("conreg", typeCon);
            request.setAttribute("expreg", expDay);
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
