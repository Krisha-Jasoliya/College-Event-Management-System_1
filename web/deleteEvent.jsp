<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Event, model.User, java.text.SimpleDateFormat" %>
<%@ page session="true" %>

<%
    User user = (User) session.getAttribute("user");
    if(user == null || !"STUDENT".equalsIgnoreCase(user.getRole())){
        response.sendRedirect("login.jsp");
        return;
    }

    Event event = (Event) request.getAttribute("event");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
<% if(event == null){ %>
    <div class="alert alert-danger">Event not found</div>
<% } else { %>
    <div class="card p-4">
        <h3>Are you sure you want to delete this event?</h3>
        <h5 class="mt-3"><%= event.getTitle() %></h5>
        <p><%= event.getDescription() %></p>

        <a href="deleteEvent?id=<%= event.getId() %>" class="btn btn-danger">Yes, Delete</a>
        <a href="myEvents.jsp" class="btn btn-secondary">Cancel</a>
    </div>
<% } %>
</div>
</body>
</html>