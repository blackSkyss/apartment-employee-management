/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import management.dao.RegulationDAO;
import management.dto.RegulationDTO;
import management.regex.RegexDep;

/**
 *
 * @author VyNT
 */
public class updateRegController extends HttpServlet {

    private final String SUCCESS = "mainController?action=showlist&type=reg";
    private final String ERROR = "mainController?action=UpdateReg";

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
            boolean checkExits = false;
            RegulationDAO dao = new RegulationDAO();
            String idReg = request.getParameter("idReg");
            String nameReg = request.getParameter("regName");
            String typeReg = request.getParameter("regType");
            boolean checkRegName = RegexDep.checkDepName(nameReg);
            ArrayList<RegulationDTO> listReg = dao.listReg();
            if (nameReg.trim().isEmpty()) {
                session.setAttribute("WARNING", "Name is not empty");
//                request.setAttribute("idReg", idReg);
//                request.setAttribute("nameReg", nameReg);
//                request.setAttribute("typeReg", typeReg);
                url = ERROR + "&idRegUpdate=" + idReg + "&nameRegUpdate=" + nameReg + "&statusRegUpdate=" + typeReg;
            } else {
                if (checkRegName) {
                    for (RegulationDTO regulationDTO : listReg) {
                        if (nameReg.trim().equals(regulationDTO.getName()) && !idReg.trim().equals(regulationDTO.getIdReg() + "")) {
                            session.setAttribute("WARNING", "Name is exits");
//                        request.setAttribute("idReg", idReg);
//                        request.setAttribute("nameReg", nameReg);
//                        request.setAttribute("typeReg", typeReg);
                            checkExits = true;
                            url = ERROR + "&idRegUpdate=" + idReg + "&nameRegUpdate=" + nameReg + "&statusRegUpdate=" + typeReg;
                        }
                    }
                    if (!checkExits) {
                        boolean rs = dao.updateReg(Integer.parseInt(idReg), nameReg, Integer.parseInt(typeReg));

                        if (rs) {
                            url = SUCCESS + "&message=Update Success";
                            session.removeAttribute("regName");
                        }
                    }
                } else {
                    session.setAttribute("WARNING", "Name from 1 to 30 character and no number !");
                    url = ERROR + "&idRegUpdate=" + idReg + "&nameRegUpdate=" + nameReg + "&statusRegUpdate=" + typeReg;
                }
            }
        } catch (SQLException e) {
            log("SQL Exception: " + e.getMessage());
        } finally {
            response.sendRedirect(url);
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
