package servlet;

import dao.EventDAO;
import model.Event;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageEvents")
public class ManageEventsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        // Only admin can access
        if(user == null || !"ADMIN".equalsIgnoreCase(user.getRole())){
            response.sendRedirect("login.jsp");
            return;
        }

        EventDAO dao = new EventDAO();
        List<Event> events = dao.getAllEvents(); // Fetch all events from DB
        request.setAttribute("events", events);

        request.getRequestDispatcher("manageEvents.jsp").forward(request, response);
    }
}