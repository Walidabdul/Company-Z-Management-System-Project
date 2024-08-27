import java.sql.*;
public class EditRow extends EditEmployee {
    StringBuilder output = new StringBuilder("");
    String sqlcommand; 

    public void insertRow(String tableName, String columnValues) {
        try (Connection myConn = DriverManager.getConnection(url, user, password)) {
            Statement statement = myConn.createStatement();
            String sql = "INSERT INTO " + tableName + " VALUES (" + columnValues + ")";
            statement.executeUpdate(sql);
            System.out.println("Row inserted successfully!");
        } catch (Exception e) {
            System.out.println("ERROR " + e.getLocalizedMessage());
        }
        finally {
        }
    }

    public void deleteRow(String tableName, String conditions) {
        try (Connection myConn = DriverManager.getConnection(url, user, password)) {
            sqlcommand = "DELETE FROM " + tableName + " WHERE " + conditions;

            Statement myStmt = myConn.createStatement();
            int rowsAffected = myStmt.executeUpdate(sqlcommand);
            System.out.println(rowsAffected + " row(s) deleted successfully!");
        }
        catch (Exception e) {
            System.out.println("ERROR " + e.getLocalizedMessage());
        }
        finally {}
    }

}
