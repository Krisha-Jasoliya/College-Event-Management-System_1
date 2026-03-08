<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, model.User, model.Event" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* ===== Body & Layout ===== */
        body {
            display: flex;
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f8ff;
        }

        /* ===== Sidebar ===== */
        .sidebar {
            width: 220px;
            background: #1e1e2f;
            color: #fff;
            padding: 20px;
            display: flex;
            flex-direction: column;
            transition: width 0.3s;
        }
        .sidebar h4 {
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
        }
        .sidebar a {
            color: #fff;
            display: block;
            padding: 10px 12px;
            text-decoration: none;
            border-radius: 6px;
            margin-bottom: 8px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .sidebar a:hover {
            background: #343454;
            transform: translateX(5px);
        }

        /* ===== Main Content ===== */
        .main {
            flex: 1;
            padding: 25px;
        }
        .main h2 {
            margin-bottom: 25px;
            color: #333;
        }

        /* ===== Cards ===== */
        .card-stats {
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .card-stats:hover {
            transform: translateY(-3px);
        }
        .card-stats h6 {
            font-weight: 500;
            color: #555;
            margin-bottom: 8px;
        }
        .card-stats h4 {
            margin: 0;
            font-weight: 600;
            color: #222;
        }

        /* ===== Table ===== */
        .table-responsive {
            background: #fff;
            border-radius: 12px;
            padding: 15px;
            margin-top: 25px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }
        table.table th {
            background-color: #f0f0f5;
            color: #333;
            font-weight: 600;
        }
        table.table td {
            vertical-align: middle;
        }

        /* ===== Charts ===== */
        .card-stats canvas {
            max-width: 100%;
            height: 250px;
        }

        /* ===== Responsive ===== */
        @media (max-width: 768px) {
            .sidebar {
                width: 180px;
            }
            .card-stats {
                padding: 15px;
            }
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    int totalUsers = 10;
    int totalParticipants = 25;
    int totalEvents = 4;

    List<Event> eventList = (List<Event>) request.getAttribute("events");
    if (eventList == null || eventList.isEmpty()) {
        eventList = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        Event e1 = new Event(); e1.setId(1); e1.setTitle("TechFest 2026"); e1.setEventDate(sdf.parse("2026-04-15 10:00:00"));
        e1.setLocation("Main Auditorium"); e1.setCategory("Academic"); e1.setOrganizer("Tech Club"); e1.setCapacity(100);
        e1.setRegisteredCount(1); e1.setStatus("upcoming"); eventList.add(e1);

        Event e2 = new Event(); e2.setId(2); e2.setTitle("Cultural Fiesta"); e2.setEventDate(sdf.parse("2026-05-05 17:00:00"));
        e2.setLocation("Open Ground Stage"); e2.setCategory("Cultural"); e2.setOrganizer("Cultural Committee"); e2.setCapacity(200);
        e2.setRegisteredCount(0); e2.setStatus("upcoming"); eventList.add(e2);
    }

    SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd MMM yyyy HH:mm");
%>

<div class="sidebar">
    <h4>Admin: <%= user.getUsername() %></h4>
    <a href="adminDashboard.jsp">Dashboard</a>
    <a href="createEvent.jsp">Create Event</a>
    <a href="manageEvents">Manage Events</a>
    <a href="participants">Participants</a>
    <a href="logout">Logout</a>
</div>

<div class="main">
    <h2>Dashboard</h2>
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card-stats shadow-sm">
                <h6>Total Users</h6>
                <h4><%= totalUsers %></h4>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-stats shadow-sm">
                <h6>Total Participants</h6>
                <h4><%= totalParticipants %></h4>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-stats shadow-sm">
                <h6>Total Events</h6>
                <h4><%= totalEvents %></h4>
            </div>
        </div>
    </div>

    <div class="table-responsive shadow-sm">
        <h5>All Events</h5>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th><th>Title</th><th>Date & Time</th><th>Location</th><th>Category</th><th>Organizer</th><th>Capacity</th><th>Registered</th><th>Status</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Event e : eventList) {
            %>
            <tr>
                <td><%= e.getId() %></td>
                <td><%= e.getTitle() %></td>
                <td><%= sdfDisplay.format(e.getEventDate()) %></td>
                <td><%= e.getLocation() %></td>
                <td><%= e.getCategory() %></td>
                <td><%= e.getOrganizer() %></td>
                <td><%= e.getCapacity() %></td>
                <td><%= e.getRegisteredCount() %></td>
                <td><%= e.getStatus() %></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card-stats p-3 shadow-sm">
                <h6>Booking vs Revenue</h6>
                <canvas id="bookingChart"></canvas>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card-stats p-3 shadow-sm">
                <h6>Devices by Users</h6>
                <canvas id="deviceChart"></canvas>
            </div>
        </div>
    </div>
</div>

<script>
    const ctx = document.getElementById('bookingChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
            datasets: [{label: 'Bookings', data: [5, 8, 6, 10], borderColor: '#007bff', backgroundColor: 'rgba(0,123,255,0.2)', tension: 0.4}]
        }
    });

    const deviceCtx = document.getElementById('deviceChart').getContext('2d');
    new Chart(deviceCtx, {
        type: 'doughnut',
        data: {
            labels: ['Smartphone', 'Laptop', 'Desktop', 'Tablet'],
            datasets: [{data: [35, 23, 22, 20], backgroundColor: ['#ff5733', '#3366ff', '#ffcd33', '#333333']}]
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>