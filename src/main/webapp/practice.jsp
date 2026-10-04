<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Typing Arena - CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard" class="brand-logo">
            <span>⌨️</span> Code<span class="brand-badge">Rush</span>
        </a>
        <div class="nav-links">
            <a href="difficulty.jsp" class="btn btn-outline" style="padding: 0.35rem 0.85rem; font-size: 0.85rem;">🔄 Change Mode</a>
            <a href="dashboard" class="nav-link">Dashboard</a>
            <span class="nav-user"><%= user.getUsername() %></span>
            <a href="logout" class="btn btn-outline" style="padding: 0.35rem 0.85rem; font-size: 0.85rem;">Logout</a>
        </div>
    </nav>

    <main class="container">
        <!-- Snippet Metadata & Context Banner -->
        <div class="snippet-meta-banner">
            <div style="display: flex; align-items: center; gap: 0.75rem;">
                <span id="ui-badge-lang" class="badge badge-lang">JAVA</span>
                <span id="ui-badge-diff" class="badge badge-easy">EASY</span>
                <span id="snippet-desc" style="font-weight: 500;">Loading snippet details...</span>
            </div>
            <div style="font-size: 0.8rem; color: var(--text-muted);">
                Press <kbd style="background: var(--bg-surface); padding: 2px 6px; border-radius: 4px; border: 1px solid var(--border);">Tab</kbd> or <kbd style="background: var(--bg-surface); padding: 2px 6px; border-radius: 4px; border: 1px solid var(--border);">Esc</kbd> to restart
            </div>
        </div>

        <!-- Live Performance HUD Header -->
        <div class="typing-header">
            <div class="stat-pill">
                <span class="stat-pill-label">⏱️ Time</span>
                <span id="timer" class="stat-pill-value" style="color: var(--accent-cyan);">00:00</span>
            </div>
            <div class="stat-pill">
                <span class="stat-pill-label">⚡ Live WPM</span>
                <span id="live-wpm" class="stat-pill-value" style="color: #38bdf8;">0</span>
            </div>
            <div class="stat-pill">
                <span class="stat-pill-label">🎯 Accuracy</span>
                <span id="live-accuracy" class="stat-pill-value" style="color: var(--success);">100%</span>
            </div>
            <div class="stat-pill">
                <span class="stat-pill-label">❌ Mistakes</span>
                <span id="mistakes-count" class="stat-pill-value" style="color: var(--danger);">0</span>
            </div>
            <button id="restart-btn" class="btn btn-outline" style="padding: 0.35rem 0.75rem; font-size: 0.85rem;">Restart 🔄</button>
        </div>

        <!-- Code Arena Display Window -->
        <div id="code-window" class="code-window" style="cursor: text;">
            <div id="code-display">Loading snippet from server...</div>
        </div>

        <!-- Invisible Typing Area -->
        <textarea id="typing-input" class="hidden-typing-input" rows="1" spellcheck="false" autocomplete="off" autocapitalize="off" disabled></textarea>

        <!-- Hidden POST Form to submit results -->
        <form id="result-form" action="result" method="POST" style="display: none;">
            <input type="hidden" id="res-snippetId" name="snippetId">
            <input type="hidden" id="res-language" name="language">
            <input type="hidden" id="res-difficulty" name="difficulty">
            <input type="hidden" id="res-wpm" name="wpm">
            <input type="hidden" id="res-accuracy" name="accuracy">
            <input type="hidden" id="res-mistakes" name="mistakes">
            <input type="hidden" id="res-timeTaken" name="timeTaken">
        </form>
    </main>

    <script src="js/typing.js"></script>
</body>
</html>
