<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
    // Invalidate the session to log out the user
    if (session != null) {
        session.invalidate();
    }

    // Redirect to login page after logout
    response.sendRedirect("login.jsp");
%>