/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package management.dto;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class RewardPenaltyDTO {
    private int idEmp;
    private String name;
    private String gender;
    private String imgPath;
    private String depName;
    private int idRP;
    private String reason;
    private String namere;
    private int status;
    private int times;
    private Date applicableDate;
    private int idReg;

    public RewardPenaltyDTO() {
    }

    public RewardPenaltyDTO(int idEmp, String name, String gender, String imgPath, String depName, int idRP, String reason, String namere, int status, int times, Date applicableDate, int idReg) {
        this.idEmp = idEmp;
        this.name = name;
        this.gender = gender;
        this.imgPath = imgPath;
        this.depName = depName;
        this.idRP = idRP;
        this.reason = reason;
        this.namere = namere;
        this.status = status;
        this.times = times;
        this.applicableDate = applicableDate;
        this.idReg = idReg;
    }

    public String getNamere() {
        return namere;
    }

    public void setNamere(String namere) {
        this.namere = namere;
    }

    public int getIdReg() {
        return idReg;
    }

    public void setIdReg(int idReg) {
        this.idReg = idReg;
    }

    public Date getApplicableDate() {
        return applicableDate;
    }

    public void setApplicableDate(Date applicableDate) {
        this.applicableDate = applicableDate;
    }

    public int getTimes() {
        return times;
    }

    public void setTimes(int times) {
        this.times = times;
    }
    


    public int getIdEmp() {
        return idEmp;
    }

    public void setIdEmp(int idEmp) {
        this.idEmp = idEmp;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName;
    }

    public int getIdRP() {
        return idRP;
    }

    public void setIdRP(int idRP) {
        this.idRP = idRP;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    

}
