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
import management.dao.HistoryDepDAO;
import management.dto.HistoryDepDTO;

/**
 *
 * @author VyNT
 */
public class FilterHisDepController extends HttpServlet {

    private final String SUCCESS = "historyChangeDep.jsp";
    private final String ERROR = "historyChangeDep.jsp";

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
            HistoryDepDAO dao = new HistoryDepDAO();
            ArrayList<HistoryDepDTO> list = new ArrayList<>();
            String depName = request.getParameter("depName");
            String status = request.getParameter("status");
            String txtSearchName = request.getParameter("txtSearchName");
            if (depName == null || status == null || txtSearchName == null) {
                url = "Hall.jsp";
            } else {
                if (status.trim().equals("allStatus") && depName.trim().equals("allDep")) {
                    list = dao.listHisDepFilter(txtSearchName.trim(), "", "");
                } else if (status.trim().equals("allStatus") && !depName.trim().equals("allDep")) {
                    list = dao.listHisDepFilter(txtSearchName.trim(), depName.trim(), "");
                } else if (!status.trim().equals("allStatus") && depName.trim().equals("allDep")) {
                    list = dao.listHisDepFilter(txtSearchName.trim(), "", status.trim());
                } else {
                    list = dao.listHisDepFilter(txtSearchName.trim(), depName.trim(), status.trim());
                }
                if (list.isEmpty()) {
                    request.setAttribute("listHisDep", list);
                    request.setAttribute("SearchRS", "No Match");
                    url = SUCCESS;
                } else {
                    request.setAttribute("listHisDep", list);
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
