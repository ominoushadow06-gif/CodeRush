<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    String lang = request.getParameter("lang");
    if (lang == null || lang.trim().isEmpty()) { lang = "java"; }
    lang = lang.toLowerCase().trim();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Difficulty — CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="brand-logo">Code<span>Rush</span><span class="brand-badge">Trainer</span></a>
        
        <div class="nav-links desktop-only">
            <a href="dashboard" class="nav-link">Dashboard</a>
            <a href="difficulty.jsp" class="nav-link active">Practice</a>
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
    </div>
</nav>

<!-- Mobile Menu -->
<div class="mobile-menu" id="mobile-menu">
    <div style="padding: 4px 14px 8px; font-weight: 600; color: var(--text-primary);">
        Signed in as <%= user.getUsername() %>
    </div>
    <a href="dashboard" class="nav-link">Dashboard</a>
    <a href="difficulty.jsp" class="nav-link active">Practice</a>
    <a href="history" class="nav-link">History</a>
    <a href="logout" class="btn btn-secondary btn-sm" style="margin-top:8px;">Log out</a>
</div>

<!-- Main Content -->
<main>
    <div class="container container-difficulty section" style="padding-top:40px;">

        <!-- Page Header -->
        <div class="text-center fade-up" style="margin-bottom:32px;">
            <span class="label-tag mb-2">Practice Setup</span>
            <h1 class="hero-heading" style="margin-top:8px; margin-bottom:8px;">Choose your difficulty</h1>
            <p class="body-large" style="max-width:580px; margin:0 auto;">
                Select your programming language and challenge level to begin typing real code snippets.
            </p>
        </div>

        <!-- Language Picker -->
        <div class="fade-up delay-1" style="margin-bottom:32px; text-align:center;">
            <div style="font-size:0.75rem; font-weight:600; font-family:var(--font-mono); text-transform:uppercase; color:var(--text-muted); margin-bottom:10px; letter-spacing:0.05em;">
                Programming Language
            </div>
            <div class="lang-pills" role="tablist">
                <a href="difficulty.jsp?lang=java"
                   class="lang-pill <%= "java".equals(lang) ? "active" : "" %>"
                   role="tab"
                   aria-selected="<%= "java".equals(lang) ? "true" : "false" %>">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:6px;"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg>
                    Java
                </a>
                <a href="difficulty.jsp?lang=python"
                   class="lang-pill <%= "python".equals(lang) ? "active" : "" %>"
                   role="tab"
                   aria-selected="<%= "python".equals(lang) ? "true" : "false" %>">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:6px;"><path d="M13 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V9z"/><polyline points="13 2 13 9 20 9"/></svg>
                    Python
                </a>
                <a href="difficulty.jsp?lang=c"
                   class="lang-pill <%= "c".equals(lang) ? "active" : "" %>"
                   role="tab"
                   aria-selected="<%= "c".equals(lang) ? "true" : "false" %>">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:6px;"><polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/></svg>
                    C
                </a>
            </div>
        </div>

        <!-- Difficulty Cards 3-Column Grid (Wider horizontal utilization) -->
        <div class="difficulty-grid">

            <!-- Easy: Fundamentals -->
            <div class="feature-card fade-up delay-2">
                <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:14px;">
                    <div class="feature-card-icon" style="background:var(--success-bg); border:1px solid var(--success-border);">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--success)" stroke-width="2"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                    </div>
                    <span class="badge badge-easy">Easy</span>
                </div>
                <h3>Fundamentals</h3>
                <p>Standard syntax, variable declarations, arithmetic expressions, and basic loops. Ideal for warming up fingers and building rhythm.</p>
                <a href="practice.jsp?language=<%= lang %>&difficulty=easy" class="btn btn-primary btn-block">
                    <span>Start Easy</span>
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </a>
            </div>

            <!-- Medium: Intermediate -->
            <div class="feature-card fade-up delay-3">
                <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:14px;">
                    <div class="feature-card-icon" style="background:var(--warning-bg); border:1px solid var(--warning-border);">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--warning)" stroke-width="2"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
                    </div>
                    <span class="badge badge-medium">Medium</span>
                </div>
                <h3>Intermediate</h3>
                <p>Method definitions, branching conditionals, array manipulation, and common algorithmic control flow. Requires disciplined accuracy.</p>
                <a href="practice.jsp?language=<%= lang %>&difficulty=medium" class="btn btn-primary btn-block">
                    <span>Start Medium</span>
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </a>
            </div>

            <!-- Hard: Advanced -->
            <div class="feature-card fade-up delay-4">
                <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:14px;">
                    <div class="feature-card-icon" style="background:var(--error-bg); border:1px solid var(--error-border);">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--error)" stroke-width="2"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>
                    </div>
                    <span class="badge badge-hard">Hard</span>
                </div>
                <h3>Advanced</h3>
                <p>Complex data structures, object-oriented paradigms, recursion, nested constructs, and high-speed precision typing challenges.</p>
                <a href="practice.jsp?language=<%= lang %>&difficulty=hard" class="btn btn-primary btn-block">
                    <span>Start Hard</span>
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </a>
            </div>

        </div>

        <!-- Technical Shortcut Hint -->
        <div class="text-center fade-up delay-5">
            <span style="font-size:0.8125rem; color:var(--text-muted); display:inline-flex; align-items:center; gap:6px;">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>
                <span>Press <kbd>Tab</kbd> or <kbd>Esc</kbd> anytime during practice to instantly restart.</span>
            </span>
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
