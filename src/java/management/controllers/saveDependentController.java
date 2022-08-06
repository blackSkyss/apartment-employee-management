/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import management.dao.DependentDAO;
import management.dto.DependentDTO;
import management.regex.RegexEmp;

/**
 *
 * @author AD
 */
public class saveDependentController extends HttpServlet {

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
            int idEmp = Integer.parseInt(request.getParameter("idEmp"));
            int idDepen = Integer.parseInt(request.getParameter("idDepen"));
            String relationship = request.getParameter("relationship");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String name = request.getParameter("name");

            boolean checkName = RegexEmp.checkEmpName(name);
            boolean checkRelationship = RegexEmp.checkEmpName(relationship);
            boolean checkDob = RegexEmp.checkValidationCertiDate(dob);
            if (name.equals("") || relationship.equals("") || dob.equals("0000-00-00")) {
                ArrayList<DependentDTO> depenObject = DependentDAO.depenObject(idEmp, idDepen);
                request.setAttribute("depenObject", depenObject);
                request.setAttribute("filedBlank", "Do not leave any fields blank, update fail");
                request.getRequestDispatcher("updateDependent.jsp").forward(request, response);
                return;
            }
            if (checkName == false) {
                ArrayList<DependentDTO> depenObject = DependentDAO.depenObject(idEmp, idDepen);
                request.setAttribute("depenObject", depenObject);
                request.setAttribute("nameInvalid", " Dependent only contain Alphabet and space and length 4 -> 30");
            }
            if (checkRelationship == false) {
                ArrayList<DependentDTO> depenObject = DependentDAO.depenObject(idEmp, idDepen);
                request.setAttribute("depenObject", depenObject);
                request.setAttribute("checkRelationship", "Relationship only contain Alphabet and space and length 4 -> 30");

            }
            if (checkDob == false) {
                ArrayList<DependentDTO> depenObject = DependentDAO.depenObject(idEmp, idDepen);
                request.setAttribute("depenObject", depenObject);
                request.setAttribute("checkDob", "can only enter today and earlier");

            }

            if (checkDob == false || checkName == false || checkRelationship == false) {
                request.getRequestDispatcher("updateDependent.jsp").forward(request, response);
            }
            if (checkDob == true && checkName == true && checkRelationship == true) {
                boolean result = DependentDAO.updateDependent(name, gender, dob, relationship, idEmp, idDepen);
                if (result == true) {
                    request.setAttribute("updateSuccess", "Update success");
                    request.getRequestDispatcher("listDependentController").forward(request, response);

                } else {
                    request.setAttribute("updateFail", "Update fail, wrong date format !");
                    request.getRequestDispatcher("listDependentController").forward(request, response);
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
            Logger.getLogger(saveDependentController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(saveDependentController.class.getName()).log(Level.SEVERE, null, ex);
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
