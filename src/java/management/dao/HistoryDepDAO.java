/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import management.dto.HistoryDepDTO;
import management.utils.DBUtils;

/**
 *
 * @author lehon
 */
public class HistoryDepDAO {

    private static final String CHANGE_STATUS_OLD_DEP = "update HistoryDep\n"
            + "set status = 0\n"
            + "where idEmp = ? and depNum = ? and status = 1";

    private static final String INSERT_NEW_HIS_DEP = "INSERT INTO HistoryDep(idEmp, depNum, deliveryDate, exactDate, status)"
            + " VALUES (?, ?, ?, ?, ?)";

    private static final String LIST_ALL_HIS_DEP = "select idHisDep, hd.idEmp, e.name, hd.depNum, d.depName, deliveryDate, hd.exactDate, status\n"
            + "from Employee as e, HistoryDep as hd, Department as d\n"
            + "where e.idEmp = hd.idEmp and hd.depNum = d.depNum";
    private static final String LIST_ALL_FILTER = "select idHisDep, hd.idEmp, e.name, hd.depNum, d.depName, deliveryDate, hd.exactDate, status\n"
            + "from Employee as e, HistoryDep as hd, Department as d\n"
            + "where e.idEmp = hd.idEmp and hd.depNum = d.depNum and e.name like ? and d.depName like ? and status like ?";
    private static Connection conn = null;
    private static PreparedStatement ptm = null;
    private static Statement st = null;
    private static ResultSet rs = null;

    //Get all history of change department
    public static ArrayList<HistoryDepDTO> listHisDep() throws SQLException {
        ArrayList<HistoryDepDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                st = conn.createStatement();
                rs = st.executeQuery(LIST_ALL_HIS_DEP);
                while (rs.next()) {
                    int id = rs.getInt("idHisDep");
                    int idemp = rs.getInt("idEmp");
                    String nameemp = rs.getString("name");
                    int iddep = rs.getInt("depNum");
                    String namedep = rs.getString("depName");
                    String deliveryDate = rs.getString("deliveryDate");

                    if (deliveryDate == null) {
                        deliveryDate = "0000-00-00";
                    }

                    String exactDate = rs.getString("exactDate");
                    if (exactDate == null) {
                        exactDate = "0000-00-00";
                    }

                    int status = rs.getInt("status");
                    HistoryDepDTO his = new HistoryDepDTO(id, idemp, nameemp, iddep, namedep, deliveryDate.substring(0, 10), exactDate.substring(0, 10), status);
                    list.add(his);

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

    //Update status of old department
    public static boolean updateDep(String idemp, int iddep) throws SQLException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHANGE_STATUS_OLD_DEP);
                ptm.setInt(1, Integer.parseInt(idemp));
                ptm.setInt(2, iddep);
                int result = ptm.executeUpdate();
                if (result > 0) {
                    return true;
                } else {
                    return false;
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

    //Insert history of new department
    public static boolean inserNewDep(String idemp, String iddep, Date exactDate) throws SQLException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                Date d = new Date(System.currentTimeMillis());
                ptm = conn.prepareStatement(INSERT_NEW_HIS_DEP);
                ptm.setInt(1, Integer.parseInt(idemp));
                ptm.setInt(2, Integer.parseInt(iddep));
                ptm.setDate(3, d);
                ptm.setDate(4, exactDate);
                ptm.setInt(5, 1);
                int result = ptm.executeUpdate();
                if (result > 0) {
                    return true;
                } else {
                    return false;
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

    public static ArrayList<HistoryDepDTO> listHisDepFilter(String empName, String depName, String status) throws SQLException {
        ArrayList<HistoryDepDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_ALL_FILTER);
                ptm.setString(1, "%" + empName + "%");
                ptm.setString(2, "%" + depName + "%");
                ptm.setString(3, "%" + status + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("idHisDep");
                    int idemp = rs.getInt("idEmp");
                    String nameemp = rs.getString("name");
                    int iddep = rs.getInt("depNum");
                    String namedep = rs.getString("depName");
                    String deliveryDate = rs.getString("deliveryDate");
                    if (deliveryDate == null) {
                        deliveryDate = "0000-00-00";
                    }

                    String exactDate = rs.getString("exactDate");
                    if (exactDate == null) {
                        exactDate = "0000-00-00";
                    }

                    int hisStatus = rs.getInt("status");
                    HistoryDepDTO his = new HistoryDepDTO(id, idemp, nameemp, iddep, namedep, deliveryDate.substring(0, 10), exactDate.substring(0, 10), hisStatus);
                    list.add(his);

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
