package dao;

import model.User;
import util.DBConnect;
import java.sql.*;

public class UserDAO {

    // Login
    public User login(String username, String password){
        String sql = "SELECT * FROM users WHERE username=? AND password=?";
        try(Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setRole(rs.getString("role"));
                return u;
            }
        } catch(Exception e){ e.printStackTrace(); }
        return null;
    }

    // Register
    public boolean register(User user){
        String check = "SELECT * FROM users WHERE username=?";
        String insert = "INSERT INTO users(username,password,role) VALUES(?,?,?)";

        try(Connection con = DBConnect.getConnection();
            PreparedStatement psCheck = con.prepareStatement(check);
            PreparedStatement psInsert = con.prepareStatement(insert)){

            psCheck.setString(1, user.getUsername());
            ResultSet rs = psCheck.executeQuery();
            if(rs.next()){
                return false; // username exists
            }

            psInsert.setString(1, user.getUsername());
            psInsert.setString(2, user.getPassword());
            psInsert.setString(3, user.getRole());
            return psInsert.executeUpdate() > 0;

        } catch(Exception e){ e.printStackTrace(); return false; }
    }
}