package servlet;

import dao.ParticipantDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/participants")
public class ParticipantsServlet extends HttpServlet {

    private ParticipantDAO participantDAO = new ParticipantDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch participants
        List<Map<String, Object>> participants = participantDAO.getAllParticipants();
        request.setAttribute("participants", participants);

        request.getRequestDispatcher("participants.jsp").forward(request, response);
    }
}