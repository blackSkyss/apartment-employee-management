/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import management.dao.DependentDAO;
import management.dto.DependentDTO;

/**
 *
 * @author VyNT
 */
public class SearchDependentController extends HttpServlet {

    private final String SUCCESS = "listDependent.jsp";
    private final String ERROR = "listDependent.jsp";

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
            String keywordidemp = request.getParameter("txtSearchIdemp");
            String keywordname = request.getParameter("txtSearchName");
            DependentDAO dao = new DependentDAO();
            ArrayList<DependentDTO> list = new ArrayList<>();
            if (keywordidemp == null || keywordname == null) {
                url = "Hall.jsp";
            } else {
                list = dao.listDependentForAll(keywordidemp.trim(), keywordname.trim());
                if (list.isEmpty()) {
                    request.setAttribute("listDependent", list);
                    request.setAttribute("SearchRS", "No Match");
                    url = ERROR;
                } else {
                    request.setAttribute("listDependent", list);
                    if (!keywordidemp.trim().isEmpty()) {
                        request.setAttribute("empId", keywordidemp);
                    }
                    if (!keywordname.trim().isEmpty()) {
                        request.setAttribute("nameEmp", keywordname);
                    }
                    url = SUCCESS;
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
