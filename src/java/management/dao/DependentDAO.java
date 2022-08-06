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
import management.dto.DependentDTO;
import management.utils.DBUtils;

/**
 *
 * @author AD
 */
public class DependentDAO {

    private static Connection cn = null;
    private static PreparedStatement pst = null;
    private static Statement st = null;
    private static ResultSet rs = null;
    private static final String LIST_DEPENDENT = "SELECT  e.idEmp, e.name as 'Employee Name', d.idDepen, d.name as 'Dependent Name', d.gender, d.dob, d.relationship FROM Dependent as d, Employee as e \n"
            + "WHERE d.idEmp = e.idEmp";
    private static final String LIST_DEPENDENT_FOR_ALL = "SELECT  e.idEmp, e.name as 'Employee Name', d.idDepen, d.name as 'Dependent Name', d.gender, d.dob, d.relationship FROM Dependent as d, Employee as e\n"
            + "WHERE d.idEmp = e.idEmp and e.name like ? and e.idEmp like ?";
    private static final String UPDATE_DEPENDENT = "UPDATE Dependent\n"
            + "SET name = ?, gender =?, dob =? , relationship =?\n"
            + "WHERE idEmp = ? AND idDepen = ?;";
    private static final String OBJECT_DEPENDENT = "SELECT e.idEmp, e.name as 'Employee Name', d.idDepen, d.name as 'Dependent Name', d.gender, d.dob, d.relationship FROM Dependent as d, Employee as e \n"
            + "WHERE e.idEmp = ? AND d.idDepen = ?";
    private static final String INSERT_DEPENDENT = "INSERT INTO Dependent(name,  gender, dob,relationship, idEmp)\n"
            + "  VALUES(?,?,?,?,?)";
    
     private static final String CHECK_DEPENDENT_DATE = "DECLARE @today date, @depenDate date;\n"
            + "            SET @today = CAST( GETDATE() AS date);\n"
            + "            SET @depenDate = ?;\n"
            + "	           IF @depenDate <= @today and @depenDate >= '1922'\n"
            + "            SELECT 'true' as flag\n"
            + "            ELSE SELECT 'false' as flag";

    public static ArrayList<DependentDTO> listDependent() throws SQLException {
        ArrayList<DependentDTO> listDependent = new ArrayList<>();
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                st = cn.createStatement();
                rs = st.executeQuery(LIST_DEPENDENT);
            }
            while (rs != null && rs.next()) {
                int idEmp = rs.getInt("idEmp");
                String empName = rs.getString("Employee Name");
                int idDepen = rs.getInt("idDepen");
                String depenName = rs.getString("Dependent Name");
                String gender = rs.getString("gender");
                Date dob = rs.getDate("dob");
                String relationship = rs.getString("relationship");
                DependentDTO dependent = new DependentDTO(idDepen, depenName, gender, dob, relationship, idEmp, empName);
                listDependent.add(dependent);
            }
        } catch (Exception e) {
            e.getMessage();
        } finally {
            if (cn != null) {
                cn.close();
            }
            if (st != null) {
                st.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return listDependent;
    }

    public static boolean updateDependent(String name, String gender, String dob, String relationship, int idEmp, int idDepen) throws SQLException {
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                pst = cn.prepareStatement(UPDATE_DEPENDENT);
                pst.setString(1, name);
                pst.setString(2, gender);
                pst.setString(3, dob);
                pst.setString(4, relationship);
                pst.setInt(5, idEmp);
                pst.setInt(6, idDepen);
                int result = pst.executeUpdate();
                if (result > 0) {
                    return true;
                } else {
                    return false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                cn.close();
            }
            if (pst != null) {
                pst.close();
            }
        }
        return false;
    }

    public static ArrayList<DependentDTO> depenObject(int idEmp, int idDepen) throws SQLException {
        ArrayList<DependentDTO> depenObject = new ArrayList<>();
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                pst = cn.prepareStatement(OBJECT_DEPENDENT);
                pst.setInt(1, idEmp);
                pst.setInt(2, idDepen);
                rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    idEmp = rs.getInt("idEmp");
                    String empName = rs.getString("Employee Name");
                    idDepen = rs.getInt("idDepen");
                    String depenName = rs.getString("Dependent Name");
                    String gender = rs.getString("gender");
                    Date dob = rs.getDate("dob");
                    String relationship = rs.getString("relationship");
                    DependentDTO oj = new DependentDTO(idDepen, depenName, gender, dob, relationship, idEmp, empName);
                    depenObject.add(oj);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                cn.close();
            }
            if (pst != null) {
                pst.close();
            }
        }
        return depenObject;

    }

    public static boolean insertDependent(String name, String gender, String dob, String relationship, String idEmp) throws SQLException {
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                pst = cn.prepareStatement(INSERT_DEPENDENT);
                pst.setString(1, name);
                pst.setString(2, gender);
                pst.setString(3, dob);
                pst.setString(4, relationship);
                pst.setString(5, idEmp);
                int result = pst.executeUpdate();
                if (result > 0) {
                    return true;
                } else {
                    return false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                cn.close();
            }
            if (pst != null) {
                pst.close();
            }
        }
        return false;
    }

    public static ArrayList<DependentDTO> listDependentForAll(String empId, String nameEmp) throws SQLException {
        ArrayList<DependentDTO> listDependent = new ArrayList<>();
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                pst = cn.prepareStatement(LIST_DEPENDENT_FOR_ALL);
                pst.setString(1, "%" + nameEmp + "%");
                pst.setString(2, "%" + empId + "%");
                rs = pst.executeQuery();
            }
            while (rs != null && rs.next()) {
                int idEmp = rs.getInt("idEmp");
                String empName = rs.getString("Employee Name");
                int idDepen = rs.getInt("idDepen");
                String depenName = rs.getString("Dependent Name");
                String gender = rs.getString("gender");
                Date dob = rs.getDate("dob");
                String relationship = rs.getString("relationship");
                DependentDTO dependent = new DependentDTO(idDepen, depenName, gender, dob, relationship, idEmp, empName);
                listDependent.add(dependent);
            }
        } catch (Exception e) {
            e.getMessage();
        } finally {
            if (cn != null) {
                cn.close();
            }
            if (st != null) {
                st.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return listDependent;
    }
    
     public static boolean checkDepenDate(String DepenDate) throws SQLException {
        String check = "";
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                pst = cn.prepareStatement(CHECK_DEPENDENT_DATE);
                pst.setString(1, DepenDate);
                rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    check = rs.getString("flag");
                    if (check.equals("true")) {
                        return true;
                    } else {
                        return false;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }
}
