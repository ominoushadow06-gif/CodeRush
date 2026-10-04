<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeRush - Master Your Code Typing Speed</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <a href="index.jsp" class="brand-logo">
            <span>⌨️</span> Code<span class="brand-badge">Rush</span>
        </a>
        <div class="nav-links">
            <% if (currentUser != null) { %>
                <a href="dashboard" class="nav-link">Dashboard</a>
                <a href="difficulty.jsp" class="nav-link">Practice</a>
                <a href="history" class="nav-link">History</a>
                <span class="nav-user"><%= currentUser.getUsername() %></span>
                <a href="logout" class="btn btn-outline" style="padding: 0.35rem 0.85rem; font-size: 0.85rem;">Logout</a>
            <% } else { %>
                <a href="login.jsp" class="nav-link">Log In</a>
                <a href="signup.jsp" class="btn btn-primary" style="padding: 0.45rem 1.1rem; font-size: 0.88rem;">Get Started</a>
            <% } %>
        </div>
    </nav>

    <main class="container">
        <!-- Hero Section -->
        <section style="text-align: center; padding: 3.5rem 1rem 2.5rem;">
            <div class="badge badge-lang" style="margin-bottom: 1.25rem;">⚡ Real-Time Developer Typing Benchmark</div>
            <h1 style="font-size: 3.25rem; font-weight: 800; letter-spacing: -1.5px; line-height: 1.15; max-width: 850px; margin: 0 auto 1.25rem;">
                Build muscle memory for <span class="brand-badge">real programming syntax</span>.
            </h1>
            <p style="font-size: 1.15rem; color: var(--text-secondary); max-width: 620px; margin: 0 auto 2.25rem;">
                Stop typing random novels. Practice real Java, Python, and C snippets against a live stopwatch, track your accuracy, and level up your coding speed.
            </p>
            <div style="display: flex; gap: 1rem; justify-content: center; align-items: center;">
                <% if (currentUser != null) { %>
                    <a href="difficulty.jsp" class="btn btn-primary btn-lg">Start Typing Now 🚀</a>
                    <a href="dashboard" class="btn btn-secondary btn-lg">View Dashboard</a>
                <% } else { %>
                    <a href="signup.jsp" class="btn btn-primary btn-lg">Start Practice Free 🚀</a>
                    <a href="login.jsp" class="btn btn-secondary btn-lg">Login to Account</a>
                <% } %>
            </div>
        </section>

        <!-- Interactive Code Mockup -->
        <section class="card" style="max-width: 800px; margin: 0 auto 3.5rem; background: var(--bg-surface); border-color: rgba(56, 189, 248, 0.25);">
            <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border); padding-bottom: 0.75rem; margin-bottom: 1rem;">
                <div style="display: flex; gap: 0.4rem;">
                    <span style="width: 12px; height: 12px; border-radius: 50%; background: #ef4444;"></span>
                    <span style="width: 12px; height: 12px; border-radius: 50%; background: #f59e0b;"></span>
                    <span style="width: 12px; height: 12px; border-radius: 50%; background: #22c55e;"></span>
                </div>
                <span style="font-size: 0.8rem; font-family: var(--font-code); color: var(--text-muted);">BinarySearch.java (Hard)</span>
                <span class="badge badge-easy">98.4% Acc</span>
            </div>
            <div class="code-window" style="border: none; padding: 1rem 0; min-height: auto;">
                <span class="char-correct">public</span> <span class="char-correct">static</span> <span class="char-correct">int</span> <span class="char-correct">search</span>(<span class="char-correct">int</span>[] <span class="char-correct">arr</span>, <span class="char-correct">int</span> <span class="char-correct">target</span>) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="char-correct">int</span> <span class="char-correct">left</span> = <span class="char-correct">0</span>, <span class="char-correct">right</span> = <span class="char-correct">arr.length</span> - <span class="char-correct">1</span>;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="char-current">w</span>hile (left &lt;= right) { ... }
            </div>
        </section>

        <!-- Features Matrix -->
        <section style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem; margin-bottom: 3.5rem;">
            <div class="card card-interactive">
                <div style="font-size: 2rem; margin-bottom: 0.75rem;">⚡</div>
                <h3 class="card-title" style="font-size: 1.2rem;">Live WPM & Accuracy</h3>
                <p class="card-subtitle">Real-time keystroke evaluation with mistake detection and dynamic speed calculation.</p>
            </div>
            <div class="card card-interactive">
                <div style="font-size: 2rem; margin-bottom: 0.75rem;">🌐</div>
                <h3 class="card-title" style="font-size: 1.2rem;">Multi-Language Engine</h3>
                <p class="card-subtitle">Practice syntactically curated snippets in Java, Python, and C across 3 difficulty tiers.</p>
            </div>
            <div class="card card-interactive">
                <div style="font-size: 2rem; margin-bottom: 0.75rem;">📈</div>
                <h3 class="card-title" style="font-size: 1.2rem;">Performance Analytics</h3>
                <p class="card-subtitle">Visualize your speed trajectories and accuracy curves over time with interactive charts.</p>
            </div>
        </section>
    </main>

    <footer class="footer">
        <p>Built with ☕ Java Servlets, 🐬 MySQL, and 🐱 Apache Tomcat. &copy; 2026 CodeRush Team.</p>
    </footer>
</body>
</html>
