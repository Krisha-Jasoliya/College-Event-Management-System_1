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
    SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Event - <%= (event != null) ? event.getTitle() : "" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">

<% if(event == null){ %>
    <div class="alert alert-danger">Event not found</div>
<% } else { %>
    <h3>Edit Event - <%= event.getTitle() %></h3>
    <form action="updateEvent" method="post">
        <input type="hidden" name="id" value="<%= event.getId() %>">

        <div class="mb-3">
            <label>Title</label>
            <input type="text" name="title" value="<%= event.getTitle() %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control" required><%= event.getDescription() %></textarea>
        </div>

        <div class="row mb-3">
            <div class="col">
                <label>Date</label>
                <input type="date" name="event_date" value="<%= sdfDate.format(event.getEventDate()) %>" class="form-control" required>
            </div>
            <div class="col">
                <label>Time</label>
                <input type="time" name="event_time" value="<%= sdfTime.format(event.getEventDate()) %>" class="form-control" required>
            </div>
        </div>

        <div class="mb-3">
            <label>Location</label>
            <input type="text" name="location" value="<%= event.getLocation() %>" class="form-control">
        </div>

        <div class="mb-3">
            <label>Capacity</label>
            <input type="number" name="capacity" class="form-control" value="<%= event.getCapacity() %>" min="1" required>
        </div>

        <button type="submit" class="btn btn-primary">Update Event</button>
    </form>
<% } %>

</div>
</body>
</html>