import java.util.Scanner;
import java.sql.*;

public class EditEmployee extends Manager {
    Scanner myScann = new Scanner(System.in);

    public void editInitialize() {
        System.out.print("\033[H\033[2J");
        System.out.flush();
        System.out.println("----------COMPANY Z MANAGEMENT SYSTEM----------\n");

        System.out.println("How would you like to edit your database? "
        + "\nType 'u' for update existing information, " + 
        "\n'ac' for adding a column, " + 
        "\n'dc' for deleting a column, " + 
        "\n'ar' for adding a row, " + 
        "\n'dr' for deleting a row, " +
        "\n'r' for giving employee raises, " + 
        "\nand 'q' at any time to go back.");

        while (true) {
            String str = myScann.nextLine();
            str = str.toLowerCase();

            if (str.equals("u")) {
                update(); 
            } else if (str.equals("ac")) {
                addColumn();
            } else if (str.equals("dc")) {
                deleteColumn(); 
            } else if (str.equals("ar")) {
                addRow();
            } else if (str.equals("dr")) {
                deleteRow();
            } else if (str.equals("r")) {
                raise();
            } else if (str.equals("q")) {
                Manager homescreen = new Manager();
                homescreen.initialize();
            } else {
                System.out.println("Please try again.");
                continue; 
            }
            break;
        }

        // Prompt to return to the main menu or exit the program
        System.out.println("Press 'm' to return to the edit menu or 'q' to quit.");
        String choice = myScann.nextLine().toLowerCase();
        if (choice.equals("m")) {
            editInitialize(); // Return to the main menu
        } else if (choice.equals("q")) {
            System.out.println("Exiting program...");
            System.exit(0); // Exit the program
        }
    }

    public String receiveInput() {
        String input = myScann.nextLine();
        if (input.equals("q") | input.equals("Q")) {
            editInitialize(); 
            System.exit(1);
        }
        return input; 
    }

    public String receiveTable() {
        while (true) {
            System.out.println("What table would you like to update?");
            String tableName = receiveInput(); 

            try (Connection myConn = DriverManager.getConnection(url, user, password)) {
                String sqlcommand = "SELECT * FROM " + tableName; 

                Statement myStmt = myConn.createStatement();
                @SuppressWarnings("unused") 
                ResultSet myRS = myStmt.executeQuery(sqlcommand);
                
                myConn.close();
                return tableName;
            } catch (Exception e) {
                System.out.println("ERROR " + e.getLocalizedMessage());
            }
            finally {}
        }
    } 

    public void update() {
        String inputs, columnNames[], newValues[];
        Update myUpdate = new Update();
        
        String tableName = receiveTable(); 

        while (true) {
            //Receives column name(s)
            System.out.println("What column(s) would you like to update? Separate column names with spaces.");
            inputs = receiveInput();
            columnNames = inputs.split("\\s+"); 

            //Receives value(s)
            System.out.println("What row value(s) would you like set your column(s) to? " 
            + "Separate names with spaces and surround non-numeric values with single quotes."); 
            inputs = receiveInput();
            newValues = inputs.split("\\s+");
            if (newValues.length != columnNames.length) {
                System.out.println("Please match the number of columns and number of new values.");
            } else {
                break;
            }
        }
        
        //Receives condition(s) [where clause in UPDATE SQL command]
        System.out.println("What row conditions would you like to set? Press enter to apply to all rows.");
        String conditions = receiveInput();

        myUpdate.updateNewVals(tableName, columnNames, newValues, conditions);
    }

