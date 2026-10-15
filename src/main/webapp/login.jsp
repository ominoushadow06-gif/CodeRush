<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log In — CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="brand-logo">Code<span>Rush</span><span class="brand-badge">Trainer</span></a>
        <div></div>
        <div class="nav-actions">
            <span class="text-muted" style="font-size:0.875rem;">New to CodeRush?</span>
            <a href="signup.jsp" class="btn btn-secondary btn-sm">Create Account</a>
        </div>
    </div>
</nav>

<!-- Auth Container (Intentionally Compact & Centered) -->
<div class="auth-container">
    <div class="auth-card fade-up">

        <!-- Header -->
        <div class="auth-header">
            <span class="label-tag">Welcome Back</span>
            <h1>Log in to CodeRush</h1>
            <p>Improve your coding speed and accuracy.</p>
        </div>

        <!-- Server-side error -->
        <% String loginError = (String) request.getAttribute("error"); %>
        <% if (loginError != null) { %>
        <div class="alert alert-danger" role="alert">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="flex-shrink:0;"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <span><%= loginError %></span>
        </div>
        <% } %>

        <!-- Login Form -->
        <form id="login-form" action="login" method="POST">
            <div class="form-group">
                <label for="identifier" class="form-label">Username or Email</label>
                <input
                    type="text"
                    id="identifier"
                    name="identifier"
                    class="form-input"
                    placeholder="Enter username or email"
                    autocomplete="username"
                    required
                >
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    class="form-input"
                    placeholder="Enter your password"
                    autocomplete="current-password"
                    required
                >
            </div>

            <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top:12px;">
                <span>Sign In</span>
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
            </button>
        </form>

        <!-- Footer link -->
        <p style="text-align:center;font-size:0.875rem;color:var(--text-secondary);margin-top:24px;">
            Don't have an account?
            <a href="signup.jsp" style="color:var(--royal-blue);text-decoration:none;font-weight:600;">Sign up free</a>
        </p>
    </div>
</div>

<script src="js/auth.js"></script>
</body>
</html>
