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
import management.dao.EmployeeDAO;
import management.dto.EmployeeDTO;

/**
 *
 * @author VyNT
 */
public class FilterChangeDepController extends HttpServlet {

    private final String SUCCESS = "changeDep.jsp";
    private final String ERROR = "changDep.jsp";

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
            EmployeeDAO dao = new EmployeeDAO();
            String txtSearchName = request.getParameter("txtSearchName");
            String depName = request.getParameter("depName");
            String posEmp = request.getParameter("posEmp");
            ArrayList<EmployeeDTO> list = new ArrayList<>();
            if (depName == null || posEmp == null || txtSearchName == null) {
                url = "Hall.jsp";
            } else {
                if (posEmp.trim().equals("allPos") && depName.trim().equals("allDep")) {
                    list = dao.listChangeEmp(txtSearchName.trim(), "", "");
                } else if (posEmp.trim().equals("allPos") && !depName.trim().equals("allDep")) {
                    list = dao.listChangeEmp(txtSearchName.trim(), depName.trim(), "");
                } else if (!posEmp.trim().equals("allPos") && depName.trim().equals("allDep")) {
                    list = dao.listChangeEmp(txtSearchName.trim(), "", posEmp.trim());
                } else {
                    list = dao.listChangeEmp(txtSearchName.trim(), depName.trim(), posEmp.trim());
                }
                if (list.isEmpty()) {
                    request.setAttribute("listEmp", list);
                    request.setAttribute("SearchRS", "No Match");
                    url = SUCCESS;
                } else {
                    request.setAttribute("listEmp", list);
                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
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
