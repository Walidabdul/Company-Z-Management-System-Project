import java.sql.*;
import java.util.Scanner;

public class Report extends Manager {
    static String url = "jdbc:mysql://localhost:3306/employeeData";
    static String user = "root";
    static String password = "walid";
    
    public StringBuilder getFullTimeEmployee(String employee, Connection myConn){
        StringBuilder output = new StringBuilder("");
        String sqlcommand = "SELECT e.Fname, e.Lname, e.email, j.job_title, e.empid, e.HireDate, e.Salary, e.SSN, " +
                "p.pay_date, p.earnings, p.payID " +
                 "FROM employees e " + 
                "JOIN employee_job_titles ej ON e.empid = ej.empid " +  
                "JOIN job_titles j ON ej.job_title_id = j.job_title_id " +
                "JOIN employees ep ON e.empid = ep.empid " +
                "JOIN payroll p ON ep.empid = p.empid " +
                "Where e.Fname = '" + employee + "' OR e.empid = '" + employee + "' OR e.SSN = '" + employee +
                "'ORDER BY e.empid ; ";
        
        try(Statement mystmt1 = myConn.createStatement();) {
            output.append("First Name\tLast Name\tEmail\t\t\tJob Title\t\tEmpID\tHiredate\tSalary\tSSN\tPAY DATE\tEarnings\tPAY ID\n");
            ResultSet myRS = mystmt1.executeQuery(sqlcommand);
            while (myRS.next()) {
                output.append(myRS.getString("e.Fname") + "\t\t");
                output.append(myRS.getString("e.Lname") + "\t\t" + myRS.getString("e.email") + "\t");
                output.append(myRS.getString("j.job_title") + "\t");
                output.append(myRS.getInt("e.empid") + "\t");
                output.append(myRS.getDate("e.HireDate") + "\t" + myRS.getDouble("e.Salary") + "\t");
                output.append(myRS.getString("e.SSN") + "\t");
                output.append(myRS.getDate("p.pay_date") + "\t" + myRS.getDouble("p.earnings") + "\t\t");
                output.append(myRS.getInt("p.payID") + "\n");
            }
        }catch (Exception e) {
            System.out.println("Error " + e.getLocalizedMessage());
        } finally{    
        }
        return output;
    }

    public StringBuilder getTotalPayByJobTitle(String job_title, Connection myConn2) {
        StringBuilder output1 = new StringBuilder("");
        String sqlcommand2 = "Select  j.job_title ,p.pay_date, p.earnings, p.payID " +
                        "FROM payroll p " +
                        "JOIN employee_job_titles pj ON p.empid = pj.empid " +
                        "JOIN  job_titles j ON pj.job_title_id = j.job_title_id " +
                        "WHERE j.job_title = '" + job_title +
                        "' ORDER BY p.payID ; ";

        try(Statement myStmt = myConn2.createStatement();) {
            output1.append("Job Title\t\tPAY DATE\tEarnings\tPAY ID\n");
            ResultSet myRS1 = myStmt.executeQuery(sqlcommand2);
            while (myRS1.next()) {
                output1.append(myRS1.getString("j.job_title") + "\t");
                output1.append(myRS1.getDate("p.pay_date") + "\t" + myRS1.getDouble("p.earnings") + "\t\t");
                output1.append(myRS1.getDouble("p.payID") + "\n");
            }
        }catch (Exception e) {
            System.out.println("ERROR " + e.getLocalizedMessage());
        } finally {
        }
        return output1;
    }

    public StringBuilder getTotalPayBYDivision(String division, Connection myconn3) {
        StringBuilder output2 = new StringBuilder("");
        String sqlcommand3 = "SELECT d.Name , p.pay_date, p.earnings, p.payID " +
                        "FROM payroll p " +
                        "JOIN employee_division pd ON p.empid = pd.empid " +
                        "JOIN division d ON pd.empid = pd.empid " +
                        "WHERE d.name = '" + division +
                        "' ORDER BY d.name; ";

        try(Statement myStmt2 = myconn3.createStatement();) {
            output2.append("Division\tPAY DATE\tEarnings\tPAY ID\n");
            ResultSet myRS2 = myStmt2.executeQuery(sqlcommand3);
            while (myRS2.next()) {
                output2.append(myRS2.getString("d.name") + "\t\t");
                output2.append(myRS2.getDate("p.pay_date") + "\t" + myRS2.getDouble("p.earnings") + "\t\t");
                output2.append(myRS2.getDouble("p.payID") + "\n");
            }
        } catch (Exception e) {
            System.out.println("ERROR " + e.getLocalizedMessage());
        } finally{
        }
        return output2;
    }
    public static void reports() throws SQLException {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter your choice:");
        System.out.println("1) Full-time employee information with pay statement history");
        System.out.println("2) Total pay for month by job title");
        System.out.println("3) Total pay for month by division");
        String input = scanner.nextLine();
        
            if (Integer.valueOf(input)== 1) {
                Connection myConn = DriverManager.getConnection(url, user, password);
                System.out.println("Enter Employee Name or EMPID or SSN:");
                String input1 = scanner.nextLine();
                Report reporter = new Report();
                System.out.println(reporter.getFullTimeEmployee(input1, myConn));
            }

            else if (Integer.valueOf(input) == 2){
                Connection myConn2 = DriverManager.getConnection(url, user, password);
                System.out.println("Enter Job title");
                String input2 = scanner.nextLine();
                Report reporter2 = new Report();
                System.out.println(reporter2.getTotalPayByJobTitle(input2, myConn2));
            }

            else if (Integer.valueOf(input) == 3) {
                Connection myConn3 = DriverManager.getConnection(url, user, password);
                System.out.println("Enter Divsion Title");
                String input3 = scanner.nextLine();
                Report reporter3 = new Report();
                System.out.println(reporter3.getTotalPayBYDivision(input3, myConn3));
            }

            else if (input == "q"){
                scanner.close();
            }   
    }
    
}
    


