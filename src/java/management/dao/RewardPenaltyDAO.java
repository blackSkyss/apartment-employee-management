/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package management.dao;

import java.sql.Connection;
import java.sql.Date;
import management.utils.DBUtils;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import management.dto.RewardPenaltyDTO;

/**
 *
 * @author Admin
 */
public class RewardPenaltyDAO {

    private static String LIST_RP = "select r.idRP,e.idEmp,e.imgPath,e.name,e.gender,re.status,r.times,r.applicableDate,re.name as namere, r.reason,d.depName,r.idReg\n"
            + "            from Employee as e,HistoryDep as hd, Department as d, Position as p,HistoryPos as hp,  RewardAndPenalty as r, Regulation as re \n"
            + "            where e.idEmp = hd.idEmp and hd.depNum = d.depNum and r.idReg = re.idReg and e.idEmp = r.idEmp and e.idEmp = hp.idEmp and hp.idPos = p.idPos and hd.status =1 and hp.status = 1 and e.idEmp like ?";
    private static String LIST_RP_FOR_ALL = "select r.idRP,e.idEmp,e.imgPath,e.name,e.gender,re.status,r.times,r.applicableDate,re.name as namere, r.reason,d.depName,r.idReg\n" +
"            from Employee as e,HistoryDep as hd, Department as d,  RewardAndPenalty as r, Regulation as re\n" +
"            where e.idEmp = hd.idEmp and hd.depNum = d.depNum and r.idReg = re.idReg and e.idEmp = r.idEmp\n" +
"            and e.idEmp like ? and e.name like ? and d.depName like ? and hd.status = 1";
    private static String LIST_RP_NAME = "select r.idRP,e.idEmp,e.imgPath,e.name,e.gender,re.status,r.times,r.applicableDate,re.name as namere, r.reason,d.depName,r.idReg\n"
            + "from Employee as e, Department as d, Position as p, RewardAndPenalty as r, Regulation as re \n"
            + "where e.depNum = d.depNum and r.idReg = re.idReg and e.idEmp = r.idEmp and e.idPos = p.idPos and e.name like ?  ";

    private static String LIST_RP_NAMEEMP = "select r.idRP,e.idEmp,e.imgPath,e.name,e.gender,re.status,r.times,r.applicableDate,re.name as namere, r.reason,d.depName,r.idReg\n"
            + "from Employee as e, Department as d, Position as p, RewardAndPenalty as r, Regulation as re \n"
            + "where e.depNum = d.depNum and r.idReg = re.idReg and e.idEmp = r.idEmp and e.idPos = p.idPos and e.name like ? and e.idEmp like ? ";

    private static String UPDATE_RP = "update RewardAndPenalty "
            + "set idReg = ? ,times = ?, reason = ? \n"
            + "where idEmp = ? and idRP = ? ";

    private static String CREATE_NEW_RP = "INSERT INTO RewardAndPenalty(idReg,applicableDate,times,idEmp,reason)\n"
            + "VALUES(?, ?, ?, ?,?)";

    private static String DELETE_RP = "DELETE FROM RewardAndPenalty WHERE idEmp=?";

