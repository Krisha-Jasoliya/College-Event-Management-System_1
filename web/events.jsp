<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, model.User, model.Event" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Events</title>
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
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    // Create static events
    List<Event> events = new ArrayList<>();
    SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try{
        Event e1 = new Event(); 
        e1.setId(1); 
        e1.setTitle("TechFest 2026"); 
        e1.setDescription("Annual technology festival including coding competition, robotics challenge, and AI workshop.");
        e1.setEventDate(sdfInput.parse("2026-04-15 10:00:00")); 
        e1.setLocation("Main Auditorium"); 
        e1.setCategory("Academic"); 
        e1.setDepartment("Computer Engineering"); 
        e1.setOrganizer("Tech Club"); 
        e1.setCapacity(100); 
        e1.setRegisteredCount(1); 
        e1.setImageUrl("https://images.unsplash.com/photo-1518770660439-4636190af475"); 
        e1.setStatus("upcoming"); 
        events.add(e1);

        Event e2 = new Event(); 
        e2.setId(2); 
        e2.setTitle("Cultural Fiesta"); 
        e2.setDescription("Enjoy dance, music, drama and art performances by students.");
        e2.setEventDate(sdfInput.parse("2026-05-05 17:00:00")); 
        e2.setLocation("Open Ground Stage"); 
        e2.setCategory("Cultural"); 
        e2.setDepartment("Arts Department"); 
        e2.setOrganizer("Cultural Committee"); 
        e2.setCapacity(200); 
        e2.setRegisteredCount(0); 
        e2.setImageUrl("https://images.unsplash.com/photo-1504805572947-34fad45aed93"); 
        e2.setStatus("upcoming"); 
        events.add(e2);

        Event e3 = new Event(); 
        e3.setId(3); 
        e3.setTitle("Annual Sports Day"); 
        e3.setDescription("Inter-department sports competition including cricket, football and athletics.");
        e3.setEventDate(sdfInput.parse("2026-03-20 08:00:00")); 
        e3.setLocation("College Sports Ground"); 
        e3.setCategory("Sports"); 
        e3.setDepartment("Sports Department"); 
        e3.setOrganizer("Sports Committee"); 
        e3.setCapacity(150); 
        e3.setRegisteredCount(0); 
        e3.setImageUrl("https://images.unsplash.com/photo-1521412644187-c49fa049e84d"); 
        e3.setStatus("upcoming"); 
        events.add(e3);

        Event e4 = new Event(); 
        e4.setId(4); 
        e4.setTitle("AI & Machine Learning Workshop"); 
        e4.setDescription("Hands-on workshop on Artificial Intelligence and Machine Learning basics.");
        e4.setEventDate(sdfInput.parse("2026-04-25 11:00:00")); 
        e4.setLocation("Computer Lab 2"); 
        e4.setCategory("Workshop"); 
        e4.setDepartment("Computer Engineering"); 
        e4.setOrganizer("AI Research Group"); 
        e4.setCapacity(60); 
        e4.setRegisteredCount(0); 
        e4.setImageUrl("https://images.unsplash.com/photo-1555949963-aa79dcee981c"); 
        e4.setStatus("upcoming"); 
        events.add(e4);

    } catch(Exception ex){ ex.printStackTrace(); }

    SimpleDateFormat sdfOutput = new SimpleDateFormat("dd MMM yyyy");
%>

<!-- Sidebar -->
<div class="sidebar">
    <h4 class="mb-4">Welcome,<br><%= user.getUsername() %></h4>
    <a href="studentDashboard.jsp">Dashboard</a>
    <a href="myEvents.jsp">My Events</a>
    <a href="events.jsp">All Events</a>
    <a href="logout">Logout</a>
</div>

<!-- Main Content -->
<div class="main">
    <h2 class="mb-4">All Events</h2>
    <div class="row">

        <%
            for(Event event : events){
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
            out.print(desc.substring(0,100)+"...");
        }else{
            out.print(desc);
        }
    %>
    </p>

    <p class="text-muted">
        📅 <%= sdfOutput.format(event.getEventDate()) %>
        | 📍 <%= event.getLocation() %>
    </p>

    <a href="eventDetail?id=<%= event.getId() %>" class="btn btn-primary btn-sm">View</a>

    <form action="registerEvent" method="post" style="display:inline;">
        <input type="hidden" name="eventId" value="<%= event.getId() %>">
        <button type="submit" class="btn btn-success btn-sm">Register</button>
    </form>
</div>
            </div>
        </div>
        <%
            }
        %>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>