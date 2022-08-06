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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import management.dao.ContractDAO;
import management.dto.ContractDTO;

/**
 *
 * @author VyNT
 */
public class searchHisConController extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession(true);
            String typecon = request.getParameter("typecon");
            String statuscon = request.getParameter("statuscon");
            String empname = request.getParameter("empname");
            ArrayList<ContractDTO> listCon;
            if (typecon == null && statuscon == null && empname == null) {
                listCon = ContractDAO.filterHisCon("", "", "");
            } else if (typecon != null && statuscon == null && empname == null) {
                listCon = ContractDAO.filterHisCon(typecon, "", "");
            } else if (typecon == null && statuscon != null && empname == null) {
                listCon = ContractDAO.filterHisCon(typecon, "", "");
            } else if (typecon == null && statuscon == null && empname != null) {
                listCon = ContractDAO.filterHisCon("", "", empname);
            } else if (typecon != null && statuscon != null && empname == null) {
                listCon = ContractDAO.filterHisCon(typecon, statuscon, "");
            } else if (typecon == null && statuscon != null && empname != null) {
                listCon = ContractDAO.filterHisCon("", statuscon, empname);
            } else if (typecon != null && statuscon == null && empname != null) {
                listCon = ContractDAO.filterHisCon(typecon, "", empname);
            } else {
                listCon = ContractDAO.filterHisCon(typecon, statuscon, empname);
            }
            session.setAttribute("typecon", typecon);
            session.setAttribute("statuscon", statuscon);
            request.setAttribute("listCon", listCon);
            request.getRequestDispatcher("HisContract.jsp").forward(request, response);
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
            Logger.getLogger(searchHisConController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(searchHisConController.class.getName()).log(Level.SEVERE, null, ex);
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
