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

<!-- Navbar -->
<nav class="navbar">
    <a href="index.jsp" class="brand-logo">Code<span>Rush</span><span class="brand-badge">Trainer</span></a>
    
    <div class="nav-links desktop-only">
        <a href="dashboard" class="nav-link active">Dashboard</a>
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
    <a href="dashboard" class="nav-link active">Dashboard</a>
    <a href="difficulty.jsp" class="nav-link">Practice</a>
    <a href="history" class="nav-link">History</a>
    <a href="logout" class="btn btn-secondary btn-sm" style="margin-top:8px;">Log out</a>
</div>

<!-- Main Content -->
<main>
    <div class="container section" style="padding-top:40px;">

        <!-- Dashboard Header -->
        <div class="fade-up" style="display:flex; justify-content:space-between; align-items:flex-end; flex-wrap:wrap; gap:16px; margin-bottom:32px;">
            <div>
                <span class="label-tag mb-2">Trainer Overview</span>
                <h1 class="hero-heading" style="margin-top:8px; margin-bottom:4px;">
                    Welcome back, <%= user.getUsername() %>
                </h1>
                <p class="body-large">Review your current metrics and continue practicing.</p>
            </div>
            <div>
                <a href="difficulty.jsp" class="btn btn-primary btn-lg">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                    <span>Start Practice</span>
                </a>
            </div>
        </div>

        <!-- Statistics Cards Grid -->
        <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(220px, 1fr)); gap:16px; margin-bottom:36px;">

            <div class="stat-card fade-up">
                <div class="stat-label">Typing Speed</div>
                <div class="stat-value stat-value-accent"><%= avgWpm %></div>
                <div class="stat-desc">average words per minute</div>
            </div>

            <div class="stat-card fade-up delay-1">
                <div class="stat-label">Accuracy</div>
                <div class="stat-value"><%= avgAccuracy %>%</div>
                <div class="stat-desc">average keystroke correctness</div>
            </div>

            <div class="stat-card fade-up delay-2">
                <div class="stat-label">Tests Completed</div>
                <div class="stat-value"><%= totalSessions %></div>
                <div class="stat-desc">total completed sessions</div>
            </div>

        </div>

        <!-- Recent Sessions Card -->
        <div class="card card-static fade-up delay-3" style="padding:0; overflow:hidden;">
            <div style="padding:18px 24px; border-bottom:1px solid var(--border); display:flex; align-items:center; justify-content:space-between; background:var(--surface);">
                <div>
                    <h2 style="font-size:1.0625rem; font-weight:600; margin:0; color:var(--almost-black);">Recent Sessions</h2>
                    <p style="font-size:0.8125rem; color:var(--text-secondary); margin:2px 0 0;">Latest practice attempts and results</p>
                </div>
                <a href="history" class="btn btn-secondary btn-sm" style="font-weight:600; color:var(--royal-blue); border-color:var(--royal-blue-border);">
                    View All History →
                </a>
            </div>

            <% if (recentResults == null || recentResults.isEmpty()) { %>
            <div style="padding:56px 24px; text-align:center;">
                <div style="width:48px; height:48px; border-radius:12px; background:var(--surface-sunken); border:1px solid var(--border); display:flex; align-items:center; justify-content:center; margin:0 auto 16px;">
                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--text-muted)" stroke-width="1.75"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                </div>
                <h3 style="font-size:1.0625rem; margin-bottom:6px; color:var(--text-primary);">No practice sessions recorded</h3>
                <p style="color:var(--text-secondary); margin-bottom:20px; font-size:0.875rem;">Complete your first coding challenge to view your metrics here.</p>
                <a href="difficulty.jsp" class="btn btn-primary">Start Practicing</a>
            </div>
            <% } else { %>
            <div class="table-wrapper">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Language</th>
                            <th>Difficulty</th>
                            <th>Speed</th>
                            <th>Accuracy</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Result r : recentResults) { %>
                        <tr>
                            <td style="color:var(--text-secondary); font-size:0.8125rem; font-family:var(--font-mono);">
                                <%= r.getAttemptedAt().toString().substring(0, 16) %>
                            </td>
                            <td>
                                <span class="badge badge-lang"><%= r.getLanguage().toUpperCase() %></span>
                            </td>
                            <td>
                                <span class="badge badge-<%= r.getDifficulty().toLowerCase() %>"><%= r.getDifficulty().toUpperCase() %></span>
                            </td>
                            <td class="mono-cell" style="font-family:var(--font-mono); font-weight:600; color:var(--text-primary);">
                                <%= r.getWpm() %> <span style="font-size:0.75rem; font-weight:400; color:var(--text-muted);">WPM</span>
                            </td>
                            <td class="mono-cell" style="font-family:var(--font-mono); font-weight:600; color:<%= r.getAccuracy() >= 95 ? "var(--success)" : r.getAccuracy() >= 80 ? "var(--warning)" : "var(--error)" %>;">
                                <%= r.getAccuracy() %>%
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
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
