<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User, com.coderush.model.Result, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Result> historyList = (List<Result>) request.getAttribute("historyList");
    String selectedLanguage = (String) request.getAttribute("selectedLanguage");
    String selectedDifficulty = (String) request.getAttribute("selectedDifficulty");
    if (selectedLanguage == null) selectedLanguage = "all";
    if (selectedDifficulty == null) selectedDifficulty = "all";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Performance History - CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <nav class="navbar">
        <a href="dashboard" class="brand-logo">
            <span>⌨️</span> Code<span class="brand-badge">Rush</span>
        </a>
        <div class="nav-links">
            <a href="difficulty.jsp" class="btn btn-primary" style="padding: 0.45rem 1rem; font-size: 0.88rem;">⚡ Practice</a>
            <a href="dashboard" class="nav-link">Dashboard</a>
            <span class="nav-user"><%= user.getUsername() %></span>
            <a href="logout" class="btn btn-outline" style="padding: 0.35rem 0.85rem; font-size: 0.85rem;">Logout</a>
        </div>
    </nav>

    <main class="container">
        <!-- Page Header -->
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; flex-wrap: wrap; gap: 1rem;">
            <div>
                <h1 style="font-size: 2rem; font-weight: 800; letter-spacing: -0.5px;">Performance History & Analytics</h1>
                <p style="color: var(--text-secondary); margin-top: 0.25rem;">Track your typing speed trajectories and consistency across programming languages.</p>
            </div>
            <a href="difficulty.jsp" class="btn btn-primary">Start New Test 🚀</a>
        </div>

        <!-- Filter Controls -->
        <div class="card" style="padding: 1.25rem; margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
            <!-- Language Filters -->
            <div style="display: flex; align-items: center; gap: 0.5rem; flex-wrap: wrap;">
                <span style="font-size: 0.85rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase;">Language:</span>
                <a href="history?language=all&difficulty=<%= selectedDifficulty %>" class="btn btn-outline" style="padding: 0.35rem 0.75rem; font-size: 0.8rem; <%= "all".equalsIgnoreCase(selectedLanguage) ? "border-color: var(--accent-cyan); color: var(--accent-cyan);" : "" %>">All</a>
                <a href="history?language=java&difficulty=<%= selectedDifficulty %>" class="btn btn-outline" style="padding: 0.35rem 0.75rem; font-size: 0.8rem; <%= "java".equalsIgnoreCase(selectedLanguage) ? "border-color: var(--accent-cyan); color: var(--accent-cyan);" : "" %>">Java</a>
                <a href="history?language=python&difficulty=<%= selectedDifficulty %>" class="btn btn-outline" style="padding: 0.35rem 0.75rem; font-size: 0.8rem; <%= "python".equalsIgnoreCase(selectedLanguage) ? "border-color: var(--accent-cyan); color: var(--accent-cyan);" : "" %>">Python</a>
                <a href="history?language=c&difficulty=<%= selectedDifficulty %>" class="btn btn-outline" style="padding: 0.35rem 0.75rem; font-size: 0.8rem; <%= "c".equalsIgnoreCase(selectedLanguage) ? "border-color: var(--accent-cyan); color: var(--accent-cyan);" : "" %>">C</a>
            </div>

            <!-- Difficulty Filters -->
            <div style="display: flex; align-items: center; gap: 0.5rem; flex-wrap: wrap;">
                <span style="font-size: 0.85rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase;">Difficulty:</span>
                <a href="history?language=<%= selectedLanguage %>&difficulty=all" class="btn btn-outline" style="padding: 0.35rem 0.75rem; font-size: 0.8rem; <%= "all".equalsIgnoreCase(selectedDifficulty) ? "border-color: var(--accent-cyan); color: var(--accent-cyan);" : "" %>">All</a>
                <a href="history?language=<%= selectedLanguage %>&difficulty=easy" class="btn btn-outline" style="padding: 0.35rem 0.75rem; font-size: 0.8rem; <%= "easy".equalsIgnoreCase(selectedDifficulty) ? "border-color: var(--success); color: var(--success);" : "" %>">Easy</a>
                <a href="history?language=<%= selectedLanguage %>&difficulty=medium" class="btn btn-outline" style="padding: 0.35rem 0.75rem; font-size: 0.8rem; <%= "medium".equalsIgnoreCase(selectedDifficulty) ? "border-color: var(--warning); color: var(--warning);" : "" %>">Medium</a>
                <a href="history?language=<%= selectedLanguage %>&difficulty=hard" class="btn btn-outline" style="padding: 0.35rem 0.75rem; font-size: 0.8rem; <%= "hard".equalsIgnoreCase(selectedDifficulty) ? "border-color: var(--danger); color: var(--danger);" : "" %>">Hard</a>
            </div>
        </div>

        <!-- Chart.js Trend Visualizer Card -->
        <% if (historyList != null && !historyList.isEmpty()) { %>
            <div class="card" style="margin-bottom: 2rem;">
                <h2 class="card-title" style="font-size: 1.25rem; margin-bottom: 1.25rem;">📈 Speed & Accuracy Trendline</h2>
                <div style="position: relative; height: 300px; width: 100%;">
                    <canvas id="historyTrendChart"></canvas>
                </div>
            </div>
        <% } %>

        <!-- Historical Attempts Table -->
        <div class="card">
            <h2 class="card-title" style="font-size: 1.25rem; margin-bottom: 1.25rem;">Recorded Sessions</h2>

            <% if (historyList == null || historyList.isEmpty()) { %>
                <div style="text-align: center; padding: 3rem 1rem; color: var(--text-muted);">
                    <p style="font-size: 1.1rem; margin-bottom: 1rem;">No practice records match the selected filters.</p>
                    <a href="difficulty.jsp" class="btn btn-primary">Start a Session 🚀</a>
                </div>
            <% } else { %>
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Language</th>
                                <th>Difficulty</th>
                                <th>Speed (WPM)</th>
                                <th>Accuracy</th>
                                <th>Mistakes</th>
                                <th>Time Taken</th>
                            </tr>
                        </thead>
                        <tbody id="history-table-body">
                            <% for (Result r : historyList) { %>
                                <tr>
                                    <td class="col-date" style="color: var(--text-secondary);"><%= r.getAttemptedAt() != null ? r.getAttemptedAt().toString().substring(0, 16) : "Recent" %></td>
                                    <td><span class="badge badge-lang"><%= r.getLanguage() != null ? r.getLanguage() : "java" %></span></td>
                                    <td><span class="badge badge-<%= r.getDifficulty().toLowerCase() %>"><%= r.getDifficulty() %></span></td>
                                    <td class="col-wpm" style="color: var(--accent-cyan); font-weight: 700; font-family: var(--font-code);"><%= r.getWpm() %></td>
                                    <td class="col-acc" style="color: var(--success); font-weight: 700; font-family: var(--font-code);"><%= r.getAccuracy() %>%</td>
                                    <td style="color: var(--danger); font-family: var(--font-code);"><%= r.getMistakes() %></td>
                                    <td style="color: var(--text-secondary); font-family: var(--font-code);"><%= r.getTimeTaken() %>s</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
    </main>

    <script src="js/charts.js"></script>
</body>
</html>
