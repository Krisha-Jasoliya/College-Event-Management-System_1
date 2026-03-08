package dao;

import model.Participant;
import model.Event;
import util.DBConnect;

import java.sql.*;
import java.util.*;

public class ParticipantDAO {

    // Get all participants with event info
    public List<Map<String, Object>> getAllParticipants() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.email, p.contact, p.event_id, p.registration_date, e.title as event_title " +
                     "FROM participants p JOIN events e ON p.event_id = e.id ORDER BY p.registration_date DESC";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getInt("id"));
                map.put("name", rs.getString("name"));
                map.put("email", rs.getString("email"));
                map.put("contact", rs.getString("contact"));
                map.put("eventId", rs.getInt("event_id"));
                map.put("registrationDate", rs.getTimestamp("registration_date"));
                map.put("eventTitle", rs.getString("event_title"));
                list.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }public boolean registerParticipant(String name, String email, String contact, int eventId) {
    String sql = "INSERT INTO participants(name, email, contact, event_id) VALUES(?,?,?,?)";
    try (Connection con = DBConnect.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, contact);
        ps.setInt(4, eventId);

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
}