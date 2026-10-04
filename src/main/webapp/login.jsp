<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log In - CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <a href="index.jsp" class="brand-logo">
            <span>⌨️</span> Code<span class="brand-badge">Rush</span>
        </a>
        <div class="nav-links">
            <a href="signup.jsp" class="nav-link">New here? Sign Up</a>
        </div>
    </nav>

    <main class="container container-narrow">
        <div class="card" style="margin-top: 2rem;">
            <div class="card-header" style="text-align: center;">
                <h1 class="card-title">Welcome Back</h1>
                <p class="card-subtitle">Log in to track your typing metrics</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <span>⚠️</span> <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form id="login-form" action="login" method="POST">
                <div class="form-group">
                    <label class="form-label" for="identifier">Username or Email</label>
                    <input type="text" id="identifier" name="identifier" class="form-control" placeholder="username or email" required autofocus>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top: 1.5rem;">Sign In</button>
            </form>

            <div style="text-align: center; margin-top: 1.5rem; font-size: 0.9rem; color: var(--text-secondary);">
                Don't have an account? <a href="signup.jsp" style="color: var(--accent-cyan); font-weight: 600; text-decoration: none;">Sign Up</a>
            </div>
        </div>
    </main>

    <script src="js/auth.js"></script>
</body>
</html>
