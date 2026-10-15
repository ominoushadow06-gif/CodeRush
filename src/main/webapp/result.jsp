<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User, com.coderush.model.Result" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    Result result = (Result) request.getAttribute("latestResult");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Summary — CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <a href="index.jsp" class="brand-logo">Code<span>Rush</span><span class="brand-badge">Trainer</span></a>
    
    <div class="nav-links desktop-only">
        <a href="dashboard" class="nav-link">Dashboard</a>
        <a href="difficulty.jsp" class="nav-link">Practice</a>
        <a href="history" class="nav-link">History</a>
    </div>

    <div class="nav-actions desktop-only">
        <div class="user-pill">
            <span class="user-avatar"><%= user.getUsername().substring(0, 1) %></span>
            <span><%= user.getUsername() %></span>
        </div>
        <a href="logout" class="btn btn-ghost btn-sm">Log out</a>
    </div>

    <button class="nav-toggle" id="nav-toggle" aria-label="Toggle menu">
        <svg width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.75">
            <path d="M3 5h14M3 10h14M3 15h14"/>
        </svg>
    </button>
</nav>

<!-- Mobile Menu -->
<div class="mobile-menu" id="mobile-menu">
    <div style="padding: 4px 14px 8px; font-weight: 600; color: var(--text-primary);">
        Signed in as <%= user.getUsername() %>
    </div>
    <a href="dashboard" class="nav-link">Dashboard</a>
    <a href="difficulty.jsp" class="nav-link">Practice</a>
    <a href="history" class="nav-link">History</a>
    <a href="logout" class="btn btn-secondary btn-sm" style="margin-top:8px;">Log out</a>
</div>

<!-- Main Content -->
<main>
    <div class="container section" style="padding-top:40px; max-width:840px;">

        <!-- Header -->
        <div class="text-center fade-up" style="margin-bottom:28px;">
            <div style="width:48px; height:48px; border-radius:12px; background:var(--royal-blue-subtle); border:1px solid var(--royal-blue-border); display:flex; align-items:center; justify-content:center; margin:0 auto 16px;">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--royal-blue)" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <span class="label-tag mb-2">Session Complete</span>
            <h1 class="hero-heading" style="margin-top:8px; margin-bottom:6px;">Performance Summary</h1>
            <p class="body-large">Nice work, <%= user.getUsername() %>! Here is your typing breakdown.</p>
        </div>

        <% if (result != null) { %>

        <!-- Language & Difficulty Chips -->
        <div style="display:flex; gap:8px; justify-content:center; align-items:center; margin-bottom:28px;" class="fade-up delay-1">
            <span class="badge badge-lang" style="font-size:0.75rem; padding:4px 12px;"><%= result.getLanguage().toUpperCase() %></span>
            <span class="badge badge-<%= result.getDifficulty().toLowerCase() %>" style="font-size:0.75rem; padding:4px 12px;"><%= result.getDifficulty().toUpperCase() %></span>
        </div>

        <!-- Metrics Grid -->
        <div class="result-grid fade-up delay-2">

            <!-- WPM: Prominently Highlighted with Royal Blue -->
            <div class="result-metric result-metric-primary">
                <h3>Typing Speed</h3>
                <div class="value value-accent"><%= result.getWpm() %></div>
                <div style="margin-top:8px; font-size:0.75rem; color:var(--royal-blue); font-weight:600; font-family:var(--font-mono);">WORDS PER MINUTE</div>
            </div>

            <!-- Accuracy -->
            <div class="result-metric">
                <h3>Accuracy</h3>
                <div class="value" style="color: <%= result.getAccuracy() >= 95 ? "var(--success)" : result.getAccuracy() >= 80 ? "var(--warning)" : "var(--error)" %>;">
                    <%= result.getAccuracy() %><span style="font-size:1.5rem; font-weight:500;">%</span>
                </div>
                <div style="margin-top:8px; font-size:0.75rem; color:var(--text-muted); font-family:var(--font-mono);">CORRECTNESS</div>
            </div>

            <!-- Time Taken -->
            <div class="result-metric">
                <h3>Elapsed Time</h3>
                <div class="value">
                    <%= result.getTimeTaken() %><span style="font-size:1.25rem; font-weight:400; color:var(--text-muted);">s</span>
                </div>
                <div style="margin-top:8px; font-size:0.75rem; color:var(--text-muted); font-family:var(--font-mono);">SECONDS DURATION</div>
            </div>

            <!-- Errors -->
            <div class="result-metric">
                <h3>Errors</h3>
                <div class="value" style="color: <%= result.getMistakes() == 0 ? "var(--success)" : result.getMistakes() <= 3 ? "var(--warning)" : "var(--error)" %>;">
                    <%= result.getMistakes() %>
                </div>
                <div style="margin-top:8px; font-size:0.75rem; color:var(--text-muted); font-family:var(--font-mono);">MISTAKES RECORDED</div>
            </div>

        </div>

        <% } else { %>
        <div class="card fade-up delay-1" style="text-align:center; padding:48px 24px; margin-bottom:32px;">
            <p class="text-muted">No result record was found for this session.</p>
        </div>
        <% } %>

        <!-- Primary & Secondary Actions -->
        <div style="display:flex; gap:12px; justify-content:center; flex-wrap:wrap; margin-top:36px;" class="fade-up delay-3">
            <a href="difficulty.jsp" class="btn btn-primary btn-lg">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polyline points="1 4 1 10 7 10"/><path d="M3.51 15a9 9 0 1 0 .49-3.01"/></svg>
                <span>Practice Again</span>
            </a>
            <a href="dashboard" class="btn btn-secondary btn-lg">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                <span>Dashboard</span>
            </a>
            <a href="history" class="btn btn-secondary btn-lg">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
                <span>View History</span>
            </a>
        </div>

    </div>
</main>

<script>
    const navToggle = document.getElementById('nav-toggle');
    const mobileMenu = document.getElementById('mobile-menu');
    if (navToggle && mobileMenu) {
        navToggle.addEventListener('click', () => mobileMenu.classList.toggle('open'));
    }
</script>
</body>
</html>
