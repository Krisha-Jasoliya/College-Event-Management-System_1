package servlet;

import dao.RegistrationDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/myEvents")
public class MyEventsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }

        RegistrationDAO dao = new RegistrationDAO();
        request.setAttribute("events", dao.getMyEvents(user.getId()));

        request.getRequestDispatcher("myEvents.jsp")
               .forward(request, response);
    }
}