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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import management.dto.HistoryPositionDTO;
import management.utils.DBUtils;

/**
 *
 * @author AD
 */
public class HistoryPosDAO {

    private static Connection conn = null;
    private static PreparedStatement ptm = null;
    private static Statement st = null;
    private static ResultSet rs = null;
    private static final String INSERT_NEW_HIS_POS = "INSERT INTO HistoryPos(idEmp, idPos, deliveryDate,exactDate, status, type)\n"
            + "VALUES (?, ?, ?, ?, ?, ?)";
    private static final String CHANGE_STATUS_OLD_POS = "update HistoryPos\n"
            + "set status = 0\n"
            + "where idEmp = ? and idPos = ? and status = 1";

    private static final String LIST_ALL_HIS_POS = " SELECT hp.idHisPos,e.idEmp, e.name, p.posName, hp.deliveryDate,hp.exactDate, hp.type, hp.status \n"
            + "FROM Employee as e, Position as p, HistoryPos as hp\n"
            + "WHERE e.idEmp = hp.idEmp AND p.idPos = hp.idPos and e.role = 0";
    private static final String LIST_HIS_POS_FOR_EMP = "SELECT hp.idHisPos, e.name, p.posName, hp.deliveryDate, hp.exactDate, hp.type, hp.status \n"
            + "FROM Employee as e, Position as p, HistoryPos as hp\n"
            + "WHERE e.idEmp = hp.idEmp AND p.idPos = hp.idPos and hp.idEmp = ?";
    private static final String SEARCH_HISPOS = " SELECT hp.idHisPos, e.idEmp, e.name, p.posName, hp.deliveryDate,hp.exactDate, hp.type, hp.status \n"
            + "FROM Employee as e, Position as p, HistoryPos as hp, Contract as c, HistoryContract as hc\n"
            + "WHERE e.idEmp = hp.idEmp AND p.idPos = hp.idPos and c.idContract=hc.idContract and hc.idEmp=e.idEmp and e.role = 0 and hc.status = 1\n"
            + "and hp.type like ? and hp.status like ? and e.name like ? \n"
            + "order by idEmp ASC";

    public static boolean insertNewPos(int idEmp, Date exactDate, int idPos, int type) throws SQLException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                Date d = new Date(System.currentTimeMillis());
                ptm = conn.prepareStatement(INSERT_NEW_HIS_POS);
                ptm.setInt(1, idEmp);
                ptm.setInt(2, idPos);
                ptm.setDate(3, d);
                ptm.setDate(4, exactDate);
                ptm.setInt(5, 1);
                ptm.setInt(6, type);
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

    public static boolean updatePos(int idEmp, int idPos) throws SQLException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHANGE_STATUS_OLD_POS);
                ptm.setInt(1, idEmp);
                ptm.setInt(2, idPos);
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

    public static ArrayList<HistoryPositionDTO> listHisPos() throws SQLException {
        ArrayList<HistoryPositionDTO> listHisPos = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                st = conn.createStatement();
                rs = st.executeQuery(LIST_ALL_HIS_POS);
                while (rs.next()) {
                    int idHisPos = rs.getInt("idHisPos");
                    int idEmp = rs.getInt("idEmp");
                    String nameEmp = rs.getString("name");
                    String posName = rs.getString("posName");
                    String deliveryDate = rs.getString("deliveryDate");
                    if (deliveryDate == null) {
                        deliveryDate = "0000-00-00";
                    }
                    String exactDate = rs.getString("exactDate");
                    if (exactDate == null) {
                        exactDate = "0000-00-00";
                    }
                    int type = rs.getInt("type");
                    int status = rs.getInt("status");
                    HistoryPositionDTO his = new HistoryPositionDTO(idHisPos, idEmp, nameEmp, posName, deliveryDate.substring(0, 10), exactDate.substring(0, 10), status, type);
                    listHisPos.add(his);

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
        return listHisPos;
    }

    //List all contract filter 
    public static ArrayList<HistoryPositionDTO> filterHisPo(String typehispos, String statushispos, String empname) throws SQLException {
        ArrayList<HistoryPositionDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_HISPOS);
                ptm.setString(1, "%" + typehispos + "%");
                ptm.setString(2, "%" + statushispos + "%");
                ptm.setString(3, "%" + empname + "%");
                rs = ptm.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int idHisPos = rs.getInt("idHisPos");
                        int idEmp = rs.getInt("idEmp");
                        String nameEmp = rs.getString("name");
                        String posName = rs.getString("posName");
                        String deliveryDate = rs.getString("deliveryDate");
                        String exactDate = rs.getString("exactDate");
                        int type = rs.getInt("type");
                        int status = rs.getInt("status");
                        HistoryPositionDTO his = new HistoryPositionDTO(idHisPos, idEmp, nameEmp, posName, deliveryDate, exactDate, status, type);
                        list.add(his);
                    }
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

    public static ArrayList<HistoryPositionDTO> listHisPosEmp(String empID) throws SQLException {
        ArrayList<HistoryPositionDTO> listHisPos = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_HIS_POS_FOR_EMP);
                ptm.setString(1, empID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int idHisPos = rs.getInt("idHisPos");
                    String nameEmp = rs.getString("name");
                    String posName = rs.getString("posName");
                    Date date = rs.getDate("deliveryDate");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String deliveryDate = dateFormat.format(date);
                    String exactDate = rs.getString("exactDate");
                    int type = rs.getInt("type");
                    int status = rs.getInt("status");
                    HistoryPositionDTO his = new HistoryPositionDTO(idHisPos, nameEmp, posName, deliveryDate, exactDate, status, type);
                    listHisPos.add(his);

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
        return listHisPos;
    }
}
