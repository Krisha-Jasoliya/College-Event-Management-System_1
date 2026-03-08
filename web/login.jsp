<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - College Event Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body { background-color: #f5f5f5; }
        .login-card { max-width: 400px; margin: 100px auto; padding: 30px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); background: #fff; }
    </style>
</head>
<body>

<div class="login-card">
    <h3 class="text-center mb-4">Login</h3>
    <form action="LoginServlet" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" name="username" class="form-control" id="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" class="form-control" id="password" required>
        </div>
        <div class="d-grid">
            <button type="submit" class="btn btn-primary">Login</button>
        </div>
        <p class="mt-3 text-center">Don't have an account? <a href="signup.jsp">Signup</a></p>
        <% String error = (String) request.getAttribute("error");
           if(error != null){ %>
           <div class="alert alert-danger mt-2 text-center"><%= error %></div>
        <% } %>
    </form>
</div>

</body>
</html>