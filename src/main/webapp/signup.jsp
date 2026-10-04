<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <a href="index.jsp" class="brand-logo">
            <span>⌨️</span> Code<span class="brand-badge">Rush</span>
        </a>
        <div class="nav-links">
            <a href="login.jsp" class="nav-link">Already registered? Log In</a>
        </div>
    </nav>

    <main class="container container-narrow">
        <div class="card" style="margin-top: 2rem;">
            <div class="card-header" style="text-align: center;">
                <h1 class="card-title">Create an Account</h1>
                <p class="card-subtitle">Join CodeRush to benchmark your coding speed</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <span>⚠️</span> <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form id="signup-form" action="signup" method="POST">
                <div class="form-group">
                    <label class="form-label" for="username">Username</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="e.g. dev_aryan" required autofocus>
                </div>

                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="name@example.com" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>

                    <!-- Password Strength Meter -->
                    <div style="margin-top: 0.5rem; display: flex; align-items: center; gap: 0.75rem;">
                        <div style="flex: 1; height: 4px; background: var(--border); border-radius: 2px; overflow: hidden;">
                            <div id="password-strength-meter" style="width: 0%; height: 100%; transition: width 0.3s, background-color 0.3s;"></div>
                        </div>
                        <span id="password-strength-text" style="font-size: 0.75rem; color: var(--text-muted); min-width: 60px;">Weak</span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="••••••••" required>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top: 1.5rem;">Create Free Account</button>
            </form>

            <div style="text-align: center; margin-top: 1.5rem; font-size: 0.9rem; color: var(--text-muted);">
                By registering, you agree to track practice metrics.
            </div>
        </div>
    </main>

    <script src="js/auth.js"></script>
</body>
</html>