    public void addColumn() {
        int numLength = -1, decimalLength = -1;
        String columnName, dataType, tempInput = "", condition = "";
        EditColumn columner = new EditColumn();

        String tableName = receiveTable();

        while(true) {
            //Receive the column name
            System.out.println("What is the column name?");
            columnName = receiveInput();

            if (columnName.equals("")) {
                System.out.println("Please enter a non-empty name.");
            } else {
                break;
            }
        }

        while (true) {
            //Receiving data type
            System.out.println("What is the column's data type?\nOptions are: VARCHAR, CHAR, INT, DECIMAL and DATE");
            dataType = receiveInput();
            dataType = dataType.toLowerCase(); 

            try {
                if (dataType.equals("varchar") | dataType.equals("char")) {
                    System.out.println("What is the length?");
                    tempInput = receiveInput();
                    numLength = Integer.parseInt(tempInput);
                    //myScann.nextLine();
                } else if (dataType.equals("decimal")) {
                    System.out.println("What is the size of the number excluding decimal points?");
                    tempInput = receiveInput();
                    numLength = Integer.parseInt(tempInput);

                    System.out.println("What is the size of its decimal points?");
                    tempInput = receiveInput();
                    decimalLength = Integer.parseInt(tempInput);
                } else if (!(dataType.equals("int") | dataType.equals("date"))) {
                    System.out.println("Please enter a valid data type.");
                    continue; 
                } 
                break;
            }
            catch (NumberFormatException n) {
                System.out.println("Please enter a number. Going back...");
            }
        }

        if (!(dataType.equals("date"))) {
            while (true) {
                System.out.println("If this variable can NOT be null, type 'n'. If this variable's default is null, press 'd'. If neither, press enter.");
                condition = receiveInput();

                if (condition.equals("n")) {
                    condition = "NOT NULL"; 
                } else if (condition.equals("d")) {
                    condition = "DEFAULT NULL";
                } else if (!(condition.equals(""))) {
                    System.out.println("Please try again.");
                    continue; 
                }
                break; 
            }
        }  

        columner.addColumn(tableName, columnName, dataType, numLength, decimalLength, condition);

    }

    public void deleteColumn() {
        String columnName;
        EditColumn columner = new EditColumn();
        String tableName = receiveTable(); 

        //Receive the column name
        while (true) {
            System.out.println("What is the column name?");
            columnName = receiveInput();
            if (columnName.equals("")) {
                System.out.println("Please enter a non-empty name.");
            }

            if (columner.dropColumn(tableName, columnName)) {
                break; 
            }
        }
        editInitialize();
    }

    public void raise() {
        String tempInput = "", employee;
        int lowerRange = 0, upperRange = 0; 
        double raisePercent = 0.0;
        Update myUpdate = new Update(); 

        while (true) {
            System.out.println("Would you like to apply the raise for the full-time or part-time employees? Type 'f' for full-time and 'p' for part time.");
            employee = receiveInput().toLowerCase();
            if (!employee.equals("f") && !employee.equals("p")) {
                System.out.println(employee);
                System.out.println("Please try again.");
                continue;
            }
            break;
        }
        
        while (true) {  
            try {
                System.out.println("What range will the the raise be applied to? Enter the lower number");
                tempInput = receiveInput();
                lowerRange = Integer.parseInt(tempInput.replaceAll(",", ""));

                System.out.println("Now enter the higher number");
                tempInput = receiveInput();
                upperRange = Integer.parseInt(tempInput.replaceAll(",", "")); 

                if (lowerRange > upperRange) {
                    System.out.println("Your range is backwards, please input the lower number first."); 
                } else {
                    break;
                }
            } 
            catch (Exception e) {
                System.out.println("Please enter a valid integer with no alphabetical inputs for your range.");
            }
        }

       while (true) {
            try {
                System.out.print("What percentage is the raise?\n%");
                tempInput = receiveInput();
                raisePercent = Double.parseDouble(tempInput);
                raisePercent *= 0.01;
                break;
            } 
            catch (Exception e) {
                System.out.println("Please enter a valid integer with no alphabetical inputs.");
            }
        }

        myUpdate.updateSalary(employee, lowerRange, upperRange, raisePercent);
    }

    public void addRow() {
        EditRow myEditRow = new EditRow();
        String columnValues;

        String tableName = receiveTable();

        System.out.println("Enter values for all columns separated by commas. " + 
        "Separate names with spaces and surround non-numeric values and dates with single quotes");
        columnValues = receiveInput();

        myEditRow.insertRow(tableName, columnValues);
    }

    public void deleteRow() {
        EditRow myEditRow = new EditRow();
        String tableName = receiveTable(); 

        System.out.println("Enter conditions to specify the rows to delete (e.g., 'empid = 1'):");
        String conditions = receiveInput();

        myEditRow.deleteRow(tableName, conditions);
    }

}
