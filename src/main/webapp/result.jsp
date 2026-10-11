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
    <title>Session Complete — CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Ambient Background -->
<div class="ambient-bg" aria-hidden="true">
    <div class="blob blob-1" style="opacity:0.45;"></div>
    <div class="blob blob-4" style="opacity:0.6;"></div>
</div>
<div class="grid-overlay" aria-hidden="true"></div>

<!-- Navbar -->
<nav class="navbar">
    <a href="index.jsp" class="brand-logo">Code<span>Rush</span></a>
    <div class="nav-links desktop-only">
        <a href="dashboard" class="nav-link">Dashboard</a>
        <a href="history" class="nav-link">History</a>
    </div>
    <div class="nav-actions desktop-only" style="display:flex;align-items:center;gap:12px;">
        <span style="font-size:0.875rem;color:var(--fg-muted);"><%= user.getUsername() %></span>
        <a href="logout" class="btn btn-ghost btn-sm">Log out</a>
    </div>
    <button class="nav-toggle" id="nav-toggle" aria-label="Toggle menu">
        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5">
            <path d="M3 6h14M3 10h14M3 14h14"/>
        </svg>
    </button>
</nav>
<div class="mobile-menu" id="mobile-menu">
    <a href="dashboard" class="nav-link">Dashboard</a>
    <a href="history" class="nav-link">History</a>
    <a href="logout" class="btn btn-ghost btn-sm" style="margin-top:8px;">Log out</a>
</div>

<!-- Main Content -->
<main>
    <div class="container section" style="padding-top:64px;max-width:800px;text-align:center;">

        <!-- Completion Icon -->
        <div class="fade-up" style="margin-bottom:24px;">
            <div style="width:72px;height:72px;border-radius:20px;background:rgba(34,197,94,0.10);border:1px solid rgba(34,197,94,0.20);display:flex;align-items:center;justify-content:center;margin:0 auto;">
                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#4ade80" stroke-width="1.5"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
            </div>
        </div>

        <!-- Heading -->
        <div class="label-tag mb-4 fade-up delay-1">Session complete</div>
        <h1 class="hero-heading text-gradient fade-up delay-1" style="margin-bottom:8px;">
            Nice work, <%= user.getUsername() %>!
        </h1>
        <p class="body-large fade-up delay-2" style="margin-bottom:48px;">
            Here's how you performed. Keep practicing to push those numbers up.
        </p>

        <% if (result != null) { %>

        <!-- Result Metrics -->
        <div class="result-grid fade-up delay-2">

            <div class="result-metric">
                <h3>Speed</h3>
                <div class="value" style="color: <%=result.getWpm() >= 60 ? "#4ade80" : result.getWpm() >= 40 ? "#fbbf24" : "var(--fg)"%>;">
                    <%= result.getWpm() %><span style="font-size:1.25rem;font-weight:400;color:var(--fg-muted);"> WPM</span>
                </div>
            </div>

            <div class="result-metric">
                <h3>Accuracy</h3>
                <div class="value" style="color: <%=result.getAccuracy() >= 95 ? "#4ade80" : result.getAccuracy() >= 80 ? "#fbbf24" : "#f87171"%>;">
                    <%= result.getAccuracy() %><span style="font-size:1.25rem;font-weight:400;color:var(--fg-muted);">%</span>
                </div>
            </div>

            <div class="result-metric">
                <h3>Mistakes</h3>
                <div class="value" style="color: <%=result.getMistakes() == 0 ? "#4ade80" : result.getMistakes() <= 3 ? "#fbbf24" : "#f87171"%>;">
                    <%= result.getMistakes() %><span style="font-size:1.25rem;font-weight:400;color:var(--fg-muted);"> errors</span>
                </div>
            </div>

        </div>

        <!-- Language + Difficulty badges -->
        <div style="display:flex;gap:8px;justify-content:center;margin-bottom:40px;" class="fade-up delay-3">
            <span class="badge badge-lang"><%= result.getLanguage().toUpperCase() %></span>
            <span class="badge badge-<%= result.getDifficulty().toLowerCase() %>"><%= result.getDifficulty().toUpperCase() %></span>
        </div>

        <% } else { %>
        <div class="card fade-up delay-2" style="text-align:center;padding:40px;margin-bottom:40px;">
            <p class="text-muted">Result data is not available. Please try again.</p>
        </div>
        <% } %>

        <!-- Actions -->
        <div style="display:flex;gap:16px;justify-content:center;flex-wrap:wrap;" class="fade-up delay-3">
            <a href="difficulty.jsp" class="btn btn-primary btn-lg">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="1 4 1 10 7 10"/><path d="M3.51 15a9 9 0 1 0 .49-3.01"/></svg>
                Practice Again
            </a>
            <a href="dashboard" class="btn btn-secondary btn-lg">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                Dashboard
            </a>
            <a href="history" class="btn btn-ghost btn-lg">View History</a>
        </div>

    </div>
</main>

<script>
    const navToggle = document.getElementById('nav-toggle');
    const mobileMenu = document.getElementById('mobile-menu');
    navToggle.addEventListener('click', () => mobileMenu.classList.toggle('open'));

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(e => { if (e.isIntersecting) { e.target.style.animationPlayState = 'running'; observer.unobserve(e.target); } });
    }, { threshold: 0.1 });
    document.querySelectorAll('.fade-up').forEach(el => { el.style.animationPlayState = 'paused'; observer.observe(el); });
</script>
</body>
</html>
