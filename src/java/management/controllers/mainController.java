/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author lehon
 */
@MultipartConfig
public class mainController extends HttpServlet {

    private String url = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            if (action.equals("showlist")) {
                url = "listHallManagerController";
            } else if (action.equals("logout")) {
                url = "logoutController";
            } else if (action.equals("Create")) {
                url = "newDepController";
            } else if (action.equals("Update")) {
                url = "editDepController";
            } else if (action.equals("changeDep")) {
                url = "changeDepController";
            } else if (action.equals("listPosition")) {
                url = "listPositionController";
            } else if (action.equals("ssPosition")) {
                url = "sessionPositionController";
            } else if (action.equals("updatePosition")) {
                url = "updatePositionController";
            } //            else if (action.equals("promoteAndDemote")) {
            //                url = "promoteAndDemoteController";
            //            } 
            else if (action.equals("SavePosition")) {
                url = "savePositionController";
            } else if (action.equals("history")) {
                url = "listHistoryController";
            } else if (action.equals("createcon")) {
                url = "newConController";
            } //            else if (action.equals("hisPromoteAndDemote")) {
            //                url = "listHistoryPositionController";
            //            } 
            else if (action.equals("listCertificate")) {
                url = "SearchCerController";
            } else if (action.equals("add new certificate")) {
                url = "addNewCertificateController";
            } else if (action.equals("saveNewCertificate")) {
                url = "saveNewCertificateController";
            } else if (action.equals("passidcon")) {
                url = "passOjConController";
            } else if (action.equals("updateCon")) {
                url = "updateConController";
            } else if (action.equals("renewal")) {
                url = "renewalConController";
            } else if (action.equals("updateCertificate")) {
                url = "updateCertificateController";
            } else if (action.equals("passidemp")) {
                url = "passOjEmpController";
            } else if (action.equals("SaveChange")) {
                url = "saveChangeCertificateController";
            } else if (action.equals("Update Regulation")) {
                url = "updateRegController";
            } else if (action.equals("UpdateReg")) {
                url = "updateRegPageController";
            } else if (action.equals("addReg")) {
                url = "addNewRegPage.jsp";
            } else if (action.equals("Create Regulation")) {
                url = "createNewRegController";
            } else if (action.equals("passiddep")) {
                url = "passOjDepController";
            } else if (action.equals("listDependent")) {
                url = "listDependentController";
            } else if (action.equals("updateDependent")) {
                url = "updateDependentController";
            } else if (action.equals("Save Dependent")) {
                url = "saveDependentController";
            } else if (action.equals("rewardpenalty")) {
                url = "SearchRPController";
            } else if (action.equals("UpdateRp")) {
                url = "editRPController";
            } else if (action.equals("pushss")) {
                url = "pushSessionController";
            } else if (action.equals("DeleteRp")) {
                url = "DeleteRpController";
            } else if (action.equals("CreateNewRp")) {
                url = "CreateNewRpController";
            } else if (action.equals("createEmp")) {
                url = "newEmpController";
            } else if (action.equals("updateEmp")) {
                url = "updateEmpController";
            } else if (action.equals("accountInfo")) {
                url = "AccountInfoController";
            } else if (action.equals("updateEmpPage")) {
                url = "UpdateEmpPageController";
            } else if (action.equals("updateEmpInfo")) {
                url = "UpdateEmpInfoController";
            } else if (action.equals("listCertEmp")) {
                url = "listCertEmpController";
            } else if (action.equals("updateCertPage")) {
                url = "UpdateCertPageController";
            } else if (action.equals("saveCertEmp")) {
                url = "SaveCertEmpController";
            } else if (action.equals("addNewCertPage")) {
                url = "AddNewCertPageController";
            } else if (action.equals("addNewCertEmp")) {
                url = "AddNewCertEmpController";
            } else if (action.equals("addNewDependent")) {
                url = "addNewDependentController";
            } else if (action.equals("saveNewDependent")) {
                url = "saveNewDependentController";
            } else if (action.equals("listRewPenEmp")) {
                url = "listRewPenEmpController";
            } else if (action.equals("filterReg")) {
                url = "FilterRegController";
            } else if (action.equals("filterDepByLocation")) {
                url = "FilterDepByLocationController";
            } else if (action.equals("searchRP")) {
                url = "SearchRPController";
            } else if (action.equals("searchDependent")) {
                url = "SearchDependentController";
            } else if (action.equals("filterHisDep")) {
                url = "FilterHisDepController";
            } else if (action.equals("filterChangeDep")) {
                url = "FilterChangeDepController";
            } else if (action.equals("searchCon")) {
                url = "SearchConController";
            } else if (action.equals("searchCer")) {
                url = "SearchCerController";
            } else if (action.equals("searchHisPos")) {
                url = "SearchHisPosController";
            } else if (action.equals("searchPro")) {
                url = "SearchProController";
            } else if (action.equals("changePassEmp")) {
                url = "ChangePassController";
            } else if (action.equals("listDependentEmp")) {
                url = "ListDependentEmpController";
            } else if (action.equals("updateDependentEmp")) {
                url = "updateDependentEmpController";
            } else if (action.equals("SaveDependentEmp")) {
                url = "saveDependentEmpController";
            } else if (action.equals("saveNewDependentEmp")) {
                url = "saveNewDependentEmpController";
            } else if (action.equals("showDepartmentEmp")) {
                url = "showDepartmentEmpController";
            } else if (action.equals("showHisDepEmp")) {
                url = "showHisDepEmpController";
            } else if (action.equals("showHisPosEmp")) {
                url = "showHisPosEmpController";
            } else if (action.equals("detailDep")) {
                url = "detailDepController";
            } else if (action.equals("showHisCon")) {
                url = "showHisConController";
            } else if (action.equals("addNewPosition")) {
                url = "addNewPositionController";
            } else if( action.equals("searchHisCon")){
                url = "searchHisConController";
            }

            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
