package dao;

import util.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Event;

public class RegistrationDAO {

    public boolean toggleRegistration(int eventId, int userId) {

        String checkSql = "SELECT * FROM registrations WHERE event_id=? AND user_id=?";
        String deleteSql = "DELETE FROM registrations WHERE event_id=? AND user_id=?";
        String insertSql = "INSERT INTO registrations(event_id,user_id) VALUES(?,?)";
        String updateInc = "UPDATE events SET registered_count=registered_count+1 WHERE id=?";
        String updateDec = "UPDATE events SET registered_count=registered_count-1 WHERE id=?";
        String capSql = "SELECT capacity, registered_count FROM events WHERE id=?";

        try (Connection con = DBConnect.getConnection()) {
            con.setAutoCommit(false); // start transaction

            // Check if user is already registered
            PreparedStatement check = con.prepareStatement(checkSql);
            check.setInt(1, eventId);
            check.setInt(2, userId);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                // User already registered → unregister
                try (PreparedStatement del = con.prepareStatement(deleteSql);
                     PreparedStatement dec = con.prepareStatement(updateDec)) {

                    del.setInt(1, eventId);
                    del.setInt(2, userId);
                    del.executeUpdate();

                    dec.setInt(1, eventId);
                    dec.executeUpdate();

                    con.commit();
                    return true;
                }
            } else {
                // User not registered → check capacity
                try (PreparedStatement cap = con.prepareStatement(capSql)) {
                    cap.setInt(1, eventId);
                    ResultSet rsCap = cap.executeQuery();

                    if (rsCap.next()) {
                        int capacity = rsCap.getInt("capacity");
                        int registered = rsCap.getInt("registered_count");

                        if (registered < capacity) {
                            // Register user
                            try (PreparedStatement ins = con.prepareStatement(insertSql);
                                 PreparedStatement inc = con.prepareStatement(updateInc)) {

                                ins.setInt(1, eventId);
                                ins.setInt(2, userId);
                                ins.executeUpdate();

                                inc.setInt(1, eventId);
                                inc.executeUpdate();

                                con.commit();
                                return true;
                            }
                        }
                    }
                }
            }

            con.rollback(); // if nothing happened
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
      public List<Event> getMyEvents(int userId) {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT e.* " +
                     "FROM events e " +
                     "INNER JOIN registrations r ON e.id = r.event_id " +
                     "WHERE r.user_id=? " +
                     "ORDER BY e.event_date DESC";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Event e = new Event();
                e.setId(rs.getInt("id"));
                e.setTitle(rs.getString("title"));
                e.setDescription(rs.getString("description"));
                e.setEventDate(rs.getTimestamp("event_date"));
                e.setLocation(rs.getString("location"));
                e.setCategory(rs.getString("category"));
                e.setDepartment(rs.getString("department"));
                e.setOrganizer(rs.getString("organizer"));
                e.setCapacity(rs.getInt("capacity"));
                e.setRegisteredCount(rs.getInt("registered_count"));
                e.setImageUrl(rs.getString("image_url"));
                e.setStatus(rs.getString("status"));
                list.add(e);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return list;
    }
}