/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import management.dao.PositionDAO;
import management.regex.RegexDep;

/**
 *
 * @author AD
 */
public class addNewPositionController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String posName = request.getParameter("posName");
            String posDes = request.getParameter("posDes");
            String creator = request.getParameter("creator");
            boolean checkPosName = RegexDep.checkDepName(posName);
            boolean checkDes = RegexDep.checkPosDes(posDes);
            boolean checkExitPos = PositionDAO.checkPosExist(posName);

            if (posName.equals("") || posDes.equals("")) {
                request.setAttribute("allField", "All field are required !");
                request.setAttribute("posName", posName);
                request.setAttribute("posDes", posDes);
                request.getRequestDispatcher("addNewPosition.jsp").forward(request, response);

                return;
            }
            if (checkExitPos == true) {
                request.setAttribute("posName", posName);
                request.setAttribute("posDes", posDes);
                request.setAttribute("duplicateName", "Position name is already exits !");
            }
            if (checkPosName == false) {
                request.setAttribute("messPosName", "Position name from 1 to 30 character and no number !");
                request.setAttribute("posName", posName);
                request.setAttribute("posDes", posDes);
            }
            if (checkDes == false) {
                request.setAttribute("messDes", "Position description from 1 to 100 character and no number !");
                request.setAttribute("posDes", posDes);
                request.setAttribute("posName", posName);

            }
            if (checkExitPos == true || checkPosName == false || checkDes == false) {
                request.getRequestDispatcher("addNewPosition.jsp").forward(request, response);
            }
            if (checkExitPos == false && checkPosName == true && checkDes == true) {
                boolean insertNewPos = PositionDAO.inserNewPos(posName, posDes, creator);
                if (insertNewPos == true) {
                    request.setAttribute("addSuccess", "add new success !");
                    request.getRequestDispatcher("listPositionController").forward(request, response);
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
            Logger.getLogger(addNewPositionController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(addNewPositionController.class.getName()).log(Level.SEVERE, null, ex);
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
