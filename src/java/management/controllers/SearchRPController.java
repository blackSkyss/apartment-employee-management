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
import management.dao.RewardPenaltyDAO;
import management.dto.RewardPenaltyDTO;

/**
 *
 * @author Admin
 */
public class SearchRPController extends HttpServlet {

    private final String SUCCESS = "listRP.jsp";
    private final String ERROR = "listRP.jsp";

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
        PrintWriter out = response.getWriter();
        String url = ERROR;
        try {
            HttpSession session = request.getSession(true);
            /* TODO output your page here. You may use following sample code. */
            String keywordidemp = request.getParameter("txtSearchIdemp");
            String keywordname = request.getParameter("txtSearchName");
            String depName = request.getParameter("depName");
            String flag = request.getParameter("flag");
            RewardPenaltyDAO dao = new RewardPenaltyDAO();
            ArrayList<RewardPenaltyDTO> listrp = new ArrayList<>();
            if (flag == null) {
                request.setAttribute("idEmp", "");
            } else {
                request.setAttribute("idEmp", keywordidemp);
            }
            if (keywordidemp == null || keywordname == null || depName == null) {
                listrp = RewardPenaltyDAO.listRpForAll("", "", "");
                url = SUCCESS;
            } else {
                if (keywordidemp.trim().isEmpty() && keywordname.trim().isEmpty() && depName.equals("allDep")) {
                    listrp = dao.listRpForAll("", "", "");
                } else if (depName.trim().equals("allDep")) {
                    listrp = dao.listRpForAll(keywordidemp.trim(), keywordname.trim(), "");
                } else {
                    listrp = dao.listRpForAll(keywordidemp.trim(), keywordname.trim(), depName);
                }
            }
            if (listrp.isEmpty()) {
                session.setAttribute("depName", depName);
                request.setAttribute("listrp", listrp);
                request.setAttribute("SearchRS", "No Match");
                url = ERROR;
            } else {
                session.setAttribute("depName", depName);
                request.setAttribute("listrp", listrp);
                if (keywordidemp == null || !keywordidemp.trim().isEmpty()) {
                    request.setAttribute("empId", keywordidemp);
                }
                if (keywordname == null || !keywordname.trim().isEmpty()) {
                    request.setAttribute("nameEmp", keywordname);
                }
                if (depName == null || !depName.trim().equals("allDep")) {
                    request.setAttribute("nameDep", depName);
                }
                url = SUCCESS;
            }

        } catch (Exception e) {
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SearchRPController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SearchRPController.class.getName()).log(Level.SEVERE, null, ex);
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
