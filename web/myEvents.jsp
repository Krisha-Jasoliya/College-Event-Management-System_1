<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, model.Event, model.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { display: flex; min-height: 100vh; margin: 0; background: #f5f8ff; }
        .sidebar { width: 220px; background: #1e1e2f; color: #fff; padding: 20px; display: flex; flex-direction: column; }
        .sidebar a { color: #fff; display: block; padding: 10px; text-decoration: none; border-radius: 5px; margin-bottom: 5px; }
        .sidebar a:hover { background: #343454; }
        .main { flex: 1; padding: 20px; }
        .card-event { border-radius: 10px; overflow: hidden; }
        .card-event img { height: 180px; object-fit: cover; }
        .card-event .card-body { padding: 15px; }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if(user == null || !"STUDENT".equalsIgnoreCase(user.getRole())){
        response.sendRedirect("login.jsp");
        return;
    }

    // Assuming "userEvents" is set in request by servlet
    List<Event> userEvents = (List<Event>) request.getAttribute("userEvents");
    if(userEvents == null || userEvents.isEmpty()){
        userEvents = new ArrayList<>();
        SimpleDateFormat sdfParse = new SimpleDateFormat("yyyy-MM-dd");

        // Existing dummy event
        Event e1 = new Event();
        e1.setId(1);
        e1.setTitle("Tech Fest");
        e1.setDescription("Annual College Tech Festival for students and faculty participation.");
        e1.setEventDate(sdfParse.parse("2026-04-15"));
        e1.setLocation("Auditorium");
        e1.setImageUrl("https://tse3.mm.bing.net/th/id/OIP.eeXzte8Y3aD3j98IblSp9gHaHa?pid=Api&P=0&h=180");
        userEvents.add(e1);

        // New Cultural Night event
        Event e2 = new Event();
        e2.setId(2);
        e2.setTitle("Cultural Night");
        e2.setDescription("Music & Dance Evening for students to showcase their talents.");
        e2.setEventDate(sdfParse.parse("2026-04-20"));
        e2.setLocation("Main Hall");
        e2.setImageUrl("https://images.unsplash.com/photo-1504805572947-34fad45aed93"); // dummy image
        userEvents.add(e2);
    }

    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
%>

<div class="sidebar">
    <h4 class="mb-4">Welcome,<br><%= user.getUsername() %></h4>
    <a href="studentDashboard.jsp">Dashboard</a>
    <a href="myEvents.jsp">My Events</a>
    <a href="events.jsp">All Events</a>
    <a href="logout">Logout</a>
</div>

<div class="main">
    <h2 class="mb-4">My Events</h2>

    <div class="row">
        <%
            if(!userEvents.isEmpty()){
                for(Event event : userEvents){
        %>
            <div class="col-md-4 mb-4">
                <div class="card card-event shadow-sm">
                    <img src="<%= event.getImageUrl() %>" class="card-img-top" alt="Event Image">
                    <div class="card-body">
                        <h5 class="card-title"><%= event.getTitle() %></h5>
                        <p class="card-text">
                            <%
                                String desc = event.getDescription();
                                if(desc.length() > 100){
                                    out.print(desc.substring(0,100) + "...");
                                } else {
                                    out.print(desc);
                                }
                            %>
                        </p>
                        <p class="text-muted">📅 <%= sdf.format(event.getEventDate()) %> | 📍 <%= event.getLocation() %></p>
                        <a href="eventDetail?id=<%= event.getId() %>" class="btn btn-primary btn-sm">View</a>
                        <a href="editEvent?id=<%= event.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="deleteEvent?id=<%= event.getId() %>" class="btn btn-danger btn-sm">Delete</a>
                    </div>
                </div>
            </div>
        <%
                }
            } else {
        %>
            <div class="col-12">
                <p class="text-center">You haven't created any events yet.</p>
            </div>
        <%
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>