package webapp;
import java.sql.*;
public class TestDB {
public static void main(String[] args) {
try {
Connection conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/wiki_db", "root", "password"
);
System.out.println("Connected!");
conn.close();
} catch (Exception e) {
e.printStackTrace();
}
}
}