    //List all Reward & Penalty
    public static ArrayList<RewardPenaltyDTO> listrp(String keywordidemp) throws SQLException {
        ArrayList<RewardPenaltyDTO> listrp = new ArrayList<>();
        Connection cn = null;
        try {
            //buoc 1: mo ket noi
            cn = DBUtils.getConnection();
            //buoc 2: viet query va execute    
            if (cn != null) {
                PreparedStatement pst = cn.prepareStatement(LIST_RP);
                pst.setString(1, "%" + keywordidemp + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int idRP = rs.getInt("IDRp");
                        int idEmp = rs.getInt("IDEmp");
                        String imgPath = rs.getString("ImgPath");
                        String name = rs.getString("Name");
                        String gender = rs.getString("Gender");
                        int status = rs.getInt("Status");
                        int times = rs.getInt("Times");
                        Date applicableDate = rs.getDate("ApplicableDate");
                        String namere = rs.getString("Namere");
                        String reason = rs.getString("Reason");
                        String depName = rs.getString("DepName");
                        int idReg = rs.getInt("IDReg");
                        RewardPenaltyDTO rp = new RewardPenaltyDTO(idEmp, name, gender, imgPath, depName, idRP, reason, namere, status, times, applicableDate, idReg);
                        listrp.add(rp);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return listrp;
        }
    }

    //List all Reward & Penalty by Name
    public static ArrayList<RewardPenaltyDTO> listrpdep(String keywordname) throws SQLException {
        ArrayList<RewardPenaltyDTO> listrp = new ArrayList<>();
        Connection cn = null;
        try {
            //buoc 1: mo ket noi
            cn = DBUtils.getConnection();
            //buoc 2: viet query va execute    
            if (cn != null) {
                PreparedStatement pst = cn.prepareStatement(LIST_RP_NAME);
                pst.setString(1, "%" + keywordname + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int idRP = rs.getInt("IDRp");
                        int idEmp = rs.getInt("IDEmp");
                        String imgPath = rs.getString("ImgPath");
                        String name = rs.getString("Name");
                        String gender = rs.getString("Gender");
                        int status = rs.getInt("Status");
                        int times = rs.getInt("Times");
                        Date applicableDate = rs.getDate("ApplicableDate");
                        String namere = rs.getString("Namere");
                        String reason = rs.getString("Reason");
                        String depName = rs.getString("DepName");
                        int idReg = rs.getInt("IDReg");
                        RewardPenaltyDTO rp = new RewardPenaltyDTO(idEmp, name, gender, imgPath, depName, idRP, reason, namere, status, times, applicableDate, idReg);
                        listrp.add(rp);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return listrp;
        }
    }

    //Search all Reward & Penalty by Name and IDEmp
    public static ArrayList<RewardPenaltyDTO> listrpdepemp(String keywordname, String keywordidemp) throws SQLException {
        ArrayList<RewardPenaltyDTO> listrp = new ArrayList<>();
        Connection cn = null;
        try {
            //buoc 1: mo ket noi
            cn = DBUtils.getConnection();
            //buoc 2: viet query va execute    
            if (cn != null) {
                PreparedStatement pst = cn.prepareStatement(LIST_RP_NAMEEMP);
                pst.setString(1, "%" + keywordname + "%");
                pst.setString(2, "%" + keywordidemp + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int idRP = rs.getInt("IDRp");
                        int idEmp = rs.getInt("IDEmp");
                        String imgPath = rs.getString("ImgPath");
                        String name = rs.getString("Name");
                        String gender = rs.getString("Gender");
                        int status = rs.getInt("Status");
                        int times = rs.getInt("Times");
                        Date applicableDate = rs.getDate("ApplicableDate");
                        String namere = rs.getString("Namere");
                        String reason = rs.getString("Reason");
                        String depName = rs.getString("DepName");
                        int idReg = rs.getInt("IDReg");
                        RewardPenaltyDTO rp = new RewardPenaltyDTO(idEmp, name, gender, imgPath, depName, idRP, reason, namere, status, times, applicableDate, idReg);
                        listrp.add(rp);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return listrp;
        }
    }

    //Update Reward & Penalty
    public static boolean updateRP(int idReg, String times, int idEmp, String reason, int idRp) {
        Connection cn = null;
        try {
            //buoc 1: mo ket noi
            cn = (Connection) DBUtils.getConnection();
            //buoc 2: viet query va execute    
            if (cn != null) {
                PreparedStatement pst = cn.prepareStatement(UPDATE_RP);
                //gan data vao dau cham ?
                pst.setInt(1, idReg);
                pst.setString(2, times);
                pst.setString(3, reason);
                pst.setInt(4, idEmp);                
                pst.setInt(5, idRp);
                pst.executeUpdate();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    //Create New Reward & Penalty
    public static boolean createnewRP(int idReg, int times, int idEmp, String reason) {
        Connection cn = null;
        try {
            //buoc 1: mo ket noi
            cn = (Connection) DBUtils.getConnection();
            //buoc 2: viet query va execute    
            if (cn != null) {
                Date d = new Date(System.currentTimeMillis());
                PreparedStatement pst = cn.prepareStatement(CREATE_NEW_RP);
                pst.setInt(1, idReg);
                pst.setDate(2, d);
                pst.setInt(3, times);
                pst.setInt(4, idEmp);
                pst.setString(5, reason);
                pst.executeUpdate();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    //Delete Reward & Penalty
    public static boolean deleteRP(int idEmp) {
        Connection cn = null;
        try {
            //buoc 1: mo ket noi
            cn = (Connection) DBUtils.getConnection();
            //buoc 2: viet query va execute    
            if (cn != null) {
                PreparedStatement pst = cn.prepareStatement(DELETE_RP);
                pst.setInt(1, idEmp);
                pst.executeUpdate();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    public static ArrayList<RewardPenaltyDTO> listRpForAll(String idEmpText, String nameEmp, String depName) throws SQLException {
        ArrayList<RewardPenaltyDTO> listrp = new ArrayList<>();
        Connection cn = null;
        try {
            //buoc 1: mo ket noi
            cn = DBUtils.getConnection();
            //buoc 2: viet query va execute    
            if (cn != null) {
                PreparedStatement pst = cn.prepareStatement(LIST_RP_FOR_ALL);
                pst.setString(1, "%" + idEmpText + "%");
                pst.setString(2, "%" + nameEmp + "%");
                pst.setString(3, "%" + depName + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int idRP = rs.getInt("IDRp");
                        int idEmp = rs.getInt("IDEmp");
                        String imgPath = rs.getString("ImgPath");
                        String name = rs.getString("Name");
                        String gender = rs.getString("Gender");
                        int status = rs.getInt("Status");
                        int times = rs.getInt("Times");
                        Date applicableDate = rs.getDate("ApplicableDate");
                        String namere = rs.getString("Namere");
                        String reason = rs.getString("Reason");
                        String depName1 = rs.getString("DepName");
                        int idReg = rs.getInt("IDReg");
                        RewardPenaltyDTO rp = new RewardPenaltyDTO(idEmp, name, gender, imgPath, depName1, idRP, reason, namere, status, times, applicableDate, idReg);
                        listrp.add(rp);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return listrp;
        }
    }
}
