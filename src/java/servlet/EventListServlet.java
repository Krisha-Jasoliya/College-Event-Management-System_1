package servlet;


import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/events")
public class EventListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String category = request.getParameter("category");
        String department = request.getParameter("department");

        EventDAO dao = new EventDAO();
        request.setAttribute("events",
                dao.filterEvents(search, category, department));

        request.getRequestDispatcher("events.jsp")
               .forward(request, response);
    }
}