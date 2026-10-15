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
    <title>CodeRush — Java Coding Speed & Accuracy Trainer</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="brand-logo">Code<span>Rush</span><span class="brand-badge">Trainer</span></a>

        <!-- Desktop nav links (centered) -->
        <div class="nav-links desktop-only">
            <a href="difficulty.jsp" class="nav-link">Practice</a>
            <a href="#features" class="nav-link">Features</a>
            <% if (currentUser != null) { %>
            <a href="history" class="nav-link">History</a>
            <% } %>
        </div>

        <!-- Desktop nav actions (right) -->
        <div class="nav-actions desktop-only">
            <% if (currentUser != null) { %>
            <div class="user-pill">
                <span class="user-avatar"><%= currentUser.getUsername().substring(0, 1) %></span>
                <span><%= currentUser.getUsername() %></span>
            </div>
            <a href="dashboard" class="btn btn-secondary btn-sm">Dashboard</a>
            <a href="logout" class="btn btn-ghost btn-sm">Log out</a>
            <% } else { %>
            <a href="login.jsp" class="btn btn-secondary btn-sm">Log In</a>
            <a href="signup.jsp" class="btn btn-primary btn-sm">Get Started</a>
            <% } %>
        </div>

        <!-- Mobile toggle -->
        <button class="nav-toggle" id="nav-toggle" aria-label="Toggle menu">
            <svg width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.75">
                <path d="M3 5h14M3 10h14M3 15h14"/>
            </svg>
        </button>
    </div>
</nav>

<!-- Mobile Menu -->
<div class="mobile-menu" id="mobile-menu">
    <% if (currentUser != null) { %>
    <div style="padding: 4px 14px 8px; font-weight: 600; color: var(--text-primary);">
        Signed in as <%= currentUser.getUsername() %>
    </div>
    <a href="difficulty.jsp" class="nav-link">Practice</a>
    <a href="#features" class="nav-link">Features</a>
    <a href="dashboard" class="nav-link">Dashboard</a>
    <a href="history" class="nav-link">History</a>
    <a href="logout" class="btn btn-secondary btn-sm" style="margin-top:8px;">Log out</a>
    <% } else { %>
    <a href="difficulty.jsp" class="nav-link">Practice</a>
    <a href="#features" class="nav-link">Features</a>
    <a href="login.jsp" class="btn btn-secondary btn-sm" style="margin-top:8px;">Log In</a>
    <a href="signup.jsp" class="btn btn-primary btn-sm">Get Started</a>
    <% } %>
</div>

