<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account — CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="brand-logo">Code<span>Rush</span><span class="brand-badge">Trainer</span></a>
        <div></div>
        <div class="nav-actions">
            <span class="text-muted" style="font-size:0.875rem;">Already have an account?</span>
            <a href="login.jsp" class="btn btn-secondary btn-sm">Log In</a>
        </div>
    </div>
</nav>

<!-- Auth Container (Intentionally Compact & Centered) -->
<div class="auth-container">
    <div class="auth-card fade-up">

        <!-- Header -->
        <div class="auth-header">
            <span class="label-tag">Free Account</span>
            <h1>Get Started with CodeRush</h1>
            <p>Improve your coding speed and accuracy.</p>
        </div>

        <!-- Server-side error -->
        <% String signupError = (String) request.getAttribute("error"); %>
        <% if (signupError != null) { %>
        <div class="alert alert-danger" role="alert">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="flex-shrink:0;"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <span><%= signupError %></span>
        </div>
        <% } %>

        <!-- Signup Form -->
        <form id="signup-form" action="signup" method="POST" novalidate>
            <div class="form-group">
                <label for="username" class="form-label">Username</label>
                <input
                    type="text"
                    id="username"
                    name="username"
                    class="form-input"
                    placeholder="Enter your username"
                    autocomplete="username"
                    minlength="3"
                    required
                >
            </div>

            <div class="form-group">
                <label for="email" class="form-label">Email</label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    class="form-input"
                    placeholder="name@example.com"
                    autocomplete="email"
                    required
                >
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    class="form-input"
                    placeholder="At least 6 characters"
                    autocomplete="new-password"
                    required
                >
                <!-- Strength meter track -->
                <div class="strength-meter-track" id="strength-track" style="display:none;">
                    <div class="strength-meter-fill" id="password-strength-meter"></div>
                </div>
                <p class="strength-text" id="password-strength-text" style="display:none;"></p>
            </div>

            <div class="form-group">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <input
                    type="password"
                    id="confirmPassword"
                    name="confirmPassword"
                    class="form-input"
                    placeholder="Re-enter your password"
                    autocomplete="new-password"
                    required
                >
            </div>

            <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top:12px;">
                <span>Create Account</span>
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
            </button>
        </form>

        <!-- Footer link -->
        <p style="text-align:center;font-size:0.875rem;color:var(--text-secondary);margin-top:24px;">
            Already registered?
            <a href="login.jsp" style="color:var(--royal-blue);text-decoration:none;font-weight:600;">Sign in here</a>
        </p>
    </div>
</div>

<script>
    // Show strength meter when password field gets focus
    const passwordInput = document.getElementById('password');
    const strengthTrack = document.getElementById('strength-track');
    const strengthText = document.getElementById('password-strength-text');
    const strengthMeter = document.getElementById('password-strength-meter');

    if (passwordInput && strengthTrack && strengthText && strengthMeter) {
        passwordInput.addEventListener('input', () => {
            const val = passwordInput.value;
            if (!val) { strengthTrack.style.display = 'none'; strengthText.style.display = 'none'; return; }

            strengthTrack.style.display = 'block';
            strengthText.style.display = 'block';

            let score = 0;
            if (val.length >= 6)  score++;
            if (val.length >= 10) score++;
            if (/[A-Z]/.test(val)) score++;
            if (/[0-9]/.test(val)) score++;
            if (/[^A-Za-z0-9]/.test(val)) score++;

            if (score <= 1) {
                strengthMeter.style.width = '20%';
                strengthMeter.style.background = 'var(--error)';
                strengthText.textContent = 'Too weak';
                strengthText.style.color = 'var(--error)';
            } else if (score <= 3) {
                strengthMeter.style.width = '60%';
                strengthMeter.style.background = 'var(--warning)';
                strengthText.textContent = 'Moderate';
                strengthText.style.color = 'var(--warning)';
            } else {
                strengthMeter.style.width = '100%';
                strengthMeter.style.background = 'var(--success)';
                strengthText.textContent = 'Strong';
                strengthText.style.color = 'var(--success)';
            }
        });
    }
</script>
<script src="js/auth.js"></script>
</body>
</html>
