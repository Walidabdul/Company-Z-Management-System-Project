import java.sql.*;
import java.util.Scanner;
public class Manager {
    public static String url, user, password;

    public void getConnected(String urlInput, String userInput, String passwordInput) {
        url = urlInput;
        user = userInput; 
        password = passwordInput;
        
        try ( Connection myConn = DriverManager.getConnection( url, user, password ) ) 
        {
            myConn.close();
            initialize();
        } 
        catch (SQLException e) 
        {
            System.out.println("ERROR " + e.getLocalizedMessage());
        }
    }

    public void initialize() {
        System.out.print("\033[H\033[2J");
        System.out.flush();
        System.out.println("----------COMPANY Z MANAGEMENT SYSTEM----------\n");

        System.out.println("What would you like to do? " + 
        "To edit your database, type 'e', and to search or bring up reports, type 'r'. Press 'q' to quit.");
        
        Scanner myScann = new Scanner(System.in);
        String str = myScann.nextLine().toLowerCase();

        if (str.equals("e")) {
            EditEmployee editScreen = new EditEmployee();
            editScreen.editInitialize();
        } else if (str.equals("r")) {
            try {
                Report.reports();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        } else if (str.equals("q")) {
            System.out.println("Quit program.");
            System.exit(1);
        } else {
            System.out.println("Please try again.");
            initialize();
        }
        myScann.close();
    }

}
