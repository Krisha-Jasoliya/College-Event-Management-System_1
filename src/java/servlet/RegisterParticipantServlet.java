package servlet;

import dao.ParticipantDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/registerParticipant")
public class RegisterParticipantServlet extends HttpServlet {

    private ParticipantDAO participantDAO = new ParticipantDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        boolean success = participantDAO.registerParticipant(name, email, contact, eventId);

        if (success) {
            response.sendRedirect("participantSuccess.jsp");
        } else {
            response.sendRedirect("participantError.jsp");
        }
    }
}