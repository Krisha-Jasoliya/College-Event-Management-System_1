package servlet;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);

        UserDAO dao = new UserDAO();
        boolean success = dao.register(user);

        if(success){
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Username already exists or DB error");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}