package servlet;

import dao.EventDAO;
import model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/eventDetail")
public class EventDetailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String idParam = request.getParameter("id");

            if(idParam == null){
                response.sendRedirect("events.jsp");
                return;
            }

            int id = Integer.parseInt(idParam);

            EventDAO dao = new EventDAO();
            Event event = dao.getEventById(id);

            request.setAttribute("event", event);

            request.getRequestDispatcher("eventDetail.jsp").forward(request, response);

        } catch(Exception e){
            e.printStackTrace();
            response.sendRedirect("events.jsp");
        }
    }
}