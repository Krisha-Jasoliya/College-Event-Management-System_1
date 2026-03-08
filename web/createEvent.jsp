<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background:#f5f8ff; font-family:'Segoe UI', sans-serif; padding:30px; }
        .card { border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.1); }
        .card-body { padding:25px; }
        .form-control { border-radius:8px; }
        .btn-primary { background:#007bff; border:none; }
        .btn-primary:hover { background:#0056b3; }
        .btn-secondary { background:#6c757d; border:none; }
        .btn-secondary:hover { background:#5a6268; }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if(user == null || !"ADMIN".equalsIgnoreCase(user.getRole())){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="container">
    <div class="card mx-auto" style="max-width: 700px;">
        <div class="card-body">
            <h3 class="mb-4">Create New Event</h3>
            <form action="createEvent" method="post">

                <div class="mb-3">
                    <label>Title</label>
                    <input type="text" name="title" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Description</label>
                    <textarea name="description" class="form-control" rows="4" required></textarea>
                </div>

                <div class="row mb-3">
                    <div class="col">
                        <label>Date</label>
                        <input type="date" name="event_date" class="form-control" required>
                    </div>
                    <div class="col">
                        <label>Time</label>
                        <input type="time" name="event_time" class="form-control" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label>Location</label>
                    <input type="text" name="location" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Category</label>
                    <select name="category" class="form-control">
                        <option>Academic</option>
                        <option>Cultural</option>
                        <option>Sports</option>
                        <option>Workshop</option>
                        <option>Seminar</option>
                        <option>Social</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label>Department</label>
                    <input type="text" name="department" class="form-control">
                </div>

                <div class="mb-3">
                    <label>Organizer</label>
                    <input type="text" name="organizer" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Capacity</label>
                    <input type="number" name="capacity" class="form-control" min="1" required>
                </div>

                <div class="mb-3">
                    <label>Image URL</label>
                    <input type="text" name="image_url" class="form-control">
                </div>

                <div class="mb-3">
                    <label>Status</label>
                    <select name="status" class="form-control">
                        <option>upcoming</option>
                        <option>ongoing</option>
                        <option>past</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Create Event</button>
                <a href="adminDashboard.jsp" class="btn btn-secondary">Cancel</a>

            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>