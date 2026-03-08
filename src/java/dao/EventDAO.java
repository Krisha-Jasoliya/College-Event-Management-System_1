package dao;

import model.Event;
import util.DBConnect;

import java.sql.*;
import java.util.*;

public class EventDAO {

    public List<Event> getAllEvents() {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT * FROM events ORDER BY event_date DESC";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapEvent(rs));
            }

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    public Event getEventById(int id) {
        String sql = "SELECT * FROM events WHERE id=?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapEvent(rs);

        } catch (Exception e) { e.printStackTrace(); }

        return null;
    }

    public boolean createEvent(Event e) {
        String sql = "INSERT INTO events(title,description,event_date,location,category,department,organizer,capacity,image_url,status,registered_count) VALUES(?,?,?,?,?,?,?,?,?,?,0)";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, e.getTitle());
            ps.setString(2, e.getDescription());
            ps.setTimestamp(3, new Timestamp(e.getEventDate().getTime()));
            ps.setString(4, e.getLocation());
            ps.setString(5, e.getCategory());
            ps.setString(6, e.getDepartment());
            ps.setString(7, e.getOrganizer());
            ps.setInt(8, e.getCapacity());
            ps.setString(9, e.getImageUrl());
            ps.setString(10, e.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception ex) { ex.printStackTrace(); return false; }
    }

    public boolean updateEvent(Event e) {
        String sql = "UPDATE events SET title=?,description=?,event_date=?,location=?,category=?,department=?,organizer=?,capacity=?,image_url=?,status=? WHERE id=?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, e.getTitle());
            ps.setString(2, e.getDescription());
            ps.setTimestamp(3, new Timestamp(e.getEventDate().getTime()));
            ps.setString(4, e.getLocation());
            ps.setString(5, e.getCategory());
            ps.setString(6, e.getDepartment());
            ps.setString(7, e.getOrganizer());
            ps.setInt(8, e.getCapacity());
            ps.setString(9, e.getImageUrl());
            ps.setString(10, e.getStatus());
            ps.setInt(11, e.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception ex) { ex.printStackTrace(); return false; }
    }

    public boolean deleteEvent(int id) {
        String sql = "DELETE FROM events WHERE id=?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public List<Event> filterEvents(String search, String category, String department) {
        List<Event> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM events WHERE 1=1 ");

        if (search != null && !search.isEmpty()) sql.append("AND title LIKE ? ");
        if (category != null && !category.isEmpty()) sql.append("AND category=? ");
        if (department != null && !department.isEmpty()) sql.append("AND department=? ");

        sql.append("ORDER BY event_date DESC");

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (search != null && !search.isEmpty()) ps.setString(idx++, "%" + search + "%");
            if (category != null && !category.isEmpty()) ps.setString(idx++, category);
            if (department != null && !department.isEmpty()) ps.setString(idx++, department);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapEvent(rs));

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    public List<Event> getFeaturedEvents() {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT * FROM events WHERE status='upcoming' ORDER BY event_date DESC LIMIT 3";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapEvent(rs));

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    public boolean increaseRegistration(int eventId) {
        String sql = "UPDATE events SET registered_count = registered_count + 1 WHERE id=? AND registered_count < capacity";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public boolean decreaseRegistration(int eventId) {
        String sql = "UPDATE events SET registered_count = registered_count - 1 WHERE id=? AND registered_count > 0";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    private Event mapEvent(ResultSet rs) throws Exception {
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
        return e;
    }
}