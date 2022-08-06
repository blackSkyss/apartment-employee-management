/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import management.dao.HistoryPosDAO;
import management.dao.PositionDAO;

/**
 *
 * @author AD
 */
public class savePositionController extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession ss = request.getSession();
            PositionDAO dao = new PositionDAO();
            String depName = request.getParameter("depName");
            int oldIdPos = Integer.parseInt(request.getParameter("oldIdPos"));
            int idPos = Integer.parseInt(request.getParameter("idPos"));
            int idEmp = Integer.parseInt(request.getParameter("idEmp"));
            int type = Integer.parseInt(request.getParameter("type"));
            Date exactDate = Date.valueOf(request.getParameter("exactDate"));
            Date d = new Date(System.currentTimeMillis());
            int check = d.compareTo(exactDate);
            boolean checkPos = false;
            if (idPos == 1) {
                checkPos = dao.checkPosMana(depName);
            }
            if (check > 0) {
                ss.setAttribute("updateFail", "Date must after today!");
                response.sendRedirect("promoteAndDemoteController");
            } else {
                if (checkPos) {
                    ss.setAttribute("updateFail", "Department already manager!!");
                    response.sendRedirect("promoteAndDemoteController");
                } else {
                    boolean resultUpdateOldPos = HistoryPosDAO.updatePos(idEmp, oldIdPos);
                    boolean result = HistoryPosDAO.insertNewPos(idEmp, exactDate, idPos, type);
                    if (result && resultUpdateOldPos == true) {
                        ss.setAttribute("updateSuccess", "Update success");
                        response.sendRedirect("promoteAndDemoteController");
                    } else {
                        request.setAttribute("updateFail", "Update fail");
                        response.sendRedirect("promoteAndDemoteController");
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
            Logger.getLogger(savePositionController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(savePositionController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(savePositionController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(savePositionController.class.getName()).log(Level.SEVERE, null, ex);
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

}
