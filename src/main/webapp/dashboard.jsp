<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User, com.coderush.model.Result, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    List<Result> recentResults = (List<Result>) request.getAttribute("recentResults");
    String avgWpm      = (String)  request.getAttribute("avgWpm");
    String avgAccuracy = (String)  request.getAttribute("avgAccuracy");
    Integer totalSessions = (Integer) request.getAttribute("totalSessions");
    if (totalSessions == null) totalSessions = 0;
    if (avgWpm == null)      avgWpm      = "0.0";
    if (avgAccuracy == null) avgAccuracy = "0.0";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Ambient Background -->
<div class="ambient-bg" aria-hidden="true">
    <div class="blob blob-1" style="opacity:0.35;"></div>
    <div class="blob blob-4" style="opacity:0.5;"></div>
</div>
<div class="grid-overlay" aria-hidden="true"></div>

<!-- Navbar -->
<nav class="navbar">
    <a href="index.jsp" class="brand-logo">Code<span>Rush</span></a>
    <div class="nav-links desktop-only">
        <a href="difficulty.jsp" class="nav-link">Practice</a>
        <a href="history" class="nav-link">History</a>
    </div>
    <div class="nav-actions desktop-only" style="display:flex;align-items:center;gap:12px;">
        <span style="font-size:0.875rem;font-weight:500;color:var(--fg-muted);">
            <span style="color:var(--fg);"><%= user.getUsername() %></span>
        </span>
        <a href="logout" class="btn btn-ghost btn-sm">Log out</a>
    </div>
    <button class="nav-toggle" id="nav-toggle" aria-label="Toggle menu">
        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5">
            <path d="M3 6h14M3 10h14M3 14h14"/>
        </svg>
    </button>
</nav>
<div class="mobile-menu" id="mobile-menu">
    <a href="difficulty.jsp" class="nav-link">Practice</a>
    <a href="history" class="nav-link">History</a>
    <a href="logout" class="btn btn-ghost btn-sm" style="margin-top:8px;">Log out</a>
</div>

<!-- Main Content -->
<main>
    <div class="container section" style="padding-top:48px;">

        <!-- Dashboard Header -->
        <div class="fade-up" style="margin-bottom:48px;">
            <div class="label-tag mb-2">Your progress</div>
            <h1 class="hero-heading text-gradient" style="margin-bottom:8px;">
                Welcome back, <%= user.getUsername() %>
            </h1>
            <p class="body-large">Here's how your coding speed is progressing.</p>
        </div>

        <!-- Stat Cards Grid -->
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:20px;margin-bottom:40px;">

            <div class="stat-card fade-up">
                <div class="stat-label">Avg WPM</div>
                <div class="stat-value stat-value-accent"><%= avgWpm %></div>
                <div style="margin-top:12px;font-size:0.75rem;color:var(--fg-muted);">words per minute</div>
            </div>

            <div class="stat-card fade-up delay-1">
                <div class="stat-label">Accuracy</div>
                <div class="stat-value"><%= avgAccuracy %>%</div>
                <div style="margin-top:12px;font-size:0.75rem;color:var(--fg-muted);">average correctness</div>
            </div>

            <div class="stat-card fade-up delay-2">
                <div class="stat-label">Sessions</div>
                <div class="stat-value"><%= totalSessions %></div>
                <div style="margin-top:12px;font-size:0.75rem;color:var(--fg-muted);">completed sessions</div>
            </div>

        </div>

        <!-- Quick Actions -->
        <div style="display:flex;gap:12px;margin-bottom:48px;flex-wrap:wrap;" class="fade-up delay-3">
            <a href="difficulty.jsp" class="btn btn-primary">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                Quick Practice
            </a>
            <a href="history" class="btn btn-secondary">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
                Full History
            </a>
        </div>

        <!-- Recent Sessions Table -->
        <div class="card card-static fade-up delay-2" style="padding:0;overflow:hidden;">
            <div style="padding:20px 24px;border-bottom:1px solid var(--border);display:flex;align-items:center;justify-content:space-between;">
                <h2 style="font-size:1.125rem;font-weight:600;margin:0;">Recent Sessions</h2>
                <a href="history" style="font-size:0.8125rem;color:var(--accent);text-decoration:none;font-weight:500;">View all →</a>
            </div>

            <% if (recentResults == null || recentResults.isEmpty()) { %>
            <div style="padding:60px 24px;text-align:center;">
                <div style="width:48px;height:48px;border-radius:12px;background:rgba(255,255,255,0.04);border:1px solid var(--border);display:flex;align-items:center;justify-content:center;margin:0 auto 16px;">
                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--fg-muted)" stroke-width="1.5"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                </div>
                <p style="color:var(--fg-muted);margin-bottom:16px;">No sessions yet. Start your first practice!</p>
                <a href="difficulty.jsp" class="btn btn-primary btn-sm">Start Practicing</a>
            </div>
            <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Language</th>
                        <th>Difficulty</th>
                        <th>WPM</th>
                        <th>Accuracy</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Result r : recentResults) { %>
                    <tr>
                        <td style="color:var(--fg-muted);font-size:0.8125rem;"><%= r.getAttemptedAt().toString().substring(0, 16) %></td>
                        <td>
                            <span class="badge badge-lang" style="font-size:0.6875rem;"><%= r.getLanguage().toUpperCase() %></span>
                        </td>
                        <td>
                            <span class="badge badge-<%= r.getDifficulty().toLowerCase() %>"
                                  style="font-size:0.6875rem;"><%= r.getDifficulty().toUpperCase() %></span>
                        </td>
                        <td class="mono-cell" style="font-family:var(--font-mono);font-weight:600;"><%= r.getWpm() %></td>
                        <td class="mono-cell" style="font-family:var(--font-mono);color:<%=r.getAccuracy() >= 95 ? "#4ade80" : r.getAccuracy() >= 80 ? "#fbbf24" : "#f87171"%>;"><%= r.getAccuracy() %>%</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } %>
        </div>

    </div>
</main>

<script>
    const navToggle = document.getElementById('nav-toggle');
    const mobileMenu = document.getElementById('mobile-menu');
    navToggle.addEventListener('click', () => mobileMenu.classList.toggle('open'));

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(e => {
            if (e.isIntersecting) { e.target.style.animationPlayState = 'running'; observer.unobserve(e.target); }
        });
    }, { threshold: 0.1 });
    document.querySelectorAll('.fade-up').forEach(el => { el.style.animationPlayState = 'paused'; observer.observe(el); });
</script>
</body>
</html>
