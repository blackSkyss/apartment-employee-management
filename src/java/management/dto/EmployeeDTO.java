/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.dto;

/**
 *
 * @author DELL
 */
public class EmployeeDTO {

    private int idEmp;
    private String name;
    private int baseSalary;
    private String address;
    private String gender;
    private String phoneNum;
    private String dob;
    private String imgPath;
    private String joinDate;
    private String exactDate;
    private String depName;
    private String posName;
    private String email;
    private String password;
    private int statusLog;
    private int role;
    private int idPos;

    public EmployeeDTO() {
    }

    public EmployeeDTO(int idEmp, String name, int baseSalary, String address, String gender, String phoneNum, String dob, String imgPath, String joinDate, String exactDate, String depName, String posName,
            String email, String password, int statusLog, int role) {
        this.idEmp = idEmp;
        this.name = name;
        this.baseSalary = baseSalary;
        this.address = address;
        this.gender = gender;
        this.phoneNum = phoneNum;
        this.dob = dob;
        this.imgPath = imgPath;
        this.joinDate = joinDate;
        this.exactDate = exactDate;
        this.depName = depName;
        this.posName = posName;
        this.email = email;
        this.password = password;
        this.statusLog = statusLog;
        this.role = role;
    }

    public EmployeeDTO(int idEmp, String name, String gender, String dob, String imgPath, String depName, String posName, int idPos) {
        this.idEmp = idEmp;
        this.name = name;
        this.gender = gender;
        this.dob = dob;
        this.imgPath = imgPath;
        this.depName = depName;
        this.posName = posName;
        this.idPos = idPos;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(String joinDate) {
        this.joinDate = joinDate;
    }

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName;
    }

    public String getPosName() {
        return posName;
    }

    public void setPosName(String posName) {
        this.posName = posName;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getStatusLog() {
        return statusLog;
    }

    public void setStatusLog(int statusLog) {
        this.statusLog = statusLog;
    }

    public int getIdPos() {
        return idPos;
    }

    public int getBaseSalary() {
        return baseSalary;
    }

    public void setBaseSalary(int baseSalary) {
        this.baseSalary = baseSalary;
    }

    public String getExactDate() {
        return exactDate;
    }

    public void setExactDate(String exactDate) {
        this.exactDate = exactDate;
    }

}
