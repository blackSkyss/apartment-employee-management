/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import management.dto.RegulationDTO;
import management.utils.DBUtils;

/**
 *
 * @author lehon
 */
public class RegulationDAO {

    private static final String LIST_REG = "select idReg, name, status\n"
            + "from Regulation";
    private static final String UPDATE_REG = "Update [dbo].[Regulation]\n"
            + "Set [name] = ? , [status] = ?\n"
            + "where [idReg] = ?";
    private static final String CREATE_REG = "INSERT INTO [dbo].[Regulation]([name],[status])\n"
            + "VALUES (?,?)";
    private static final String LIST_REG_BY_ID = "select idReg, name, status\n"
            + "from Regulation\n"
            + "where status = ?";
    private static Connection conn = null;
    private static PreparedStatement ptm = null;
    private static Statement st = null;
    private static ResultSet rs = null;

    //List all regulation
    public static ArrayList<RegulationDTO> listReg() throws SQLException {
        ArrayList<RegulationDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                st = conn.createStatement();
                rs = st.executeQuery(LIST_REG);
                while (rs.next()) {
                    int idReg = rs.getInt("idReg");
                    String name = rs.getString("name");
                    int status = rs.getInt("status");
                    RegulationDTO reg = new RegulationDTO(idReg, name, status);
                    list.add(reg);
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

    public static boolean updateReg(int idReg, String nameReg, int status) throws SQLException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_REG);
                ptm.setString(1, nameReg);
                ptm.setInt(2, status);
                ptm.setInt(3, idReg);
                int rs = ptm.executeUpdate();
                if (rs > 0) {
                    return true;
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
        return false;
    }

    public static boolean createReg(String nameReg, int status) throws SQLException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATE_REG);
                ptm.setString(1, nameReg);
                ptm.setInt(2, status);
                int rs = ptm.executeUpdate();
                if (rs > 0) {
                    return true;
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
        return false;
    }
    public static ArrayList<RegulationDTO> listRegById(String idReg) throws SQLException {
        ArrayList<RegulationDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_REG_BY_ID);
                ptm.setString(1, idReg);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int IDReg = rs.getInt("idReg");
                    String name = rs.getString("name");
                    int status = rs.getInt("status");
                    RegulationDTO reg = new RegulationDTO(IDReg, name, status);
                    list.add(reg);
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
