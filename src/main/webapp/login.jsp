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

<!-- Ambient Background -->
<div class="ambient-bg" aria-hidden="true">
    <div class="blob blob-1" style="opacity:0.6;"></div>
    <div class="blob blob-3" style="opacity:0.4;"></div>
</div>
<div class="grid-overlay" aria-hidden="true"></div>

<!-- Navbar -->
<nav class="navbar">
    <a href="index.jsp" class="brand-logo">Code<span>Rush</span></a>
    <div style="display:flex;align-items:center;gap:8px;">
        <span class="text-muted" style="font-size:0.875rem;">New here?</span>
        <a href="signup.jsp" class="btn btn-secondary btn-sm">Create Account</a>
    </div>
</nav>

<!-- Auth Form -->
<div class="auth-container">
    <div class="auth-card fade-up">

        <!-- Header -->
        <div class="auth-header">
            <div class="label-tag mb-4">Welcome back</div>
            <h1>Log In to CodeRush</h1>
            <p>Continue tracking your typing metrics</p>
        </div>

        <!-- Server-side error -->
        <% String loginError = (String) request.getAttribute("error"); %>
        <% if (loginError != null) { %>
        <div class="alert alert-danger" role="alert">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <%= loginError %>
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
                    placeholder="your_username"
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
                    placeholder="••••••••"
                    autocomplete="current-password"
                    required
                >
            </div>

            <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top:8px;">
                Sign In
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
            </button>
        </form>

        <!-- Divider -->
        <div style="display:flex;align-items:center;gap:12px;margin:24px 0;">
            <div style="flex:1;height:1px;background:var(--border);"></div>
            <span style="font-size:0.75rem;color:var(--fg-muted);">OR</span>
            <div style="flex:1;height:1px;background:var(--border);"></div>
        </div>

        <p style="text-align:center;font-size:0.875rem;color:var(--fg-muted);">
            Don't have an account?
            <a href="signup.jsp" style="color:var(--accent);text-decoration:none;font-weight:500;">Sign up free</a>
        </p>
    </div>
</div>

<script src="js/auth.js"></script>
</body>
</html>
