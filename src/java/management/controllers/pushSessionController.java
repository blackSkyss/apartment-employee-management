/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
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
import management.dao.RegulationDAO;
import management.dto.RegulationDTO;

/**
 *
 * @author lehon
 */
public class pushSessionController extends HttpServlet {

    private static String URL = "error.jsp";
    private static final String URL_UPDATE_DEP = "updateDep.jsp";
    private static final String URL_UPDATE_RP = "updateRp.jsp";
    private static final String URL_CHANGE_EMP = "updateEmp.jsp";
    private static final String URL_CREATE_NEW_RP = "createNewRp.jsp";

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
            HttpSession session = request.getSession(true);
            String updateType = request.getParameter("updatetype");
            String id = "";
            String name = "";
            String idReg = "";
            String idRP = "";
            String reason = "";
            String times = "";
            String flag = request.getParameter("flag");
            if (updateType.equals("updatedep")) {
                id = request.getParameter("iddep");
                name = request.getParameter("namedep");
                URL = URL_UPDATE_DEP;

            }
            if (updateType.equals("updaterp")) {
                reason = request.getParameter("reason");
                times = request.getParameter("times");
                id = request.getParameter("idemp");
                name = request.getParameter("nameemp");
                idReg = request.getParameter("idreg");
                idRP = request.getParameter("idrp");
                URL = URL_UPDATE_RP;

            }
            if (updateType.equals("updateemp")) {
                id = request.getParameter("idemp");
                name = request.getParameter("nameemp");
                URL = URL_CHANGE_EMP;

            }
            if (updateType.equals("createnewrp")) {
                if (flag == null) {
                    id = request.getParameter("idemp");
                    name = request.getParameter("nameemp");
                    request.setAttribute("flag", "");
                    URL = URL_CREATE_NEW_RP;
                } else {
                    id = request.getParameter("idemp");
                    name = request.getParameter("nameemp");
                    request.setAttribute("flag", flag);
                    request.setAttribute("idEmp", id);
                    URL = URL_CREATE_NEW_RP;
                }

            }
            session.setAttribute("id", id);
            session.setAttribute("name", name);
            session.setAttribute("idReg", idReg);
            session.setAttribute("idRP", idRP);
            session.setAttribute("reason", reason);
            session.setAttribute("times", times);
            ArrayList<RegulationDTO> list = RegulationDAO.listReg();
            request.setAttribute("list", list);
            request.getRequestDispatcher(URL).forward(request, response);
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
            Logger.getLogger(pushSessionController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(pushSessionController.class.getName()).log(Level.SEVERE, null, ex);
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
