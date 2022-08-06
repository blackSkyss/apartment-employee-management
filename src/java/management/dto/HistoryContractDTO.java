/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package management.dto;

/**
 *
 * @author VyNT
 */
public class HistoryContractDTO {
    private int idHisCon;
    private int idEmp;
    private int idContract;
    private int status;

    public HistoryContractDTO() {
    }

    public HistoryContractDTO(int idHisCon, int idEmp, int idContract, int status) {
        this.idHisCon = idHisCon;
        this.idEmp = idEmp;
        this.idContract = idContract;
        this.status = status;
    }

    public int getIdHisCon() {
        return idHisCon;
    }

    public void setIdHisCon(int idHisCon) {
        this.idHisCon = idHisCon;
    }

    public int getIdEmp() {
        return idEmp;
    }

    public void setIdEmp(int idEmp) {
        this.idEmp = idEmp;
    }

    public int getIdContract() {
        return idContract;
    }

    public void setIdContract(int idContract) {
        this.idContract = idContract;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    
}
