<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Participants</title>
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

    List<Map<String,Object>> participants = (List<Map<String,Object>>) request.getAttribute("participants");
    if(participants == null) participants = new ArrayList<>();
%>

<div class="sidebar">
    <h4 class="mb-4">Admin: <%= user.getUsername() %></h4>
    <a href="adminDashboard.jsp">Dashboard</a>
    <a href="createEvent.jsp">Create Event</a>
    <a href="manageEvents">Manage Events</a>
    <a href="participants">Participants</a>
    <a href="logout">Logout</a>
</div>

<div class="main">
    <h2>Participants List</h2>
    <div class="table-responsive shadow-sm">
        <table class="table table-striped table-bordered align-middle">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Event</th>
                    <th>Registration Date</th>
                </tr>
            </thead>
            <tbody>
            <%
                if(participants.isEmpty()){
            %>
                <tr>
                    <td colspan="6" class="text-center">No participants found</td>
                </tr>
            <%
                } else {
                    for(Map<String,Object> p : participants){
            %>
                <tr>
                    <td><%= p.get("id") %></td>
                    <td><%= p.get("name") %></td>
                    <td><%= p.get("email") %></td>
                    <td><%= p.get("contact") %></td>
                    <td><%= p.get("eventTitle") %></td>
                    <td><%= p.get("registrationDate") %></td>
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