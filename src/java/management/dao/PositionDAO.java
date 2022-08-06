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
import management.dto.EmployeeDTO;
import management.dto.PositionDTO;
import management.regex.RegexDep;
import management.utils.DBUtils;

/**
 *
 * @author BachLe
 */
public class PositionDAO {

    private static final String SHOW_POSITION = "SELECT idPos, posName,description, creator, dateCreated FROM Position";
    private static final String UPDATE_POSITION = " UPDATE Position\n"
            + "SET posName = ?, description =?\n"
            + "WHERE idPos = ?";
    private static final String GET_NAME_POS = " SELECT posName from Position";
    private static final String LIST_POS = "SELECT idPos, posName FROM Position";
    private static final String CREATE_POSITION = "INSERT INTO Position (posName, description, creator, dateCreated)\n"
            + "  values(?, ?, ?, ?);";
    private static final String CHANGE_POSITION = "UPDATE Employee SET idPos = ? WHERE idEmp = ?";

    private static final String LIST_EMP_POS = "select e.idEmp, e.imgPath, e.name, e.gender, e.dob, d.depName, p.posName, p.idPos\n"
            + "from Employee as e, HistoryDep as hd, Department as d, HistoryPos as hp, Position as p, Contract as c, HistoryContract as hc\n"
            + "where e.idEmp = hd.idEmp and hd.depNum = d.depNum and\n"
            + "e.idEmp = hp.idEmp and hp.idPos = p.idPos and \n"
            + "hd.status = 1 and hp.status = 1 and c.idContract=hc.idContract and hc.idEmp=e.idEmp and\n"
            + "statusLog = 1 and role = 0 and hc.status = 1\n"
            + "order by idEmp ASC";

    private static final String SEARCH_PRO = "SELECT e.idEmp, e.imgPath, e.name, e.gender, e.dob, d.depName, p.posName, p.idPos from Employee as e, HistoryDep as hd, Department as d, HistoryPos as hp, Position as p, Contract as c, HistoryContract as hc\n"
            + "where e.idEmp = hd.idEmp and hd.depNum = d.depNum and\n"
            + "e.idEmp = hp.idEmp and hp.idPos = p.idPos and \n"
            + "hd.status = 1 and hp.status = 1 and c.idContract=hc.idContract and hc.idEmp=e.idEmp and\n"
            + "statusLog = 1 and role = 0 and hc.status = 1 and d.depName like ? and p.posName like ? and e.name like ?\n"
            + "order by idEmp ASC";
    private static final String CHECK_POSITION = "select e.idEmp, e.name, d.depNum, p.posName\n"
            + "from Employee as e, HistoryDep as hd, Department as d, HistoryPos as hp, Position as p\n"
            + "where e.idEmp = hd.idEmp and hd.depNum = d.depNum and e.idEmp = hp.idEmp and hp.idPos = p.idPos\n"
            + "and e.role = 0 and hp.status = 1 and hd.status = 1 and d.depName like ? and p.idPos = 1";
    private static Connection cn = null;
    private static PreparedStatement ptm = null;
    private static Statement st = null;
    private static ResultSet rs = null;

    public static ArrayList<PositionDTO> listPosition() throws SQLException {
        ArrayList<PositionDTO> listPosition = new ArrayList<>();
        try {
            cn = DBUtils.getConnection();
            st = cn.createStatement();
            rs = st.executeQuery(SHOW_POSITION);
            while (rs != null && rs.next()) {
                int idPos = rs.getInt("idPos");
                String posName = rs.getString("posName");
                String description = rs.getString("description");
                String creator = rs.getString("creator");
                Date dateCreated = rs.getDate("dateCreated");
                PositionDTO p = new PositionDTO(idPos, posName, description, creator, dateCreated);
                listPosition.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return listPosition;
    }

    public static boolean inserNewPos(String posName, String des, String creator) throws SQLException {
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                Date d = new Date(System.currentTimeMillis());
                ptm = cn.prepareStatement(CREATE_POSITION);
                ptm.setString(1, posName);
                ptm.setString(2, des);
                ptm.setString(3, creator);
                ptm.setDate(4, d);
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
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }

    public static boolean updatePosition(String posName, String description, int idPos) throws SQLException {
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                ptm = cn.prepareStatement(UPDATE_POSITION);
                ptm.setString(1, posName);
                ptm.setString(2, description);
                ptm.setInt(3, idPos);
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
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }

    public static boolean changePosition(int idPos, int idEmp) throws SQLException {
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                ptm = cn.prepareStatement(CHANGE_POSITION);
                ptm.setInt(1, idPos);
                ptm.setInt(2, idEmp);
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
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }

    public static ArrayList<EmployeeDTO> listEmpPos() throws SQLException {
        ArrayList<EmployeeDTO> listEmpPos = new ArrayList<>();
        try {
            cn = DBUtils.getConnection();
            st = cn.createStatement();
            rs = st.executeQuery(LIST_EMP_POS);
            while (rs != null && rs.next()) {
                int idEmp = rs.getInt("idEmp");
                String imgPath = rs.getString("imgPath");
                String name = rs.getString("name");
                String gender = rs.getString("gender");
                String dob = rs.getString("dob");
                String depName = rs.getString("depName");
                String posName = rs.getString("posName");
                int idPos = rs.getInt("idPos");
                EmployeeDTO e = new EmployeeDTO(idEmp, name, gender, dob, imgPath, depName, posName, idPos);
                listEmpPos.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return listEmpPos;
    }

    public static ArrayList<PositionDTO> listPos() throws SQLException {
        ArrayList<PositionDTO> listPos = new ArrayList<>();
        try {
            cn = DBUtils.getConnection();
            st = cn.createStatement();
            rs = st.executeQuery(LIST_POS);
            while (rs != null && rs.next()) {
                int idPos = rs.getInt("idPos");
                String posName = rs.getString("posName");
                PositionDTO p = new PositionDTO(idPos, posName);
                listPos.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return listPos;
    }

    //List all promote and demote filter 
    public static ArrayList<EmployeeDTO> filterpro(String depname, String posname, String empname) throws SQLException {
        ArrayList<EmployeeDTO> list = new ArrayList<>();
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                ptm = cn.prepareStatement(SEARCH_PRO);
                ptm.setString(1, "%" + depname + "%");
                ptm.setString(2, "%" + posname + "%");
                ptm.setString(3, "%" + empname + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int idEmp = rs.getInt("idEmp");
                    String imgPath = rs.getString("imgPath");
                    String name = rs.getString("name");
                    String gender = rs.getString("gender");
                    String dob = rs.getString("dob");
                    String depName = rs.getString("depName");
                    String posName = rs.getString("posName");
                    int idPos = rs.getInt("idPos");
                    EmployeeDTO e = new EmployeeDTO(idEmp, name, gender, dob, imgPath, depName, posName, idPos);
                    list.add(e);
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
            if (cn != null) {
                cn.close();
            }
        }
        return list;
    }

    public static boolean checkPosExist(String name) throws SQLException {
        String posName = RegexDep.removeAllTrim(name);
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                st = cn.createStatement();
                rs = st.executeQuery(GET_NAME_POS);
                while (rs.next()) {
                    String positionName = rs.getString("posName");
                    if (posName.equals(RegexDep.removeAllTrim(positionName))) {
                        return true;
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
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }

    public static boolean checkPosMana(String depName) throws SQLException {
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                ptm = cn.prepareStatement(CHECK_POSITION);
                ptm.setString(1, depName);
                rs = ptm.executeQuery();
                if (rs.next()) {
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
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }
}
