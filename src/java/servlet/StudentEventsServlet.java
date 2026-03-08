package servlet;

import dao.EventDAO;
import model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/StudentEventsServlet")
public class StudentEventsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EventDAO dao = new EventDAO();
        List<Event> events = dao.getAllEvents();

        request.setAttribute("events", events);
        request.getRequestDispatcher("studentEvents.jsp").forward(request, response);
    }
}