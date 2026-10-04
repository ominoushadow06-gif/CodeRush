<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User, com.coderush.model.Result, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Result> recentResults = (List<Result>) request.getAttribute("recentResults");
    String avgWpm = (String) request.getAttribute("avgWpm");
    String avgAccuracy = (String) request.getAttribute("avgAccuracy");
    Integer totalSessions = (Integer) request.getAttribute("totalSessions");
    String topLanguage = (String) request.getAttribute("topLanguage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard" class="brand-logo">
            <span>⌨️</span> Code<span class="brand-badge">Rush</span>
        </a>
        <div class="nav-links">
            <a href="difficulty.jsp" class="btn btn-primary" style="padding: 0.45rem 1rem; font-size: 0.88rem;">⚡ Quick Practice</a>
            <a href="history" class="nav-link">History</a>
            <span class="nav-user"><%= user.getUsername() %></span>
            <a href="logout" class="btn btn-outline" style="padding: 0.35rem 0.85rem; font-size: 0.85rem;">Logout</a>
        </div>
    </nav>

    <main class="container">
        <!-- Welcome Banner -->
        <div class="card" style="display: flex; justify-content: space-between; align-items: center; background: linear-gradient(135deg, #131b2e, #1a2744); border-color: rgba(56, 189, 248, 0.3); margin-bottom: 2rem;">
            <div>
                <h1 style="font-size: 1.85rem; font-weight: 800; letter-spacing: -0.5px;">Welcome back, <%= user.getUsername() %>! 👋</h1>
                <p style="color: var(--text-secondary); margin-top: 0.35rem;">Track your progress, beat your high scores, and master programming keystrokes.</p>
            </div>
            <a href="difficulty.jsp" class="btn btn-primary btn-lg">Launch Arena 🚀</a>
        </div>

        <!-- Metrics Grid -->
        <div class="metric-grid">
            <div class="metric-card">
                <span class="metric-label">Average Speed</span>
                <div class="metric-number" style="color: var(--accent-cyan);"><%= avgWpm != null ? avgWpm : "0.0" %> <span style="font-size: 1rem; font-weight: 500; color: var(--text-muted);">WPM</span></div>
            </div>
            <div class="metric-card">
                <span class="metric-label">Average Accuracy</span>
                <div class="metric-number" style="color: var(--success);"><%= avgAccuracy != null ? avgAccuracy : "0.0" %><span style="font-size: 1rem; font-weight: 500; color: var(--text-muted);">%</span></div>
            </div>
            <div class="metric-card">
                <span class="metric-label">Total Sessions</span>
                <div class="metric-number" style="color: var(--warning);"><%= totalSessions != null ? totalSessions : 0 %></div>
            </div>
            <div class="metric-card">
                <span class="metric-label">Top Language</span>
                <div class="metric-number" style="color: #a855f7; font-size: 1.75rem;"><%= topLanguage != null ? topLanguage : "JAVA" %></div>
            </div>
        </div>

        <!-- Recent Attempts Widget -->
        <div class="card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                <h2 class="card-title" style="font-size: 1.25rem;">Recent Typing Sessions</h2>
                <a href="history" class="btn btn-outline" style="padding: 0.4rem 0.85rem; font-size: 0.85rem;">View Full History &rarr;</a>
            </div>

            <% if (recentResults == null || recentResults.isEmpty()) { %>
                <div style="text-align: center; padding: 2.5rem 1rem; color: var(--text-muted);">
                    <p style="font-size: 1.1rem; margin-bottom: 1rem;">No typing sessions logged yet.</p>
                    <a href="difficulty.jsp" class="btn btn-primary">Take Your First Test 🚀</a>
                </div>
            <% } else { %>
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Language</th>
                                <th>Difficulty</th>
                                <th>WPM</th>
                                <th>Accuracy</th>
                                <th>Mistakes</th>
                                <th>Duration</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                               int count = 0;
                               for (Result r : recentResults) {
                                   if (count++ >= 5) break;
                            %>
                                <tr>
                                    <td style="color: var(--text-secondary);"><%= r.getAttemptedAt() != null ? r.getAttemptedAt().toString().substring(0, 16) : "Recent" %></td>
                                    <td><span class="badge badge-lang"><%= r.getLanguage() != null ? r.getLanguage() : "java" %></span></td>
                                    <td><span class="badge badge-<%= r.getDifficulty().toLowerCase() %>"><%= r.getDifficulty() %></span></td>
                                    <td style="color: var(--accent-cyan); font-weight: 700; font-family: var(--font-code);"><%= r.getWpm() %></td>
                                    <td style="color: var(--success); font-weight: 700; font-family: var(--font-code);"><%= r.getAccuracy() %>%</td>
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

    <footer class="footer">
        <p>&copy; 2026 CodeRush. Developed with Java Servlets, MySQL & Tomcat.</p>
    </footer>
</body>
</html>
