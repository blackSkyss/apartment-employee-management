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
import management.dao.DepartmentDAO;
import management.regex.RegexDep;

/**
 *
 * @author lehon
 */
public class editDepController extends HttpServlet {

    private static String FAIL_UPDATE_DEP = "updateDep.jsp";
    private static String DONE_UPDATE_DEP = "mainController?action=showlist&type=dep";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "error.jsp";
        try ( PrintWriter out = response.getWriter()) {
            String depName = request.getParameter("depname");
            String depDes = request.getParameter("depdes");
            String depLoc = request.getParameter("deploc");
            String depnum = request.getParameter("depnum");
            String depcheck = request.getParameter("depcheck");
            boolean checkUpdate = false;

            if (RegexDep.checkDepFieldNull(depName, depDes, depLoc)) {
                request.setAttribute("WARNING", "You have not filled in the information completely");
                url = FAIL_UPDATE_DEP;

            } else {
                if (RegexDep.checkDepValidationUpdate(depcheck, depName, depDes, depLoc)) {
                    try {
                        checkUpdate = DepartmentDAO.updateDep(depName, depDes, depLoc, depnum);
                    } catch (SQLException ex) {
                        Logger.getLogger(editDepController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    if (checkUpdate) {
                        url = DONE_UPDATE_DEP;
                        request.setAttribute("WARNING", "Completed");
                    }
                } else {

                    // print each error of user input to createNewDep.jsp
                    if (RegexDep.checkDepName(depName) == false) {
                        request.setAttribute("messName", "Names consist of letters only and can be between 1 and 30 characters long");
                    }
                    if (RegexDep.checkDepDes(depDes) == false) {
                        request.setAttribute("messDes", "description length from 1 to 40 characters");
                    }
                    if (RegexDep.checkDepLoc(depLoc) == false) {
                        request.setAttribute("messLoc", "location length from 1 to 10 characters");
                    }

                    if (RegexDep.checkExistDepUpdate(depcheck, depName) == false) {
                        request.setAttribute("WARNINGEXIST", "Same name as another department");
                    }
                    url = FAIL_UPDATE_DEP;

                }

            }

            if (url.equals(FAIL_UPDATE_DEP)) {
                request.setAttribute("namereg", depName);
                request.setAttribute("desreg", depDes);
                request.setAttribute("locreg", depLoc);
                request.setAttribute("idreg", depnum);
                request.setAttribute("nameregcheck", depcheck);
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
