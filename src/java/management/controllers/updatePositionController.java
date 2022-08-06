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
import management.dto.PositionDTO;
import management.regex.RegexDep;

/**
 *
 * @author AD
 */
public class updatePositionController extends HttpServlet {

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
            int idPos = Integer.parseInt(request.getParameter("idPos"));
            String posName = request.getParameter("posName");
            String description = request.getParameter("posDescription");
            PositionDTO p = new PositionDTO(idPos, posName, description);
            boolean checkPosName = RegexDep.checkDepName(posName);
            boolean checkDescription = RegexDep.checkPosDes(description);
            if(posName.equals("") || description.equals("")){
                request.setAttribute("position", p);
                request.setAttribute("allFieldRequired", "All field are required !");
                request.getRequestDispatcher("updatePosition.jsp").forward(request, response);
                return;
            }
            
            if (checkPosName == false) {
                request.setAttribute("position", p);
                request.setAttribute("errorMess", "position name must from 1 to 30 character and no contain number !");
                request.getRequestDispatcher("updatePosition.jsp").forward(request, response);
                return;
            }else if(checkDescription == false){
                request.setAttribute("position", p);
                request.setAttribute("errorMessDes", "description must from 1 to 100 character and no contain number !");
                request.getRequestDispatcher("updatePosition.jsp").forward(request, response);
                return;
            }
            boolean result = PositionDAO.updatePosition(posName, description, idPos);
            if (result == true) {
                request.setAttribute("updateSuccess", "Update success");
                request.getRequestDispatcher("listPositionController").forward(request, response);
            } else {
                request.setAttribute("updateFail", "Update fail");
                request.getRequestDispatcher("listPositionController").forward(request, response);
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
            Logger.getLogger(updatePositionController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(updatePositionController.class.getName()).log(Level.SEVERE, null, ex);
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
