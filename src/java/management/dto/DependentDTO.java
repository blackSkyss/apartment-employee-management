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
public class DependentDTO {

    private int idDepen;
    private String name;
    private String gender;
    private Date dob;
    private String relationship;
    private int idEmp;
    private String empName;

    public DependentDTO(int idDepen, String name, String gender, Date dob, String relationship, int idEmp, String empName) {
        this.idDepen = idDepen;
        this.name = name;
        this.gender = gender;
        this.dob = dob;
        this.relationship = relationship;
        this.idEmp = idEmp;
        this.empName = empName;
    }

    public int getIdDepen() {
        return idDepen;
    }

    public void setIdDepen(int idDepen) {
        this.idDepen = idDepen;
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

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
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
}
