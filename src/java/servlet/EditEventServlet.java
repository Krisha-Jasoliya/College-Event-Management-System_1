package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Event;
import model.User;

import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/editEvent")
public class EditEventServlet extends HttpServlet {

    private final String jdbcURL = "jdbc:mysql://localhost:3306/college_event_hub"; // change DB URL
    private final String dbUser = "root"; // DB username
    private final String dbPassword = "Krisha@2627"; // DB password

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"STUDENT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("myEvents.jsp");
            return;
        }

        int eventId = Integer.parseInt(idParam);

        Event event = null;

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            String sql = "SELECT * FROM events WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                event = new Event();
                event.setId(rs.getInt("id"));
                event.setTitle(rs.getString("title"));
                event.setDescription(rs.getString("description"));
                event.setEventDate(rs.getTimestamp("event_date"));
                event.setLocation(rs.getString("location"));
                event.setCategory(rs.getString("category"));
                event.setDepartment(rs.getString("department"));
                event.setOrganizer(rs.getString("organizer"));
                event.setCapacity(rs.getInt("capacity"));
                event.setRegisteredCount(rs.getInt("registered_count"));
                event.setImageUrl(rs.getString("image_url"));
                event.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("event", event);
        request.getRequestDispatcher("editEvent.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String dateStr = request.getParameter("event_date");
        String timeStr = request.getParameter("event_time");
        String location = request.getParameter("location");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String category = request.getParameter("category");
        String status = request.getParameter("status");

        // Combine date + time into java.util.Date
        Date eventDate = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            eventDate = sdf.parse(dateStr + " " + timeStr);
        } catch (Exception e) {
            e.printStackTrace();
        }

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            String sql = "UPDATE events SET title=?, description=?, event_date=?, location=?, capacity=?, category=?, status=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setTimestamp(3, new Timestamp(eventDate.getTime()));
            ps.setString(4, location);
            ps.setInt(5, capacity);
            ps.setString(6, category);
            ps.setString(7, status);
            ps.setInt(8, id);

            int updated = ps.executeUpdate();
            if (updated > 0) {
                response.sendRedirect("myEvents.jsp");
            } else {
                request.setAttribute("error", "Failed to update event.");
                request.getRequestDispatcher("editEvent.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("editEvent.jsp").forward(request, response);
        }
    }
}