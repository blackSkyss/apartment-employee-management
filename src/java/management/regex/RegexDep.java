/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.regex;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import management.dao.DepartmentDAO;

/**
 *
 * @author lehon
 */
public class RegexDep {

    //check name dep
    public static boolean checkDepName(String name) {

        boolean check = name.matches("[a-zA-Z][a-zA-Z ]*");
        if ((name.length() > 30 || name.length() < 1) || (check == false)) {
            return false;
        }
        return true;
    }

    //check exist
    public static String removeAllTrim(String name) {
        return name.replaceAll("\\s\\s+", " ").trim().toLowerCase();
    }

    //check description
    public static boolean checkDepDes(String des) {
        if (des.length() < 1 || des.length() > 40) {
            return false;
        }
        return true;
    }
    
     public static boolean checkPosDes(String des) {
        if (des.length() < 1 || des.length() > 100) {
            return false;
        }
        return true;
    }

    //location
    public static boolean checkDepLoc(String location) {
        if (location.length() < 1 || location.length() > 10) {
            return false;
        }
        return true;
    }

    //check field null of department
    public static boolean checkDepFieldNull(String name, String des, String loc) {
        if (name.equals("") || name == null || des.equals("") || des == null || loc.equals("") || loc == null) {
            return true;
        }
        return false;
    }

    //check exist of department create
    public static boolean checkExistDep(String name) {
        try {
            if (DepartmentDAO.checkDepExist(name)) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegexDep.class.getName()).log(Level.SEVERE, null, ex);
        }

        return true;
    }

    //check exist of department update
    public static boolean checkExistDepUpdate(String oldname, String newname) {
        try {
            if (DepartmentDAO.checkDepExistUpdate(oldname, newname)) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegexDep.class.getName()).log(Level.SEVERE, null, ex);
        }

        return true;
    }

    //check validation of all field create
    public static boolean checkDepValidation(String name, String des, String location) {
        if (checkDepName(name)
                && checkDepDes(des)
                && checkDepLoc(location)
                && checkExistDep(name)) {
            return true;
        }
        return false;
    }

    //check validation of all field update
    public static boolean checkDepValidationUpdate(String oldname, String newname, String des, String location) {
        if (checkDepName(newname)
                && checkDepDes(des)
                && checkDepLoc(location)
                && checkExistDepUpdate(oldname, newname)) {
            return true;
        }
        return false;
    }

}
