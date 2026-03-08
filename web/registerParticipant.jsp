<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Event, model.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register for Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2>Register for Event</h2>
    <%
        User user = (User) session.getAttribute("user");
        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }

        List<Event> events = (List<Event>) request.getAttribute("events");
        if(events == null) events = new ArrayList<>();
    %>

    <form action="registerParticipant" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" name="name" class="form-control" id="name" value="<%= user.getUsername() %>" readonly>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" name="email" class="form-control" id="email" value="<%= user.getEmail() %>" readonly>
        </div>

        <div class="mb-3">
            <label for="contact" class="form-label">Contact Number</label>
            <input type="text" name="contact" class="form-control" id="contact" required>
        </div>

        <div class="mb-3">
            <label for="event" class="form-label">Select Event</label>
            <select name="eventId" class="form-control" id="event" required>
                <option value="">--Select Event--</option>
                <%
                    for(Event e : events){
                %>
                    <option value="<%= e.getId() %>"><%= e.getTitle() %> | <%= e.getEventDate() %></option>
                <%
                    }
                %>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Register</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>