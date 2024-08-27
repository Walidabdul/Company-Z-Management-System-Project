public class Main {
    public static void main(String[] args) {
        Manager myManager = new Manager(); 
        /* 
        Please enter your URL, username, and password to connect to your employee database.
        Afterwards, run Main() and your management system shall begin. 
        Thank you. 
        */  
        myManager.getConnected("jdbc:mysql://localhost:3306/employeeData", "root", "walid");    
    }
}