<!-- Main Content -->
<main>
    <!-- Hero Section -->
    <section class="section" style="padding-top: 56px; padding-bottom: 64px;">
        <div class="container container-wide hero-grid">

            <!-- Left: Hero Headline & CTA (approx 55%) -->
            <div>
                <span class="label-tag mb-3 fade-up">Java Coding Speed & Accuracy Trainer</span>
                <h1 class="display-heading fade-up delay-1" style="margin-top: 12px; margin-bottom: 20px;">
                    Master coding syntax,<br>
                    <span class="text-accent-gradient">one keystroke</span><br>
                    at a time.
                </h1>
                <p class="body-large fade-up delay-2" style="margin-bottom: 32px; max-width: 580px;">
                    Practice real Java, Python, and C code snippets while tracking your typing speed, 
                    accuracy, and mistakes in real time. Designed for developers who value precision, 
                    muscle memory, and coding fluency.
                </p>
                <div style="display:flex; gap:12px; flex-wrap:wrap;" class="fade-up delay-3">
                    <a href="difficulty.jsp" class="btn btn-primary btn-lg">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                        <span>Start Practicing</span>
                    </a>
                    <a href="#features" class="btn btn-secondary btn-lg">See Features</a>
                </div>

                <!-- Technical Proof Note -->
                <div style="display:flex; align-items:center; gap:12px; margin-top:36px; padding-top:24px; border-top:1px solid var(--border);" class="fade-up delay-4">
                    <div style="display:flex;">
                        <div style="width:26px; height:26px; border-radius:50%; background:var(--royal-blue); color:#fff; display:flex; align-items:center; justify-content:center; font-size:0.6875rem; font-weight:700; border:2px solid var(--surface);">J</div>
                        <div style="width:26px; height:26px; border-radius:50%; background:var(--dark-charcoal); color:#fff; display:flex; align-items:center; justify-content:center; font-size:0.6875rem; font-weight:700; border:2px solid var(--surface); margin-left:-8px;">P</div>
                        <div style="width:26px; height:26px; border-radius:50%; background:var(--deep-navy); color:#fff; display:flex; align-items:center; justify-content:center; font-size:0.6875rem; font-weight:700; border:2px solid var(--surface); margin-left:-8px;">C</div>
                    </div>
                    <span style="font-size:0.8125rem; color:var(--text-secondary); font-family:var(--font-mono);">Real syntactical challenges across Java, Python & C</span>
                </div>
            </div>

            <!-- Right: Code Workspace Mockup (approx 45%) -->
            <div class="fade-up delay-2">
                <div class="code-window">
                    <div class="code-window-header">
                        <div class="code-window-dots">
                            <span></span><span></span><span></span>
                        </div>
                        <span style="color:#CBD5E1; font-weight:500;">BinarySearch.java</span>
                        <div style="display:flex; gap:6px;">
                            <span class="badge badge-lang">JAVA</span>
                            <span class="badge badge-hard">HARD</span>
                        </div>
                    </div>
                    <div class="code-window-body" style="font-size:0.9375rem; line-height:1.8; min-height:auto; padding:24px 28px;">
                        <div style="color:#93C5FD; margin-bottom:5px;"><span style="color:#60A5FA;">public int</span> <span style="color:#F3F4F6; font-weight:600;">binarySearch</span>(<span style="color:#60A5FA;">int</span>[] arr, <span style="color:#60A5FA;">int</span> target) {</div>
                        <div style="padding-left:20px; color:#E5E7EB; margin-bottom:5px;"><span style="color:#60A5FA;">int</span> left = 0, right = arr.length - 1;</div>
                        <div style="padding-left:20px; color:#4ADE80; margin-bottom:5px;"><span style="color:#60A5FA;">while</span> (left &lt;= right) {</div>
                        <div style="padding-left:40px; color:#9CA3AF; margin-bottom:5px;"><span style="color:#60A5FA;">int</span> mid = left + (right - left) / 2;</div>
                        <div style="padding-left:40px; color:#E5E7EB; margin-bottom:5px;"><span style="color:#60A5FA;">if</span> (arr[mid] == target) <span style="color:#60A5FA;">return</span> mid;</div>
                        <div style="padding-left:20px; color:#4ADE80; margin-bottom:5px;">}</div>
                        <div style="padding-left:20px; color:#60A5FA; margin-bottom:5px;">return -1;</div>
                        <div style="color:#93C5FD; margin-top:5px;">}</div>
                    </div>
                    <div style="display:flex; justify-content:space-around; padding:16px 24px; background:var(--code-header-bg); border-top:1px solid var(--code-border);">
                        <div style="text-align:center;">
                            <div style="font-family:var(--font-mono); font-size:1.375rem; font-weight:700; color:var(--royal-blue); text-shadow:0 0 12px rgba(10,33,192,0.4);">74</div>
                            <div style="font-size:0.6875rem; font-family:var(--font-mono); color:var(--muted-blue-gray); text-transform:uppercase; letter-spacing:0.05em;">WPM</div>
                        </div>
                        <div style="text-align:center;">
                            <div style="font-family:var(--font-mono); font-size:1.375rem; font-weight:700; color:#4ADE80;">98.4%</div>
                            <div style="font-size:0.6875rem; font-family:var(--font-mono); color:var(--muted-blue-gray); text-transform:uppercase; letter-spacing:0.05em;">Accuracy</div>
                        </div>
                        <div style="text-align:center;">
                            <div style="font-family:var(--font-mono); font-size:1.375rem; font-weight:700; color:#FFFFFF;">14s</div>
                            <div style="font-size:0.6875rem; font-family:var(--font-mono); color:var(--muted-blue-gray); text-transform:uppercase; letter-spacing:0.05em;">Time</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Subtle Divider -->
    <div class="container container-wide"><div class="section-divider"></div></div>

    <!-- Features Section -->
    <section class="section" id="features">
        <div class="container container-wide">
            <div class="text-center" style="margin-bottom: 40px;">
                <span class="label-tag mb-2 fade-up">Engineered For Performance</span>
                <h2 class="hero-heading fade-up delay-1" style="margin-top: 8px; margin-bottom: 8px;">
                    Built for engineers who care about craft
                </h2>
                <p class="body-large fade-up delay-2" style="max-width: 580px; margin: 0 auto;">
                    Every interface element is calibrated for deliberate practice and measurable typing growth.
                </p>
            </div>

            <div class="feature-grid">
                <div class="feature-card fade-up">
                    <div class="feature-card-icon" style="background:var(--royal-blue-subtle); border:1px solid var(--royal-blue-border);">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--royal-blue)" stroke-width="2"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>
                    </div>
                    <h3>Real-time WPM</h3>
                    <p>Live words-per-minute computation computed on every single keystroke so you can observe your pace in real time.</p>
                </div>

                <div class="feature-card fade-up delay-1">
                    <div class="feature-card-icon" style="background:var(--success-bg); border:1px solid var(--success-border);">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--success)" stroke-width="2"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                    </div>
                    <h3>Accuracy Tracking</h3>
                    <p>Character-level accuracy detection highlights every correct, mistyped, and pending character with zero ambiguity.</p>
                </div>

                <div class="feature-card fade-up delay-2">
                    <div class="feature-card-icon" style="background:var(--warning-bg); border:1px solid var(--warning-border);">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--warning)" stroke-width="2"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
                    </div>
                    <h3>Progress Trends</h3>
                    <p>Visual performance analytics and charts illustrate your long-term speed and accuracy progress attempt by attempt.</p>
                </div>

                <div class="feature-card fade-up delay-3">
                    <div class="feature-card-icon" style="background:var(--royal-blue-subtle); border:1px solid var(--royal-blue-border);">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--royal-blue)" stroke-width="2"><polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/></svg>
                    </div>
                    <h3>Real Code Snippets</h3>
                    <p>Type authentic code patterns from real projects rather than random prose, strengthening functional muscle memory.</p>
                </div>

                <div class="feature-card fade-up delay-4">
                    <div class="feature-card-icon" style="background:var(--error-bg); border:1px solid var(--error-border);">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--error)" stroke-width="2"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                    </div>
                    <h3>Mechanical Keyboard</h3>
                    <p>A technical virtual keyboard provides live visual feedback on finger placement, shift toggles, and upcoming keys.</p>
                </div>

                <div class="feature-card fade-up delay-5">
                    <div class="feature-card-icon" style="background:var(--surface-sunken); border:1px solid var(--border-strong);">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--almost-black)" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
                    </div>
                    <h3>Session History</h3>
                    <p>Every practice run is recorded with date, programming language, difficulty tier, speed, and accuracy breakdowns.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Bottom CTA Section -->
    <section class="section" style="padding-top: 32px; padding-bottom: 64px;">
        <div class="container container-wide text-center">
            <div class="card card-static fade-up" style="max-width: 760px; margin: 0 auto; padding: 48px 36px;">
                <span class="label-tag mb-2">Get Started</span>
                <h2 class="hero-heading" style="margin-top: 8px; margin-bottom: 12px;">Ready to sharpen your coding speed?</h2>
                <p class="body-large" style="margin-bottom: 28px;">
                    Benchmark yourself against real coding challenges. Free forever.
                </p>
                <div style="display:flex; gap:12px; justify-content:center; flex-wrap:wrap;">
                    <% if (currentUser != null) { %>
                    <a href="difficulty.jsp" class="btn btn-primary btn-lg">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                        <span>Start Practicing</span>
                    </a>
                    <a href="dashboard" class="btn btn-secondary btn-lg">View Dashboard</a>
                    <% } else { %>
                    <a href="signup.jsp" class="btn btn-primary btn-lg">Create Free Account</a>
                    <a href="login.jsp" class="btn btn-secondary btn-lg">Sign In</a>
                    <% } %>
                </div>
            </div>
        </div>
    </section>
</main>

<script>
    // Mobile navigation drawer toggle
    const navToggle = document.getElementById('nav-toggle');
    const mobileMenu = document.getElementById('mobile-menu');

    if (navToggle && mobileMenu) {
        navToggle.addEventListener('click', () => {
            mobileMenu.classList.toggle('open');
        });
    }
</script>
</body>
</html>
