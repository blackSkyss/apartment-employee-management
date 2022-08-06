/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.dto;

import java.sql.Date;

/**
 *
 * @author lehon
 */
public class PositionDTO {

    private int idPos;
    private String posName;
    private String description;
    private String creator;
    private Date dateCreated;

    public PositionDTO(int idPos, String posName, String description, String creator, Date dateCreated) {
        this.idPos = idPos;
        this.posName = posName;
        this.description = description;
        this.creator = creator;
        this.dateCreated = dateCreated;
    }

    public PositionDTO() {
    }

    public PositionDTO(int idPos, String posName, String description) {
        this.idPos = idPos;
        this.posName = posName;
        this.description = description;
    }

    public PositionDTO(int idPos, String posName) {
        this.idPos = idPos;
        this.posName = posName;
    }
    
    
      

    public int getIdPos() {
        return idPos;
    }

    public void setIdPos(int idPos) {
        this.idPos = idPos;
    }

    public String getPosName() {
        return posName;
    }

    public void setPosName(String posName) {
        this.posName = posName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }
    
    
    
}
