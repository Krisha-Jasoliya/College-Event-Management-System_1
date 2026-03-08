package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import model.Event;
import model.User;
import dao.EventDAO;

@WebServlet("/createEvent")
public class CreateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if(user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Retrieve form parameters
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String dateStr = request.getParameter("event_date");
            String timeStr = request.getParameter("event_time");
            String location = request.getParameter("location");
            String category = request.getParameter("category");
            String department = request.getParameter("department");
            String organizer = request.getParameter("organizer");
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String imageUrl = request.getParameter("image_url");
            String status = request.getParameter("status");

            // Combine date + time
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date eventDate = sdf.parse(dateStr + " " + timeStr);

            // Create Event object
            Event event = new Event();
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
            event.setRegisteredCount(0);

            // Save event using DAO
            EventDAO dao = new EventDAO();
            boolean created = dao.createEvent(event);

            if(created){
                response.sendRedirect("manageEvents.jsp"); // redirect to list of events
            } else {
                request.setAttribute("errorMessage", "Failed to create event. Try again.");
                request.getRequestDispatcher("createEvent.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("createEvent.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // redirect GET request to JSP form
        response.sendRedirect("createEvent.jsp");
    }
}