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
import java.util.HashMap;
import management.dto.DepartmentDTO;
import management.regex.RegexDep;
import management.utils.DBUtils;

/**
 *
 * @author lehon
 */
public class DepartmentDAO {

    private static final String LIST_DEP = "select depNum, depName, description, location, dateCreate, creator\n"
            + "from Department";

    private static final String CHECK_EXIST = "select depName\n"
            + "from Department\n"
            + "where depName = ?";

    private static final String CREATE_NEW_DEP = "INSERT INTO Department (depName, description, location, dateCreate, creator)"
            + " VALUES (?, ?, ?, ?, ?)";

    private static final String UPDATE_DEP = "update Department\n"
            + "set depName = ?, description = ?, location = ?\n"
            + "where depNum = ?";

    private static final String GET_NAME_DEP = "select depName\n"
            + "from Department";

    private static final String GET_DEPNAME_BY_ID = "select depName\n"
            + "from Department\n"
            + "where depNum = ?";

    private static final String GET_DEP_BY_ID = "select depNum, depName, description, location, dateCreate, creator\n"
            + "from Department\n"
            + "where depNum = ?";

    private static final String GET_IDDEP_BY_NAME = "select depNum\n"
            + "from Department\n"
            + "where depName = ?";

    private static final String GET_DEP_BY_LOCATION = "select depNum, depName, description, location, dateCreate, creator\n"
            + "from Department\n"
            + "where location = ?";

    private static final String GET_DEP_FOR_ALL = "select depNum, depName, description, location, dateCreate, creator\n"
            + "from Department\n"
            + "where location like ? and depName like ?";

    private static final String GET_DEP_BY_EMPID = "Select top 1 dp.depNum , dp.depName, dp.description, dp.location, dp.dateCreate, dp.creator, hd.deliveryDate\n"
            + "From HistoryDep hd, Employee e, Department dp\n"
            + "Where hd.idEmp = e.idEmp and hd.depNum = dp.depNum and hd.idEmp = ?\n"
            + "Order by hd.deliveryDate desc";

    private static final String CHECK_EXIST_NAME_DEP = "select depName\n"
            + "from  Department \n"
            + "where depName not in(\n"
            + "select depName\n"
            + "from Department\n"
            + "where depName = ?)";
    private static final String GET_NUMBER_OF_EMP = "select d.depNum,count(e.idEmp) number\n"
            + "            from Employee as e, HistoryDep as hd, Department as d, HistoryPos as hp, Position as p, Contract as c, HistoryContract as hc\n"
            + "            where e.idEmp = hd.idEmp and hd.depNum = d.depNum and\n"
            + "            e.idEmp = hp.idEmp and hp.idPos = p.idPos and \n"
            + "            hd.status = 1 and hp.status = 1 and c.idContract=hc.idContract and hc.idEmp=e.idEmp and\n"
            + "            statusLog = 1 and role = 0 and hc.status = 1\n"
            + "            group by d.depNum";
    private static Connection conn = null;
    private static PreparedStatement ptm = null;
    private static Statement st = null;
    private static ResultSet rs = null;

