/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.dto;

import java.sql.Date;

/**
 *
 * @author AD
 */
public class CertificateDTO {

    private String empName;
    private int cerId;
    private String cerName;
    private Date doi;
    private String imgPath;
    private int idTypeCer;
    private String type;
    private int idEmp;

    public CertificateDTO() {
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    
    public CertificateDTO(String empName, int cerId, String cerName, Date doi, String imgPath, int idTypeCer, String type, int idEmp) {
        this.empName = empName;
        this.cerId = cerId;
        this.cerName = cerName;
        this.doi = doi;
        this.imgPath = imgPath;
        this.idTypeCer = idTypeCer;
        this.type = type;
        this.idEmp = idEmp;
    }

    public CertificateDTO(String empName, int cerId, String cerName, Date doi, String type, int idEmp, int idTypeCer) {
        this.empName = empName;
        this.cerId = cerId;
        this.cerName = cerName;
        this.doi = doi;
        this.type = type;
        this.idEmp = idEmp;
        this.idTypeCer = idTypeCer;
    }

    public CertificateDTO(String cerName, Date doi, int idTypeCer, int idEmp) {
        this.cerName = cerName;
        this.doi = doi;
        this.idTypeCer = idTypeCer;
        this.idEmp = idEmp;
    }

    public CertificateDTO(int idTypeCer, String type) {
        this.idTypeCer = idTypeCer;
        this.type = type;
    }

    public int getCerId() {
        return cerId;
    }

    public void setCerId(int cerId) {
        this.cerId = cerId;
    }

    public String getCerName() {
        return cerName;
    }

    public void setCerName(String cerName) {
        this.cerName = cerName;
    }

    public Date getDoi() {
        return doi;
    }

    public void setDoi(Date doi) {
        this.doi = doi;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getIdEmp() {
        return idEmp;
    }

    public void setIdEmp(int idEmp) {
        this.idEmp = idEmp;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public int getIdTypeCer() {
        return idTypeCer;
    }

    public void setIdTypeCer(int idTypeCer) {
        this.idTypeCer = idTypeCer;
    }

}
