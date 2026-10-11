<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User, com.coderush.model.Result, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    List<Result> historyList = (List<Result>) request.getAttribute("historyList");
    if (historyList == null) { historyList = java.util.Collections.emptyList(); }
    // Filter params for potential filtering
    String filterLang = request.getParameter("lang");
    String filterDiff = request.getParameter("difficulty");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Performance History — CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<!-- Ambient Background -->
<div class="ambient-bg" aria-hidden="true">
    <div class="blob blob-1" style="opacity:0.30;"></div>
    <div class="blob blob-2" style="opacity:0.25;"></div>
    <div class="blob blob-4" style="opacity:0.40;"></div>
</div>
<div class="grid-overlay" aria-hidden="true"></div>

<!-- Navbar -->
<nav class="navbar">
    <a href="index.jsp" class="brand-logo">Code<span>Rush</span></a>
    <div class="nav-links desktop-only">
        <a href="dashboard" class="nav-link">Dashboard</a>
        <a href="difficulty.jsp" class="nav-link">Practice</a>
        <a href="history" class="nav-link active">History</a>
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
    <a href="difficulty.jsp" class="nav-link">Practice</a>
    <a href="history" class="nav-link">History</a>
    <a href="logout" class="btn btn-ghost btn-sm" style="margin-top:8px;">Log out</a>
</div>

<!-- Main Content -->
<main>
    <div class="container section" style="padding-top:48px;">

        <!-- Head -->
        <div class="fade-up" style="margin-bottom:40px;display:flex;align-items:flex-end;justify-content:space-between;flex-wrap:wrap;gap:16px;">
            <div>
                <div class="label-tag mb-2">Your progress</div>
                <h1 class="hero-heading text-gradient" style="margin-bottom:8px;">Performance History</h1>
                <p class="text-muted" style="font-size:0.9375rem;"><%= historyList.size() %> sessions recorded</p>
            </div>
            <a href="difficulty.jsp" class="btn btn-primary">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                New Session
            </a>
        </div>

        <!-- Trend Chart -->
        <% if (!historyList.isEmpty()) { %>
        <div class="card card-static fade-up delay-1" style="padding:28px;margin-bottom:32px;">
            <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;">
                <h2 style="font-size:1rem;font-weight:600;margin:0;">Speed &amp; Accuracy Trend</h2>
                <span style="font-size:0.75rem;color:var(--fg-muted);">Last 15 sessions</span>
            </div>
            <div style="height:240px;position:relative;">
                <canvas id="historyTrendChart"></canvas>
            </div>
        </div>
        <% } %>

        <!-- Filter Section -->
        <div class="fade-up delay-2" style="margin-bottom:20px;display:flex;gap:8px;flex-wrap:wrap;align-items:center;">
            <span style="font-size:0.8125rem;color:var(--fg-muted);margin-right:4px;">Filter by language:</span>
            <a href="history" class="lang-pill <%= (filterLang == null) ? "active" : "" %>">All</a>
            <a href="history?lang=java"   class="lang-pill <%= "java".equals(filterLang)   ? "active" : "" %>">Java</a>
            <a href="history?lang=python" class="lang-pill <%= "python".equals(filterLang) ? "active" : "" %>">Python</a>
            <a href="history?lang=c"      class="lang-pill <%= "c".equals(filterLang)      ? "active" : "" %>">C</a>
        </div>

        <!-- History Table -->
        <div class="card card-static fade-up delay-3" style="padding:0;overflow:hidden;">
            <% if (historyList.isEmpty()) { %>
            <div style="padding:60px 24px;text-align:center;">
                <div style="width:52px;height:52px;border-radius:14px;background:rgba(255,255,255,0.04);border:1px solid var(--border);display:flex;align-items:center;justify-content:center;margin:0 auto 16px;">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--fg-muted)" stroke-width="1.5"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
                </div>
                <p style="color:var(--fg-muted);margin-bottom:20px;">No sessions found. Start practicing to build your history!</p>
                <a href="difficulty.jsp" class="btn btn-primary">Start Practicing</a>
            </div>
            <% } else { %>
            <table class="data-table" id="history-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Language</th>
                        <th>Difficulty</th>
                        <th>WPM</th>
                        <th>Accuracy</th>
                    </tr>
                </thead>
                <tbody id="history-table-body">
                    <% for (Result r : historyList) { %>
                    <tr>
                        <td class="col-date" style="color:var(--fg-muted);font-size:0.8125rem;"><%= r.getAttemptedAt().toString().substring(0, 16) %></td>
                        <td><span class="badge badge-lang" style="font-size:0.6875rem;"><%= r.getLanguage().toUpperCase() %></span></td>
                        <td><span class="badge badge-<%= r.getDifficulty().toLowerCase() %>" style="font-size:0.6875rem;"><%= r.getDifficulty().toUpperCase() %></span></td>
                        <td class="col-wpm mono-cell" style="font-family:var(--font-mono);font-weight:600;"><%= r.getWpm() %></td>
                        <td class="col-acc mono-cell"
                            style="font-family:var(--font-mono);color:<%=r.getAccuracy()>=95?"#4ade80":r.getAccuracy()>=80?"#fbbf24":"#f87171"%>;">
                            <%= r.getAccuracy() %>%
                        </td>
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
        entries.forEach(e => { if (e.isIntersecting) { e.target.style.animationPlayState = 'running'; observer.unobserve(e.target); } });
    }, { threshold: 0.05 });
    document.querySelectorAll('.fade-up').forEach(el => { el.style.animationPlayState = 'paused'; observer.observe(el); });
</script>
<script src="js/charts.js"></script>
</body>
</html>