    //List all department to see
    public static ArrayList<DepartmentDTO> listDep() throws SQLException {
        ArrayList<DepartmentDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                st = conn.createStatement();
                rs = st.executeQuery(LIST_DEP);
                while (rs.next()) {
                    int id = rs.getInt("depNum");
                    String depName = rs.getString("depName");
                    String description = rs.getString("description");
                    String location = rs.getString("location");
                    Date date = rs.getDate("dateCreate");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String dateCreate = dateFormat.format(date);
                    String creator = rs.getString("creator");
                    DepartmentDTO dep = new DepartmentDTO(id, depName, description, location, dateCreate, creator);
                    list.add(dep);
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

    //Check department is exists or not(Create)
    public static boolean checkDepExist(String name) throws SQLException {
        String names = RegexDep.removeAllTrim(name);
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                st = conn.createStatement();
                rs = st.executeQuery(GET_NAME_DEP);
                while (rs.next()) {
                    String nameDep = rs.getString("depName");
                    if (names.equals(RegexDep.removeAllTrim(nameDep))) {
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
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }

    //Check department is exists or not(Update)
    public static boolean checkDepExistUpdate(String oldname, String newname) throws SQLException {
        String names = RegexDep.removeAllTrim(newname);
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_EXIST_NAME_DEP);
                ptm.setString(1, oldname);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String nameDep = rs.getString("depName");
                    if (names.equals(RegexDep.removeAllTrim(nameDep))) {
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
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }

    //Insert new department
    public static boolean inserNewDep(String depname, String des, String location, String creator) throws SQLException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                Date d = new Date(System.currentTimeMillis());
                ptm = conn.prepareStatement(CREATE_NEW_DEP);
                ptm.setString(1, depname);
                ptm.setString(2, des);
                ptm.setString(3, location);
                ptm.setDate(4, d);
                ptm.setString(5, creator);
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

    //Update department
    public static boolean updateDep(String name, String des, String location, String depnum) throws SQLException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_DEP);
                ptm.setString(1, name);
                ptm.setString(2, des);
                ptm.setString(3, location);
                ptm.setInt(4, Integer.parseInt(depnum));
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

    //Get name of department by id
    public static String getNameDepByID(String id) throws SQLException {
        String name = "";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_DEPNAME_BY_ID);
                ptm.setInt(1, Integer.parseInt(id));
                rs = ptm.executeQuery();
                if (rs != null && rs.next()) {
                    name = rs.getString("depName");
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
        return name;

    }

    //Get department by depNum
    public static DepartmentDTO getDepByDepnum(String id) throws SQLException {
        DepartmentDTO dep = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_DEP_BY_ID);
                ptm.setInt(1, Integer.parseInt(id));
                rs = ptm.executeQuery();
                if (rs != null && rs.next()) {
                    int depNum = rs.getInt("depNum");
                    String depName = rs.getString("depName");
                    String description = rs.getString("description");
                    String location = rs.getString("location");
                    Date date = rs.getDate("dateCreate");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String dateCreate = dateFormat.format(date);
                    String creator = rs.getString("creator");
                    dep = new DepartmentDTO(depNum, depName, description, location, dateCreate, creator);
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
        return dep;
    }

    //Get depNum by depname
    public static int getDepNumByName(String name) throws SQLException {
        int id = 0;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_IDDEP_BY_NAME);
                ptm.setString(1, name);
                rs = ptm.executeQuery();
                if (rs != null && rs.next()) {
                    id = rs.getInt("depNum");
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
        return id;

    }

    public static ArrayList<DepartmentDTO> getDepNumByLocation(String location) throws SQLException {
        ArrayList<DepartmentDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_DEP_BY_LOCATION);
                ptm.setString(1, location);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int depNum = rs.getInt("depNum");
                    String depName = rs.getString("depName");
                    String description = rs.getString("description");
                    String locationDep = rs.getString("location");
                    Date date = rs.getDate("dateCreate");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String dateCreate = dateFormat.format(date);
                    String creator = rs.getString("creator");
                    DepartmentDTO dep = new DepartmentDTO(depNum, depName, description, locationDep, dateCreate, creator);
                    list.add(dep);
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

    public static ArrayList<DepartmentDTO> getDepNumForAll(String location, String nameDep) throws SQLException {
        ArrayList<DepartmentDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_DEP_FOR_ALL);
                ptm.setString(1, "%" + location + "%");
                ptm.setString(2, "%" + nameDep + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int depNum = rs.getInt("depNum");
                    String depName = rs.getString("depName");
                    String description = rs.getString("description");
                    String locationDep = rs.getString("location");
                    Date date = rs.getDate("dateCreate");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String dateCreate = dateFormat.format(date);
                    String creator = rs.getString("creator");
                    DepartmentDTO dep = new DepartmentDTO(depNum, depName, description, locationDep, dateCreate, creator);
                    list.add(dep);
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

    public static DepartmentDTO getDepartmentByEmpId(String empID) throws SQLException {
        DepartmentDTO dep = new DepartmentDTO();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_DEP_BY_EMPID);
                ptm.setString(1, empID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int depNum = rs.getInt("depNum");
                    String depName = rs.getString("depName");
                    String description = rs.getString("description");
                    String locationDep = rs.getString("location");
                    Date date = rs.getDate("dateCreate");
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String dateCreate = dateFormat.format(date);
                    String creator = rs.getString("creator");
                    dep = new DepartmentDTO(depNum, depName, description, locationDep, dateCreate, creator);
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
        return dep;
    }

    //Check depname exits
    public static ArrayList<String> GetDepName(String depname) throws SQLException {
        ArrayList<String> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_EXIST_NAME_DEP);
                ptm.setString(1, depname);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String name = rs.getString("depName");
                    list.add(name);
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

    public static HashMap<String, String> getEmpOfDep() throws SQLException {
        HashMap<String, String> list = new HashMap<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                st = conn.createStatement();
                rs = st.executeQuery(GET_NUMBER_OF_EMP);
                while (rs.next()) {
                    String depNum = rs.getString("depNum");
                    String number = rs.getString("number");
                    list.put(depNum, number);
                }
            }
        } catch (Exception e) {
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
