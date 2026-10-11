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
    <title>Choose Your Arena — CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Ambient Background -->
<div class="ambient-bg" aria-hidden="true">
    <div class="blob blob-1" style="opacity:0.4;"></div>
    <div class="blob blob-2" style="opacity:0.3;"></div>
    <div class="blob blob-3" style="opacity:0.3;"></div>
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
    <div class="container section" style="padding-top:64px;">

        <!-- Page Header -->
        <div class="text-center fade-up" style="margin-bottom:56px;">
            <div class="label-tag mb-4">Select your challenge</div>
            <h1 class="hero-heading text-gradient" style="margin-bottom:16px;">Choose Your Arena</h1>
            <p class="body-large" style="max-width:480px;margin:0 auto;">
                Pick your programming language and difficulty level. Each session uses real code snippets.
            </p>
        </div>

        <!-- Language Picker -->
        <div class="lang-pills fade-up delay-1" style="margin-bottom:48px;" role="tablist">
            <a href="difficulty.jsp?lang=java"
               class="lang-pill <%= "java".equals(lang) ? "active" : "" %>"
               role="tab"
               aria-selected="<%= "java".equals(lang) ? "true" : "false" %>">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="margin-right:6px;vertical-align:middle;"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg>
                Java
            </a>
            <a href="difficulty.jsp?lang=python"
               class="lang-pill <%= "python".equals(lang) ? "active" : "" %>"
               role="tab"
               aria-selected="<%= "python".equals(lang) ? "true" : "false" %>">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="margin-right:6px;vertical-align:middle;"><path d="M13 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V9z"/><polyline points="13 2 13 9 20 9"/></svg>
                Python
            </a>
            <a href="difficulty.jsp?lang=c"
               class="lang-pill <%= "c".equals(lang) ? "active" : "" %>"
               role="tab"
               aria-selected="<%= "c".equals(lang) ? "true" : "false" %>">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="margin-right:6px;vertical-align:middle;"><polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/></svg>
                C
            </a>
        </div>

        <!-- Difficulty Selection Grid -->
        <div class="feature-grid" style="max-width:900px;margin:0 auto;">

            <!-- Easy -->
            <div class="feature-card fade-up delay-2">
                <div style="width:52px;height:52px;border-radius:14px;background:rgba(34,197,94,0.10);border:1px solid rgba(34,197,94,0.20);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#4ade80" stroke-width="1.5"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                </div>
                <span class="badge badge-easy" style="margin-bottom:14px;">Easy</span>
                <h3 style="font-size:1.375rem;margin-bottom:10px;">Fundamentals</h3>
                <p style="margin-bottom:28px;">Variables, loops and simple syntax. Perfect for warming up your fingers before harder challenges.</p>
                <a href="practice.jsp?language=<%= lang %>&difficulty=easy" class="btn btn-primary btn-block">
                    Start Easy
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </a>
            </div>

            <!-- Medium -->
            <div class="feature-card fade-up delay-3">
                <div style="width:52px;height:52px;border-radius:14px;background:rgba(245,158,11,0.10);border:1px solid rgba(245,158,11,0.20);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#fbbf24" stroke-width="1.5"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
                </div>
                <span class="badge badge-medium" style="margin-bottom:14px;">Medium</span>
                <h3 style="font-size:1.375rem;margin-bottom:10px;">Intermediate</h3>
                <p style="margin-bottom:28px;">Functions, conditionals and loops with real logic. You'll need to focus to keep accuracy high.</p>
                <a href="practice.jsp?language=<%= lang %>&difficulty=medium" class="btn btn-primary btn-block">
                    Start Medium
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </a>
            </div>

            <!-- Hard -->
            <div class="feature-card fade-up delay-4">
                <div style="width:52px;height:52px;border-radius:14px;background:rgba(239,68,68,0.10);border:1px solid rgba(239,68,68,0.20);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#f87171" stroke-width="1.5"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>
                </div>
                <span class="badge badge-hard" style="margin-bottom:14px;">Hard</span>
                <h3 style="font-size:1.375rem;margin-bottom:10px;">Advanced</h3>
                <p style="margin-bottom:28px;">Complex algorithms, classes and data structures. Only for those who mean business.</p>
                <a href="practice.jsp?language=<%= lang %>&difficulty=hard" class="btn btn-primary btn-block">
                    Start Hard
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </a>
            </div>

        </div>

        <!-- Tip -->
        <p style="text-align:center;margin-top:40px;font-size:0.8125rem;color:var(--fg-muted);" class="fade-up delay-5">
            <span style="font-family:var(--font-mono);color:var(--accent);">Tab</span> or
            <span style="font-family:var(--font-mono);color:var(--accent);">Esc</span>
            to restart a session at any time
        </p>
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

    // Spotlight on cards
    document.querySelectorAll('.feature-card').forEach(card => {
        card.addEventListener('mousemove', (e) => {
            const rect = card.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            let s = card.querySelector('.spotlight');
            if (!s) { s = document.createElement('div'); s.className = 'spotlight'; card.appendChild(s); }
            s.style.background = `radial-gradient(280px circle at ${x}px ${y}px, rgba(94,106,210,0.10), transparent)`;
        });
    });
</script>
</body>
</html>
