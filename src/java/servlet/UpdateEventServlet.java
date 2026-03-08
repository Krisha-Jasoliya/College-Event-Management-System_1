package servlet;

import dao.EventDAO;
import model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/updateEvent")
public class UpdateEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Parse event ID
            int id = Integer.parseInt(request.getParameter("id"));

            // Get all form parameters
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String dateStr = request.getParameter("event_date");  // yyyy-MM-dd
            String timeStr = request.getParameter("event_time");  // HH:mm
            String location = request.getParameter("location");
            String category = request.getParameter("category");
            String department = request.getParameter("department");
            String organizer = request.getParameter("organizer");
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String imageUrl = request.getParameter("image_url");
            String status = request.getParameter("status");

            // Combine date and time into a single Timestamp
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date eventDate = sdf.parse(dateStr + " " + timeStr);

            // Create Event object
            Event event = new Event();
            event.setId(id);
            event.setTitle(title);
            event.setDescription(description);
            event.setEventDate(eventDate);
            event.setLocation(location);
            event.setCategory(category);
            event.setDepartment(department);
            event.setOrganizer(organizer);
            event.setCapacity(capacity);
            event.setImageUrl(imageUrl);
            event.setStatus(status);

            // Update event in DB
            EventDAO dao = new EventDAO();
            boolean updated = dao.updateEvent(event);

            if(updated){
                response.sendRedirect("myEvents.jsp"); // Redirect to events list
            } else {
                request.setAttribute("error", "Failed to update event.");
                request.getRequestDispatcher("editEvent?id=" + id).forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}