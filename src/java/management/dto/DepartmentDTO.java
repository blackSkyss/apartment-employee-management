/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.dto;

/**
 *
 * @author lehon
 */
public class DepartmentDTO {

    private int depNum;
    private String depName;
    private String description;
    private String location;
    private String dateCreate;
    private String creator;

    public DepartmentDTO() {
    }

    public DepartmentDTO(int depNum, String depName, String description, String location, String dateCreate, String creator) {
        this.depNum = depNum;
        this.depName = depName;
        this.description = description;
        this.location = location;
        this.dateCreate = dateCreate;
        this.creator = creator;
    }

    public int getDepNum() {
        return depNum;
    }

    public void setDepNum(int depNum) {
        this.depNum = depNum;
    }

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(String dateCreate) {
        this.dateCreate = dateCreate;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

}
