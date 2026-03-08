<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Event, model.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { display: flex; min-height: 100vh; margin: 0; background: #f5f8ff; }
        .sidebar { width: 220px; background: #1e1e2f; color: #fff; padding: 20px; display: flex; flex-direction: column; }
        .sidebar a { color: #fff; display: block; padding: 10px; text-decoration: none; border-radius: 5px; margin-bottom: 5px; }
        .sidebar a:hover { background: #343454; }
        .main { flex: 1; padding: 20px; }
        .table-responsive { background: #fff; border-radius: 10px; padding: 15px; margin-top: 20px; }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if(user == null || !"ADMIN".equalsIgnoreCase(user.getRole())){
        response.sendRedirect("login.jsp");
        return;
    }

    List<Event> events = (List<Event>) request.getAttribute("events");
    if(events == null) events = new ArrayList<>();
%>

<div class="sidebar">
    <h4 class="mb-4">Admin: <%= user.getUsername() %></h4>
    <a href="adminDashboard.jsp">Dashboard</a>
    <a href="createEvent.jsp">Create Event</a>
    <a href="manageEvents">Manage Events</a>
    <a href="participants.jsp">Participants</a>
    <a href="logout">Logout</a>
</div>

<div class="main">
    <h2>All Events</h2>
    <div class="table-responsive shadow-sm">
        <table class="table table-striped table-bordered align-middle">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Date & Time</th>
                    <th>Location</th>
                    <th>Category</th>
                    <th>Department</th>
                    <th>Organizer</th>
                    <th>Capacity</th>
                    <th>Participants</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            <%
                if(events.isEmpty()) {
            %>
                <tr>
                    <td colspan="11" class="text-center">No events found</td>
                </tr>
            <%
                } else {
                    for(Event e : events){
            %>
                <tr>
                    <td><%= e.getId() %></td>
                    <td><%= e.getTitle() %></td>
                    <td><%= e.getDescription() %></td>
                    <td><%= e.getEventDate() %></td>
                    <td><%= e.getLocation() %></td>
                    <td><%= e.getCategory() %></td>
                    <td><%= e.getDepartment() %></td>
                    <td><%= e.getOrganizer() %></td>
                    <td><%= e.getCapacity() %></td>
                    <td><%= e.getRegisteredCount() %></td> <!-- Participants -->
                    <td><%= e.getStatus() %></td>
                </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>