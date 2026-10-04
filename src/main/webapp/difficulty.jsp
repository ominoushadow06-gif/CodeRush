<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String lang = request.getParameter("lang");
    if (lang == null || lang.trim().isEmpty()) {
        lang = "java";
    }
    lang = lang.toLowerCase().trim();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Mode - CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard" class="brand-logo">
            <span>⌨️</span> Code<span class="brand-badge">Rush</span>
        </a>
        <div class="nav-links">
            <a href="dashboard" class="nav-link">Dashboard</a>
            <a href="history" class="nav-link">History</a>
            <span class="nav-user"><%= user.getUsername() %></span>
            <a href="logout" class="btn btn-outline" style="padding: 0.35rem 0.85rem; font-size: 0.85rem;">Logout</a>
        </div>
    </nav>

    <main class="container" style="max-width: 960px;">
        <div style="text-align: center; margin-bottom: 2rem;">
            <h1 style="font-size: 2.25rem; font-weight: 800; letter-spacing: -0.5px;">Choose Your Arena</h1>
            <p style="color: var(--text-secondary); margin-top: 0.5rem;">Select your target programming language and difficulty level.</p>
        </div>

        <!-- Language Selector Tabs -->
        <div class="lang-tabs">
            <a href="difficulty.jsp?lang=java" class="lang-tab <%= "java".equals(lang) ? "active" : "" %>">
                ☕ Java
            </a>
            <a href="difficulty.jsp?lang=python" class="lang-tab <%= "python".equals(lang) ? "active" : "" %>">
                🐍 Python
            </a>
            <a href="difficulty.jsp?lang=c" class="lang-tab <%= "c".equals(lang) ? "active" : "" %>">
                ⚙️ C Language
            </a>
        </div>

        <!-- Difficulty Cards Matrix -->
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem;">
            <!-- Easy Card -->
            <div class="card card-interactive" style="display: flex; flex-direction: column; justify-content: space-between; border-top: 4px solid var(--success);">
                <div>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                        <span class="badge badge-easy">Easy</span>
                        <span style="font-size: 0.85rem; color: var(--text-muted);">~3-5 Lines</span>
                    </div>
                    <h2 class="card-title" style="font-size: 1.4rem;">Fundamentals</h2>
                    <p class="card-subtitle" style="margin-bottom: 1.25rem;">
                        Variables, print statements, simple loops, and basic built-in methods.
                    </p>
                    <ul style="list-style: none; color: var(--text-secondary); font-size: 0.88rem; line-height: 2; margin-bottom: 1.5rem;">
                        <li>✓ Target: <strong>30+ WPM</strong></li>
                        <li>✓ Error tolerance: High</li>
                        <li>✓ Ideal for warmup</li>
                    </ul>
                </div>
                <a href="practice.jsp?language=<%= lang %>&difficulty=easy" class="btn btn-primary btn-block">Start Easy Test 🚀</a>
            </div>

            <!-- Medium Card -->
            <div class="card card-interactive" style="display: flex; flex-direction: column; justify-content: space-between; border-top: 4px solid var(--warning);">
                <div>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                        <span class="badge badge-medium">Medium</span>
                        <span style="font-size: 0.85rem; color: var(--text-muted);">~5-10 Lines</span>
                    </div>
                    <h2 class="card-title" style="font-size: 1.4rem;">Intermediate</h2>
                    <p class="card-subtitle" style="margin-bottom: 1.25rem;">
                        Methods, recursion, conditionals, arrays, maps, and standard libraries.
                    </p>
                    <ul style="list-style: none; color: var(--text-secondary); font-size: 0.88rem; line-height: 2; margin-bottom: 1.5rem;">
                        <li>✓ Target: <strong>45+ WPM</strong></li>
                        <li>✓ Mixed symbols & indentation</li>
                        <li>✓ Algorithmic logic</li>
                    </ul>
                </div>
                <a href="practice.jsp?language=<%= lang %>&difficulty=medium" class="btn btn-primary btn-block">Start Medium Test 🚀</a>
            </div>

            <!-- Hard Card -->
            <div class="card card-interactive" style="display: flex; flex-direction: column; justify-content: space-between; border-top: 4px solid var(--danger);">
                <div>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                        <span class="badge badge-hard">Hard</span>
                        <span style="font-size: 0.85rem; color: var(--text-muted);">~10-20 Lines</span>
                    </div>
                    <h2 class="card-title" style="font-size: 1.4rem;">Advanced</h2>
                    <p class="card-subtitle" style="margin-bottom: 1.25rem;">
                        Classes, nested loops, binary search, linked lists, stacks, and complex matrix math.
                    </p>
                    <ul style="list-style: none; color: var(--text-secondary); font-size: 0.88rem; line-height: 2; margin-bottom: 1.5rem;">
                        <li>✓ Target: <strong>60+ WPM</strong></li>
                        <li>✓ Strict syntax & indentation</li>
                        <li>✓ Real-world problem sets</li>
                    </ul>
                </div>
                <a href="practice.jsp?language=<%= lang %>&difficulty=hard" class="btn btn-primary btn-block">Start Hard Test 🚀</a>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2026 CodeRush - Practice Speed, Accuracy & Syntax Precision.</p>
    </footer>
</body>
</html>
