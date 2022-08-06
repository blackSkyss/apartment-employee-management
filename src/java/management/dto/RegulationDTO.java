/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.dto;

/**
 *
 * @author lehon
 */
public class RegulationDTO {

    private int idReg;
    private String name;
    private int status;

    public RegulationDTO() {
    }

    public RegulationDTO(int idReg, String name, int status) {
        this.idReg = idReg;
        this.name = name;
        this.status = status;
    }

    public int getIdReg() {
        return idReg;
    }

    public void setIdReg(int idReg) {
        this.idReg = idReg;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
