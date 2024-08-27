import java.sql.*;

public class EditColumn extends EditEmployee {
    StringBuilder output = new StringBuilder(""); 
    String sqlcommand;

    public void addColumn(String tableName, String columnName, String dataType, int numLength, int decimalLength, String condition) {
        try (Connection myConn = DriverManager.getConnection(url, user, password)) {
            sqlcommand = "ALTER TABLE " + tableName + " ADD " + columnName + " " + dataType;
            
            if (decimalLength == -1 && numLength == -1) { //if no numLength and decimalLength, aka HireDate or int
            } else if (decimalLength == -1) { //if no decimalLength, aka varchar or char
                sqlcommand += "(" + numLength + ")";
            } else { //if decinput and numinput, aka decimal
                sqlcommand += "(" + numLength + "," + decimalLength + ")";
            }
            if (!(condition.equals(""))) {
                sqlcommand += " " + condition;
            }

            Statement myStmt = myConn.createStatement();
            myStmt.executeUpdate(sqlcommand);

            System.out.println("Added column!"); 
            myConn.close();
        } catch (Exception e) {
            System.out.println("ERROR " + e.getLocalizedMessage());
        }
        finally {}
    }

    public boolean dropColumn(String tableName, String columnName) {
        try (Connection myConn = DriverManager.getConnection(url, user, password)) {

            sqlcommand = "ALTER TABLE " + tableName + " DROP COLUMN " + columnName + ";";

            Statement myStmt = myConn.createStatement();
            myStmt.executeUpdate(sqlcommand);

            System.out.println("Dropped column!"); 
            myConn.close(); 
        } catch (Exception e) {
            System.out.println("ERROR " + e.getLocalizedMessage());
            return false; 
        }
        finally {}
        return true;
    }
}


