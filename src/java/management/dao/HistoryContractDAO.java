/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package management.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import management.dto.ContractDTO;
import management.utils.DBUtils;

/**
 *
 * @author VyNT
 */
public class HistoryContractDAO {

    private static final String INSERT_HISCONTRACT = "INSERT INTO HistoryContract(idContract,idEmp,status)\n"
            + "VALUES(?, ?, 1)";
    private static final String LIST_HISCONTRACT = "select hc.idHisCon, tc.name as type, signDay, expDay, e.name, c.filePath, hc.status\n"
            + "from Contract as c, Employee as e, TypeContract as tc, HistoryContract as hc\n"
            + "where hc.idEmp = e.idEmp and hc.idContract= c.idContract and c.idTypeCon = tc.idTypeCon and e.role = 0";
    private static final String LIST_HISCONTRACT_BY_IDEMP = "select hc.idHisCon, tc.name as type, signDay, expDay, e.name, c.filePath, hc.status\n"
            + "from Contract as c, Employee as e, TypeContract as tc, HistoryContract as hc\n"
            + "where hc.idEmp = e.idEmp and hc.idContract= c.idContract and c.idTypeCon = tc.idTypeCon and e.role = 0 and e.idEmp = ?";
    private static Connection conn = null;
    private static PreparedStatement ptm = null;
    private static Statement st = null;
    private static ResultSet rs = null;

    public static boolean insertHisCon(String idContract, String idEmp) throws SQLException {
        boolean result = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_HISCONTRACT);
                ptm.setString(1, idContract);
                ptm.setString(2, idEmp);
                int rs = ptm.executeUpdate();
                if (rs > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public static ArrayList<ContractDTO> getListHisCon() throws SQLException {
        ArrayList<ContractDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_HISCONTRACT);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int idHisCon = rs.getInt("idHisCon");
                    String typeCon = rs.getString("type");
                    String signDay = rs.getString("signDay");
                    if (signDay == null) {
                        signDay = "0000-00-00";
                    }
                    String expDay = rs.getString("expDay");
                    if (expDay == null) {
                        expDay = "0000-00-00";
                    }
                    String nameEmp = rs.getString("name");
                    String filePath = rs.getString("filePath");
                    int status = rs.getInt("status");
                    ContractDTO con = new ContractDTO(idHisCon, typeCon, signDay.substring(0, 10), expDay.substring(0, 10), filePath, nameEmp, status);
                    list.add(con);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public static ArrayList<ContractDTO> getListHisConByIdEmp(String idEmp) throws SQLException {
        ArrayList<ContractDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_HISCONTRACT_BY_IDEMP);
                ptm.setString(1, idEmp);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int idHisCon = rs.getInt("idHisCon");
                    String typeCon = rs.getString("type");
                    String signDay = rs.getString("signDay");
                    if (signDay == null) {
                        signDay = "0000-00-00";
                    }
                    String expDay = rs.getString("expDay");
                    if (expDay == null) {
                        expDay = "0000-00-00";
                    }
                    String nameEmp = rs.getString("name");
                    String filePath = rs.getString("filePath");
                    int status = rs.getInt("status");
                    ContractDTO con = new ContractDTO(idHisCon, typeCon, signDay.substring(0, 10), expDay.substring(0, 10), filePath, nameEmp, status);
                    list.add(con);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
}
