/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import management.dao.ContractDAO;
import management.dao.DepartmentDAO;
import management.dao.EmployeeDAO;
import management.dao.RegulationDAO;
import management.dto.ContractDTO;
import management.dto.DepartmentDTO;
import management.dto.EmployeeDTO;
import management.dto.RegulationDTO;

/**
 *
 * @author lehon
 */
public class listHallManagerController extends HttpServlet {

    private static final String EMP = "emp";
    private static final String DEP = "dep";
    private static final String CON = "con";
    private static final String CHANGEDEP = "changedep";

    private static final String LIST_EMP = "listEmp.jsp";
    private static final String LIST_DEP = "listDep.jsp";
    private static final String LIST_REG = "listReg.jsp";
    private static final String LIST_CON = "listCon.jsp";
    private static final String CHANGE_DEP = "changeDep.jsp";
    private static final String BOARD_MANAGER = "BoardManagerHome.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "error.jsp";
        try ( PrintWriter out = response.getWriter()) {
            String type = request.getParameter("type");
            ArrayList<EmployeeDTO> listEmp = null;
            ArrayList<DepartmentDTO> listDep = null;
            ArrayList<RegulationDTO> listReg = null;
            ArrayList<ContractDTO> listCon = null;
            ArrayList<ContractDTO> listConCheckedExp = null;
            HashMap<String, String> numberOfEmp = null;
            try {
                listEmp = EmployeeDAO.listEmp();
                listDep = DepartmentDAO.listDep();
                numberOfEmp = DepartmentDAO.getEmpOfDep();
                listReg = RegulationDAO.listReg();
                listCon = ContractDAO.listCon();

            } catch (SQLException ex) {
                Logger.getLogger(listHallManagerController.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (type == null || type.equals("")) {
                request.setAttribute("lengthEmp", String.valueOf(listEmp.size()));
                request.setAttribute("lengthDep", String.valueOf(listDep.size()));
                request.setAttribute("lengthReg", String.valueOf(listReg.size()));
                url = BOARD_MANAGER;
            } else {
                if (type.equals(EMP)) {
                    request.setAttribute("listEmp", listEmp);
                    url = LIST_EMP;

                } else if (type.equals(DEP)) {
                    request.setAttribute("listDep", listDep);
                    request.setAttribute("numberOfEmp", numberOfEmp);
                    url = LIST_DEP;

                } else if (type.equals(CHANGEDEP)) {
                    request.setAttribute("listEmp", listEmp);
                    url = CHANGE_DEP;

                } else if (type.equals(CON)) {
                    boolean checkStatus = false;
                    for (ContractDTO con : listCon) {
                        try {
                            checkStatus = ContractDAO.checkValidExpDay(con.getExpDay());
                        } catch (SQLException ex) {
                            Logger.getLogger(listHallManagerController.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        if (checkStatus == false) {
                            try {
                                ContractDAO.changeConToFailed(con.getIdCon());
                            } catch (SQLException ex) {
                                Logger.getLogger(listHallManagerController.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                    }

                    try {
                        listConCheckedExp = ContractDAO.listCon();
                    } catch (SQLException ex) {
                        Logger.getLogger(listHallManagerController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    request.setAttribute("listCon", listConCheckedExp);
                    url = LIST_CON;

                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("WARNING", "");
                    String noti = request.getParameter("message");
                    if (noti == null) {
                        request.setAttribute("message", "");
                    } else {
                        request.setAttribute("message", noti);
                    }
                    request.setAttribute("listReg", listReg);
                    url = LIST_REG; 

                }
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
