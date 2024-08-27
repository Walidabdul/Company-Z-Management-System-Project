import java.sql.*;
public class Update extends EditEmployee {
    StringBuilder output = new StringBuilder("");
    String sqlcommand; 

    public void updateNewVals(String tableName, String[] columnNames, String[] newValues, String conditions) {
        try (Connection myConn = DriverManager.getConnection(url, user, password)) {
            sqlcommand = "UPDATE " + tableName + " SET "; 
            for (int i = 0; i < columnNames.length; i++) {
                sqlcommand += columnNames[i] + "=" + newValues[i];
                if (i != (columnNames.length - 1)) {
                    sqlcommand += ", ";
                }
            }
            sqlcommand += " WHERE " + conditions;
            System.out.println(sqlcommand);

            //Executes the sql command
            Statement myStmt = myConn.createStatement();
            myStmt.executeUpdate(sqlcommand);
            System.out.println("Updated successfully!");
            
            myConn.close();
        } catch (Exception e) {
            System.out.println("ERROR " + e.getLocalizedMessage());
        }
        finally {
        }
    }
   
    public void updateSalary(String employee, int lowerInput, int higherInput, double percentInput) {
        String tableName;
        
        if (employee.equals("f")) {
            tableName = "employees";
            employee = "Salary";
        } else {
            tableName = "partpayroll";
            employee = "Hourly";
        }
        String[] columnName = {employee};
        String[] newValue = {employee + " + " + employee + "*" + percentInput};
        String condition = employee + " BETWEEN " + lowerInput + " AND " + higherInput;

        updateNewVals(tableName, columnName, newValue, condition);
    }
}