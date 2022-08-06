/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.dto;

/**
 *
 * @author AD
 */
public class HistoryPositionDTO {

    private int idHisPos;
    private int idEmp;
    private String nameEmp;
    private int idPos;
    private String posName;
    private String deliveryDate;
    private String exactDate;
    private int status;
    private int type;

    public String getExactDate() {
        return exactDate;
    }

    public void setExactDate(String exactDate) {
        this.exactDate = exactDate;
    }

    public int getIdHisPos() {
        return idHisPos;
    }

    public void setIdHisPos(int idHisPos) {
        this.idHisPos = idHisPos;
    }

    public int getIdEmp() {
        return idEmp;
    }

    public void setIdEmp(int idEmp) {
        this.idEmp = idEmp;
    }

    public String getNameEmp() {
        return nameEmp;
    }

    public void setNameEmp(String nameEmp) {
        this.nameEmp = nameEmp;
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

    public String getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(String deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public HistoryPositionDTO() {
    }

    public HistoryPositionDTO(int idHisPos, int idEmp, String nameEmp, int idPos, String posName, String deliveryDate, String exactDate, int status, int type) {
        this.idHisPos = idHisPos;
        this.idEmp = idEmp;
        this.nameEmp = nameEmp;
        this.idPos = idPos;
        this.posName = posName;
        this.deliveryDate = deliveryDate;
        this.exactDate = exactDate;
        this.status = status;
        this.type = type;
    }

    public HistoryPositionDTO(int idHisPos, int idEmp, String nameEmp, String posName, String deliveryDate, String exactDate, int status, int type) {
        this.idHisPos = idHisPos;
        this.idEmp = idEmp;
        this.nameEmp = nameEmp;
        this.posName = posName;
        this.deliveryDate = deliveryDate;
        this.exactDate = exactDate;
        this.status = status;
        this.type = type;
    }

    public HistoryPositionDTO(int idHisPos, int idEmp, String nameEmp, int idPos, String posName, String deliveryDate, int status, int type) {
        this.idHisPos = idHisPos;
        this.idEmp = idEmp;
        this.nameEmp = nameEmp;
        this.idPos = idPos;
        this.posName = posName;
        this.deliveryDate = deliveryDate;
        this.status = status;
        this.type = type;
    }

    public HistoryPositionDTO(int idHisPos, String nameEmp, String posName, String deliveryDate, int status, int type) {
        this.idHisPos = idHisPos;
        this.nameEmp = nameEmp;
        this.posName = posName;
        this.deliveryDate = deliveryDate;
        this.status = status;
        this.type = type;
    }

    public HistoryPositionDTO(int idHisPos, String nameEmp, String posName, String deliveryDate, String exactDate, int status, int type) {
        this.idHisPos = idHisPos;
        this.nameEmp = nameEmp;
        this.posName = posName;
        this.deliveryDate = deliveryDate;
        this.exactDate = exactDate;
        this.status = status;
        this.type = type;
    }
    
    
}
