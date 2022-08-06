/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import management.dao.EmployeeDAO;
import management.dto.EmployeeDTO;
import management.regex.RegexEmp;

/**
 *
 * @author VyNT
 */
public class ChangePassController extends HttpServlet {

    private final String SUCCESS = "changePassEmp.jsp";
    private final String ERROR = "changePassEmp.jsp";

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
        PrintWriter out = response.getWriter();
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            EmployeeDTO emp = (EmployeeDTO) session.getAttribute("USER_LOGGIN");
            String oldPass = request.getParameter("oldPass");
            String newPass = request.getParameter("newPass");
            String confirmPass = request.getParameter("confirmPass");
            EmployeeDAO dao = new EmployeeDAO();
            if (oldPass == null || newPass == null || confirmPass == null) {
                url = "Hall.jsp";
            } else {
                if (!RegexEmp.checkValidPass(oldPass.trim()) || !oldPass.trim().equals(emp.getPassword())) {
                    request.setAttribute("checkOldPass", "Please check the current pass!");
                    url = ERROR;
                } else {
                    if (!RegexEmp.checkValidPass(newPass)) {
                        request.setAttribute("checkNewPass", "Please check the new pass!");
                        url = ERROR;
                    } else if (!newPass.trim().equals(confirmPass.trim())) {
                        request.setAttribute("checkPass", "Confirm Pass not match!");
                        url = ERROR;
                    } else {
                        boolean changePass = dao.changePass(newPass, String.valueOf(emp.getIdEmp()));
                        if (changePass) {
                            url = SUCCESS;
                            request.setAttribute("Warning", "Update success");
                        } else {
                            url = ERROR;
                            request.setAttribute("Warning", "Change Password false!");
                        }
                    }
                }
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
