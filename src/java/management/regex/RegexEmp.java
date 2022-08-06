/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package management.regex;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import management.dao.CertificateDAO;
import management.dao.DependentDAO;
import management.dao.EmployeeDAO;

/**
 *
 * @author lehon
 */
public class RegexEmp {

    //Only contain Alphabet(Upper case or Lower case) and space and length 4 -> 30(Check name)
    public static boolean checkEmpName(String name) {
        boolean check = name.matches("[a-zA-Z][a-zA-Z ]*");
        if ((name.length() > 30 || name.length() < 4) || (check == false)) {
            return false;
        }
        return true;
    }

    //Length 5 -> 40(Check address)
    public static boolean checkEmpAddress(String add) {
        if (add.length() < 5 || add.length() > 40) {
            return false;
        }
        return true;
    }

    //only contain only number(Check age and phone)
    public static boolean checkOnlyNumber(String test) {
        return test.matches("^[0-9]*$");
    }

    //Check age contain only number and between 15 -> 65 
    public static boolean checkAge(String age) {
        boolean check = checkOnlyNumber(age);
        if (check) {
            if (Integer.parseInt(age) >= 15 && Integer.parseInt(age) <= 65) {
                return true;
            }
        } else {
            return false;
        }
        return false;
    }

    //Check baseSalary only contain number and between 1000000 to 10000
    public static boolean checkSalary(String Salary) {
        boolean check = checkOnlyNumber(Salary);
        
        if ((check) && (Salary.length() >= 3 && Salary.length() <= 5)) {
            if (Integer.parseInt(Salary) >= 100 && Integer.parseInt(Salary) <= 10000) {
                return true;
            }
        } else {
            return false;
        }
        return false;
    }

    //Check number contain only number and length between 5 - > 15
    public static boolean checkPhone(String phone) {
        boolean check = checkOnlyNumber(phone);
        if ((phone.length() > 4) && (phone.length() < 16) && (check == true)) {
            return true;
        }
        return false;
    }

    //Check dob of employee
    public static boolean checkValidationDob(String dob) {
        try {
            if (EmployeeDAO.checkValidDobDay(dob)) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegexEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //Check exactDate
    public static boolean checkValidationExactDate(String exactDate) {
        try {
            if (EmployeeDAO.checkExactDate(exactDate)) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegexEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static boolean checkValidationCertiDate(String certiDate) {
        try {
            if (CertificateDAO.checkCertiDate(certiDate)) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegexEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
     public static boolean checkValidationDependent(String dependent) {
        try {
            if (DependentDAO.checkDepenDate(dependent)) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegexEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //check valid email
    public static boolean checkValidEmail(String email) {
        boolean check = email.matches("^[\\w.+\\-]+@fpt\\.edu\\.vn$");
        if ((email.length() < 12) || (email.length() > 30) || (check == false)) {
            return false;
        }

        return true;
    }

    //check valid password
    public static boolean checkValidPass(String pass) {
        if (pass.length() < 8 || pass.length() > 25) {
            return false;
        }
        return true;
    }

    //check mail not exits
    public static boolean checkMailNotExist(String email) {
        boolean check = false;
        try {
            check = EmployeeDAO.checkMailExist(email);
        } catch (SQLException ex) {
            Logger.getLogger(RegexEmp.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (check) {
            return false;
        }
        return true;
    }

    //Check field null of employee
    public static boolean chekcEmpFieldNull(String name, String baseSalary, String add, String phone, String dob, String exact, String email, String pass) {
        if (name.equals("") || name == null
                || baseSalary.equals("") || baseSalary == null
                || add.equals("") || add == null
                || phone.equals("") || phone == null
                || dob.equals("") || dob == null
                || exact.equals("") || exact == null
                || email.equals("") || email == null
                || pass.equals("") || pass == null) {
            return true;
        }
        return false;
    }

    //Check field null when update
    public static boolean checkFieldNullUpdate(String name, String baseSalary, String add, String phone, String dob) {
        if (name.equals("") || name == null
                || baseSalary.equals("") || baseSalary == null
                || add.equals("") || add == null
                || phone.equals("") || phone == null
                || dob.equals("") || dob == null) {
            return true;
        }
        return false;
    }

    //check all
    public static boolean checkEmpValidation(String name, String salary, String add, String phone, String dob, String exact, String email, String pass) {
        if (checkEmpName(name)
                && checkSalary(salary)
                && checkEmpAddress(add)
                && checkPhone(phone)
                && checkValidationDob(dob)
                && checkValidationExactDate(exact)
                && checkValidEmail(email)
                && checkMailNotExist(email)
                && checkValidPass(pass)) {
            return true;
        }
        return false;

    }

    //check all when update 
    public static boolean checkEmpValidationUpdate(String name, String salary, String add, String phone, String dob) {
        if (checkEmpName(name)
                && checkSalary(salary)
                && checkEmpAddress(add)
                && checkPhone(phone)
                && checkValidationDob(dob)) {
            return true;
        }
        return false;

    }

}
