/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import management.dao.CertificateDAO;
import management.dto.CertificateDTO;

/**
 *
 * @author Admin
 */
public class SearchCerController extends HttpServlet {

    private final String SUCCESS = "listCertificate.jsp";
    private final String ERROR = "listCertificate.jsp";

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
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession(true);
            String keywordidemp = request.getParameter("txtSearchIdemp");
            String keywordname = request.getParameter("txtSearchName");
            String typecer = request.getParameter("typecer");
            CertificateDAO dao = new CertificateDAO();
            ArrayList<CertificateDTO> listCer = new ArrayList<>();
            if (keywordidemp == null || typecer == null || keywordname == null) {
                listCer = CertificateDAO.filterCer("", "", "");
                url = SUCCESS;
            } else {
                if (keywordidemp.trim().isEmpty() && keywordname.trim().isEmpty() && typecer.equals("allCer")) {
                    listCer = dao.filterCer("", "", "");
                } else if (typecer.trim().equals("allCer")) {
                    listCer = dao.filterCer(keywordidemp.trim(), keywordname.trim(), "");
                } else {
                    listCer = dao.filterCer(keywordidemp.trim(), keywordname.trim(), typecer);
                }
            }
            if (listCer.isEmpty()) {
                session.setAttribute("typecer", typecer);
                request.setAttribute("listCer", listCer);
                request.setAttribute("SearchRS", "No Match");
                url = ERROR;
            } else {
                session.setAttribute("typecer", typecer);
                request.setAttribute("listCer", listCer);
                if (keywordidemp == null || !keywordidemp.trim().isEmpty()) {
                    request.setAttribute("empId", keywordidemp);
                }
                if (keywordname == null || !keywordname.trim().isEmpty()) {
                    request.setAttribute("nameEmp", keywordname);
                }
                if (typecer == null || !typecer.trim().equals("allCer")) {
                    request.setAttribute("typeCer", typecer);
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
            Logger.getLogger(SearchCerController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SearchCerController.class.getName()).log(Level.SEVERE, null, ex);
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
