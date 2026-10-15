<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User, com.coderush.model.Result, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    List<Result> historyList = (List<Result>) request.getAttribute("historyList");
    if (historyList == null) { historyList = java.util.Collections.emptyList(); }
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

<!-- Navbar -->
<nav class="navbar">
    <a href="index.jsp" class="brand-logo">Code<span>Rush</span><span class="brand-badge">Trainer</span></a>
    
    <div class="nav-links desktop-only">
        <a href="dashboard" class="nav-link">Dashboard</a>
        <a href="difficulty.jsp" class="nav-link">Practice</a>
        <a href="history" class="nav-link active">History</a>
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
    <a href="history" class="nav-link active">History</a>
    <a href="logout" class="btn btn-secondary btn-sm" style="margin-top:8px;">Log out</a>
</div>

<!-- Main Content -->
<main>
    <div class="container section" style="padding-top:40px;">

        <!-- Header -->
        <div class="fade-up" style="display:flex; justify-content:space-between; align-items:flex-end; flex-wrap:wrap; gap:16px; margin-bottom:32px;">
            <div>
                <span class="label-tag mb-2">Metrics Log</span>
                <h1 class="hero-heading" style="margin-top:8px; margin-bottom:4px;">Performance History</h1>
                <p class="body-large"><%= historyList.size() %> session<%= historyList.size() == 1 ? "" : "s" %> recorded</p>
            </div>
            <div>
                <a href="difficulty.jsp" class="btn btn-primary btn-lg">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                    <span>New Session</span>
                </a>
            </div>
        </div>

        <!-- Trend Chart Card -->
        <% if (!historyList.isEmpty()) { %>
        <div class="card card-static fade-up delay-1" style="padding:24px; margin-bottom:28px;">
            <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:16px;">
                <div>
                    <h2 style="font-size:1rem; font-weight:600; margin:0; color:var(--almost-black);">Speed &amp; Accuracy Progression</h2>
                    <p style="font-size:0.8125rem; color:var(--text-secondary); margin:2px 0 0;">Recent session trends</p>
                </div>
                <span style="font-size:0.75rem; font-family:var(--font-mono); color:var(--text-muted); background:var(--surface-sunken); border:1px solid var(--border); padding:3px 8px; border-radius:4px;">
                    Last 15 attempts
                </span>
            </div>
            <div style="height:220px; position:relative; width:100%;">
                <canvas id="historyTrendChart"></canvas>
            </div>
        </div>
        <% } %>

        <!-- Filter Controls -->
        <div class="fade-up delay-2" style="margin-bottom:18px; display:flex; gap:8px; flex-wrap:wrap; align-items:center;">
            <span style="font-size:0.8125rem; font-weight:600; color:var(--text-secondary); margin-right:4px;">Filter by:</span>
            <a href="history" class="lang-pill <%= (filterLang == null) ? "active" : "" %>">All</a>
            <a href="history?lang=java"   class="lang-pill <%= "java".equals(filterLang)   ? "active" : "" %>">Java</a>
            <a href="history?lang=python" class="lang-pill <%= "python".equals(filterLang) ? "active" : "" %>">Python</a>
            <a href="history?lang=c"      class="lang-pill <%= "c".equals(filterLang)      ? "active" : "" %>">C</a>
        </div>

        <!-- History Table Card -->
        <div class="card card-static fade-up delay-3" style="padding:0; overflow:hidden;">
            <% if (historyList.isEmpty()) { %>
            <div style="padding:56px 24px; text-align:center;">
                <div style="width:48px; height:48px; border-radius:12px; background:var(--surface-sunken); border:1px solid var(--border); display:flex; align-items:center; justify-content:center; margin:0 auto 16px;">
                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--text-muted)" stroke-width="1.75"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
                </div>
                <h3 style="font-size:1.0625rem; margin-bottom:6px; color:var(--text-primary);">No records found</h3>
                <p style="color:var(--text-secondary); margin-bottom:20px; font-size:0.875rem;">Complete practice challenges to build your performance history.</p>
                <a href="difficulty.jsp" class="btn btn-primary">Start Practicing</a>
            </div>
            <% } else { %>
            <div class="table-wrapper">
                <table class="data-table" id="history-table">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Language</th>
                            <th>Difficulty</th>
                            <th>Speed</th>
                            <th>Accuracy</th>
                        </tr>
                    </thead>
                    <tbody id="history-table-body">
                        <% for (Result r : historyList) { %>
                        <tr>
                            <td class="col-date" style="color:var(--text-secondary); font-size:0.8125rem; font-family:var(--font-mono);">
                                <%= r.getAttemptedAt().toString().substring(0, 16) %>
                            </td>
                            <td>
                                <span class="badge badge-lang"><%= r.getLanguage().toUpperCase() %></span>
                            </td>
                            <td>
                                <span class="badge badge-<%= r.getDifficulty().toLowerCase() %>"><%= r.getDifficulty().toUpperCase() %></span>
                            </td>
                            <td class="col-wpm mono-cell" style="font-family:var(--font-mono); font-weight:600; color:var(--text-primary);">
                                <%= r.getWpm() %> <span style="font-size:0.75rem; font-weight:400; color:var(--text-muted);">WPM</span>
                            </td>
                            <td class="col-acc mono-cell" style="font-family:var(--font-mono); font-weight:600; color:<%= r.getAccuracy() >= 95 ? "var(--success)" : r.getAccuracy() >= 80 ? "var(--warning)" : "var(--error)" %>;">
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
<script src="js/charts.js"></script>
</body>
</html>
