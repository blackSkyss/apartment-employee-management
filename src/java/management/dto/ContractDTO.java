/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.dto;

/**
 *
 * @author lehon
 */
public class ContractDTO {

    private int idCon;
    private String typeCon;
    private String signDay;
    private String expDay;
    private String filePath;
    private String nameEmp;
    private int status;
  
    
    public ContractDTO() {
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public ContractDTO(int idCon, String typeCon, String signDay, String expDay, String filePath, String nameEmp, int status) {
        this.idCon = idCon;
        this.typeCon = typeCon;
        this.signDay = signDay;
        this.expDay = expDay;
        this.filePath = filePath;
        this.nameEmp = nameEmp;
        this.status = status;
    }

    public ContractDTO(int idCon, String typeCon, String signDay, String expDay, String nameEmp, int status) {
        this.idCon = idCon;
        this.typeCon = typeCon;
        this.signDay = signDay;
        this.expDay = expDay;
        this.nameEmp = nameEmp;
        this.status = status;
    }

    public int getIdCon() {
        return idCon;
    }

    public void setIdCon(int idCon) {
        this.idCon = idCon;
    }

    public String getTypeCon() {
        return typeCon;
    }

    public void setTypeCon(String typeCon) {
        this.typeCon = typeCon;
    }

    public String getSignDay() {
        return signDay;
    }

    public void setSignDay(String signDay) {
        this.signDay = signDay;
    }

    public String getExpDay() {
        return expDay;
    }

    public void setExpDay(String expDay) {
        this.expDay = expDay;
    }

    public String getNameEmp() {
        return nameEmp;
    }

    public void setNameEmp(String nameEmp) {
        this.nameEmp = nameEmp;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
