<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Event,model.User,java.text.SimpleDateFormat" %>

<%
    Event event = (Event) request.getAttribute("event");
    User user = (User) session.getAttribute("user");
    Boolean registered = (Boolean) request.getAttribute("registered");
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
%>

<!DOCTYPE html>
<html>
<head>
<title><%= (event!=null)?event.getTitle():"Event Detail" %></title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

.event-banner{
height:350px;
object-fit:cover;
border-radius:10px;
}

.event-card{
border-radius:10px;
box-shadow:0 4px 10px rgba(0,0,0,0.1);
}

.info-box{
background:#f8f9fa;
padding:15px;
border-radius:8px;
margin-bottom:10px;
}

</style>

</head>

<body>

<div class="container mt-5">

<% if(event==null){ %>

<div class="alert alert-danger">Event not found</div>

<% } else { %>

<div class="row">

<!-- Left Side -->
<div class="col-md-8">

<img src="<%=event.getImageUrl()%>" class="img-fluid event-banner">

<h2 class="mt-3"><%=event.getTitle()%></h2>

<p class="text-muted">
Organized by <b><%=event.getOrganizer()%></b>
</p>

<hr>

<h4>About Event</h4>

<p>
<%=event.getDescription()%>
</p>

</div>


<!-- Right Side -->
<div class="col-md-4">

<div class="card event-card p-3">

<h5 class="mb-3">Event Details</h5>

<div class="info-box">
📅 Date<br>
<b><%=sdf.format(event.getEventDate())%></b>
</div>

<div class="info-box">
📍 Location<br>
<b><%=event.getLocation()%></b>
</div>

<div class="info-box">
🎯 Category<br>
<b><%=event.getCategory()%></b>
</div>

<div class="info-box">
🏫 Department<br>
<b><%=event.getDepartment()%></b>
</div>

<div class="info-box">
👥 Capacity<br>
<b><%=event.getCapacity()%></b>
</div>

<div class="info-box">
✅ Registered<br>
<b><%=event.getRegisteredCount()%></b>
</div>

<div class="info-box">
🟢 Remaining Slots<br>
<b><%=event.getCapacity() - event.getRegisteredCount()%></b>
</div>


<!-- Register Button -->

<% if(user!=null){ %>

<form action="registerEvent" method="post">

<input type="hidden" name="eventId" value="<%=event.getId()%>">

<button class="btn btn-<%= (registered!=null && registered)?"danger":"success" %> w-100">

<%= (registered!=null && registered)?"Unregister":"Register Now" %>

</button>

</form>

<% } else { %>

<a href="login.jsp" class="btn btn-primary w-100">
Login to Register
</a>

<% } %>

</div>

</div>

</div>

<% } %>

</div>

</body>
</html>