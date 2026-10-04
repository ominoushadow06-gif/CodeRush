<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User, com.coderush.model.Result" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    Result result = (Result) request.getAttribute("latestResult");

    String tier = "Novice";
    String tierClass = "tier-novice";
    String tierQuote = "Keep practicing regularly to build muscle memory!";

    if (result != null) {
        double wpm = result.getWpm();
        double acc = result.getAccuracy();

        if (wpm >= 75 && acc >= 95) {
            tier = "Grandmaster";
            tierClass = "tier-grandmaster";
            tierQuote = "⚡ Blazing speed and pinpoint accuracy. Godlike developer reflexes!";
        } else if (wpm >= 55 && acc >= 90) {
            tier = "Master";
            tierClass = "tier-master";
            tierQuote = "🚀 Fantastic performance! Clean syntax and high typing efficiency.";
        } else if (wpm >= 35 && acc >= 85) {
            tier = "Coder";
            tierClass = "tier-coder";
            tierQuote = "👍 Solid pace! Work on reducing mistakes on special characters.";
        } else {
            tier = "Novice";
            tierClass = "tier-novice";
            tierQuote = "🌱 Good start! Practice daily to improve syntax accuracy and rhythm.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Practice Results - CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard" class="brand-logo">
            <span>⌨️</span> Code<span class="brand-badge">Rush</span>
        </a>
        <div class="nav-links">
            <a href="difficulty.jsp" class="btn btn-primary" style="padding: 0.45rem 1rem; font-size: 0.88rem;">Practice Again</a>
            <a href="history" class="nav-link">History</a>
            <a href="dashboard" class="nav-link">Dashboard</a>
            <a href="logout" class="btn btn-outline" style="padding: 0.35rem 0.85rem; font-size: 0.85rem;">Logout</a>
        </div>
    </nav>

    <main class="container" style="max-width: 720px;">
        <div class="card" style="text-align: center; margin-top: 1rem;">
            <div style="font-size: 2.75rem; margin-bottom: 0.5rem;">🎉</div>
            <h1 class="card-title" style="font-size: 2rem;">Session Completed!</h1>

            <!-- Tier Rating Banner -->
            <div>
                <span class="tier-banner <%= tierClass %>"><%= tier %> Tier</span>
            </div>
            <p style="color: var(--text-secondary); margin-bottom: 2rem; font-size: 0.95rem;"><%= tierQuote %></p>

            <% if (result != null) { %>
                <div style="display: flex; justify-content: center; gap: 0.75rem; margin-bottom: 1.75rem;">
                    <span class="badge badge-lang"><%= result.getLanguage() != null ? result.getLanguage().toUpperCase() : "JAVA" %></span>
                    <span class="badge badge-<%= result.getDifficulty().toLowerCase() %>"><%= result.getDifficulty().toUpperCase() %></span>
                </div>

                <div class="metric-grid" style="grid-template-columns: repeat(2, 1fr); margin-bottom: 2.25rem;">
                    <div class="metric-card" style="background: var(--bg-surface);">
                        <span class="metric-label">Typing Speed</span>
                        <div class="metric-number" style="color: var(--accent-cyan);"><%= result.getWpm() %> <span style="font-size: 1rem; font-weight: 500; color: var(--text-muted);">WPM</span></div>
                    </div>
                    <div class="metric-card" style="background: var(--bg-surface);">
                        <span class="metric-label">Accuracy Rate</span>
                        <div class="metric-number" style="color: var(--success);"><%= result.getAccuracy() %><span style="font-size: 1rem; font-weight: 500; color: var(--text-muted);">%</span></div>
                    </div>
                    <div class="metric-card" style="background: var(--bg-surface);">
                        <span class="metric-label">Mistakes Recorded</span>
                        <div class="metric-number" style="color: var(--danger);"><%= result.getMistakes() %></div>
                    </div>
                    <div class="metric-card" style="background: var(--bg-surface);">
                        <span class="metric-label">Time Elapsed</span>
                        <div class="metric-number" style="color: var(--warning);"><%= result.getTimeTaken() %><span style="font-size: 1rem; font-weight: 500; color: var(--text-muted);">s</span></div>
                    </div>
                </div>
            <% } else { %>
                <p style="color: var(--text-muted); margin: 2rem 0;">No result metrics found for this session.</p>
            <% } %>

            <!-- Action Buttons -->
            <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                <% if (result != null) { %>
                    <a href="practice.jsp?language=<%= result.getLanguage() %>&difficulty=<%= result.getDifficulty() %>" class="btn btn-primary btn-lg">Practice Same Mode 🔄</a>
                <% } %>
                <a href="difficulty.jsp" class="btn btn-secondary btn-lg">Change Language / Level 🎯</a>
                <a href="history" class="btn btn-outline btn-lg">View All Attempts 📊</a>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2026 CodeRush. Benchmark and elevate your coding velocity.</p>
    </footer>
</body>
</html>
