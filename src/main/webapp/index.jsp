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
    <title>CodeRush — Master Coding Syntax</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Ambient Background -->
<div class="ambient-bg" aria-hidden="true">
    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>
    <div class="blob blob-3"></div>
    <div class="blob blob-4"></div>
</div>
<div class="grid-overlay" aria-hidden="true"></div>

<!-- Navbar -->
<nav class="navbar">
    <a href="index.jsp" class="brand-logo">Code<span>Rush</span></a>

    <!-- Desktop nav -->
    <div class="nav-links desktop-only">
        <a href="difficulty.jsp" class="nav-link">Practice</a>
        <a href="#features" class="nav-link">Features</a>
        <% if (currentUser != null) { %>
        <a href="history" class="nav-link">History</a>
        <% } %>
    </div>

    <div class="nav-actions desktop-only" style="display:flex;align-items:center;gap:12px;">
        <% if (currentUser != null) { %>
        <a href="dashboard" class="btn btn-ghost btn-sm"><%= currentUser.getUsername() %></a>
        <a href="logout" class="btn btn-secondary btn-sm">Log out</a>
        <% } else { %>
        <a href="login.jsp" class="btn btn-ghost btn-sm">Log In</a>
        <a href="signup.jsp" class="btn btn-primary btn-sm">Get Started</a>
        <% } %>
    </div>

    <!-- Mobile -->
    <button class="nav-toggle" id="nav-toggle" aria-label="Toggle menu">
        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5">
            <path id="menu-icon" d="M3 6h14M3 10h14M3 14h14"/>
        </svg>
    </button>
</nav>

<div class="mobile-menu" id="mobile-menu">
    <a href="difficulty.jsp" class="nav-link">Practice</a>
    <a href="#features" class="nav-link">Features</a>
    <% if (currentUser != null) { %>
    <a href="history" class="nav-link">History</a>
    <a href="dashboard" class="nav-link">Dashboard</a>
    <a href="logout" class="btn btn-secondary btn-block" style="margin-top:8px;">Log out</a>
    <% } else { %>
    <a href="login.jsp" class="nav-link">Log In</a>
    <a href="signup.jsp" class="btn btn-primary btn-block" style="margin-top:8px;">Get Started</a>
    <% } %>
</div>

<!-- Hero Section -->
<main>
    <section class="section" style="padding-top: 112px;">
        <div class="container" style="display:grid; grid-template-columns:1fr 1fr; gap:80px; align-items:center;">

            <!-- Left: Copy -->
            <div>
                <div class="label-tag fade-up mb-4">CODE · TYPE · IMPROVE</div>
                <h1 class="display-heading fade-up delay-1" style="margin-bottom:24px;">
                    <span class="text-gradient">Master coding&nbsp;syntax,</span><br>
                    <span class="text-accent-gradient">one keystroke</span><br>
                    <span class="text-gradient">at a time.</span>
                </h1>
                <p class="body-large fade-up delay-2" style="margin-bottom:40px;">
                    Practice real Java, Python and C code while tracking your typing speed,
                    accuracy and mistakes in real time. Used by engineers who care about the craft.
                </p>
                <div style="display:flex;gap:16px;flex-wrap:wrap;" class="fade-up delay-3">
                    <a href="difficulty.jsp" class="btn btn-primary btn-lg">Start Practicing</a>
                    <a href="#features" class="btn btn-secondary btn-lg">See Features</a>
                </div>

                <!-- Social proof strip -->
                <div style="display:flex;align-items:center;gap:16px;margin-top:40px;padding-top:32px;border-top:1px solid var(--border);" class="fade-up delay-4">
                    <div style="display:flex;gap:-4px;">
                        <div style="width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,#5E6AD2,#818cf8);border:2px solid var(--bg-base);"></div>
                        <div style="width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,#818cf8,#a78bfa);border:2px solid var(--bg-base);margin-left:-8px;"></div>
                        <div style="width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,#a78bfa,#c4b5fd);border:2px solid var(--bg-base);margin-left:-8px;"></div>
                    </div>
                    <span class="text-muted" style="font-size:0.875rem;">Trusted by developers who obsess over speed</span>
                </div>
            </div>

            <!-- Right: Mock Code Editor Preview -->
            <div class="fade-up delay-2">
                <div class="code-window">
                    <div class="code-window-header">
                        <div class="code-window-dots">
                            <span></span><span></span><span></span>
                        </div>
                        <span style="color:var(--fg-muted);">BinarySearch.java</span>
                        <div style="display:flex;gap:8px;">
                            <span class="badge badge-lang">JAVA</span>
                            <span class="badge badge-hard">HARD</span>
                        </div>
                    </div>
                    <div class="code-window-body" style="font-size:0.9375rem;">
                        <div style="color:var(--fg-muted);margin-bottom:4px;"><span style="color:#818cf8;">public int</span> <span style="color:#5E6AD2;">binarySearch</span>(<span style="color:#818cf8;">int</span>[] arr, <span style="color:#818cf8;">int</span> target) {</div>
                        <div style="padding-left:20px;color:var(--fg-muted);margin-bottom:4px;"><span style="color:#818cf8;">int</span> left = 0, right = arr.length - 1;</div>
                        <div style="padding-left:20px;color:rgba(255,255,255,0.30);margin-bottom:4px;">// Binary search logic...</div>
                        <div style="color:var(--fg-muted);margin-top:4px;">}</div>
                    </div>
                    <div style="display:flex;justify-content:space-around;padding:16px 24px;border-top:1px solid var(--border);">
                        <div style="text-align:center;">
                            <div style="font-family:var(--font-mono);font-size:1.25rem;font-weight:700;color:var(--fg);">72</div>
                            <div style="font-size:0.75rem;color:var(--fg-muted);text-transform:uppercase;letter-spacing:0.06em;">WPM</div>
                        </div>
                        <div style="text-align:center;">
                            <div style="font-family:var(--font-mono);font-size:1.25rem;font-weight:700;color:#4ade80;">98%</div>
                            <div style="font-size:0.75rem;color:var(--fg-muted);text-transform:uppercase;letter-spacing:0.06em;">Accuracy</div>
                        </div>
                        <div style="text-align:center;">
                            <div style="font-family:var(--font-mono);font-size:1.25rem;font-weight:700;color:var(--fg);">12s</div>
                            <div style="font-size:0.75rem;color:var(--fg-muted);text-transform:uppercase;letter-spacing:0.06em;">Time</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Divider -->
    <div class="container"><div class="section-divider"></div></div>

    <!-- Features Section -->
    <section class="section" id="features">
        <div class="container">
            <div class="text-center mb-10">
                <div class="label-tag mb-4 fade-up">Why CodeRush</div>
                <h2 class="hero-heading text-gradient fade-up delay-1" style="margin-bottom:16px;">Built for engineers<br>who care about craft</h2>
                <p class="body-large fade-up delay-2" style="max-width:560px;margin:0 auto;">Every detail is engineered for deliberate practice. Measure what matters.</p>
            </div>

            <div class="feature-grid" style="margin-top:64px;">
                <div class="feature-card fade-up">
                    <div style="width:48px;height:48px;border-radius:12px;background:rgba(94,106,210,0.15);border:1px solid var(--border-accent);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>
                    </div>
                    <h3 style="font-size:1.25rem;margin-bottom:10px;">Real-time WPM</h3>
                    <p style="color:var(--fg-muted);font-size:0.9375rem;line-height:1.6;">Live words-per-minute calculation as you type. Watch your speed update with every keystroke.</p>
                </div>

                <div class="feature-card fade-up delay-1">
                    <div style="width:48px;height:48px;border-radius:12px;background:rgba(34,197,94,0.10);border:1px solid rgba(34,197,94,0.20);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#4ade80" stroke-width="1.5"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                    </div>
                    <h3 style="font-size:1.25rem;margin-bottom:10px;">Accuracy Tracking</h3>
                    <p style="color:var(--fg-muted);font-size:0.9375rem;line-height:1.6;">Character-level precision. Every correct and incorrect keystroke is highlighted and recorded.</p>
                </div>

                <div class="feature-card fade-up delay-2">
                    <div style="width:48px;height:48px;border-radius:12px;background:rgba(245,158,11,0.10);border:1px solid rgba(245,158,11,0.20);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#fbbf24" stroke-width="1.5"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
                    </div>
                    <h3 style="font-size:1.25rem;margin-bottom:10px;">Progress Trends</h3>
                    <p style="color:var(--fg-muted);font-size:0.9375rem;line-height:1.6;">Visual performance history with charts showing your speed and accuracy over every session.</p>
                </div>

                <div class="feature-card fade-up delay-3">
                    <div style="width:48px;height:48px;border-radius:12px;background:rgba(139,92,246,0.10);border:1px solid rgba(139,92,246,0.20);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#a78bfa" stroke-width="1.5"><polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/></svg>
                    </div>
                    <h3 style="font-size:1.25rem;margin-bottom:10px;">Real Code Snippets</h3>
                    <p style="color:var(--fg-muted);font-size:0.9375rem;line-height:1.6;">Practice with actual Java, Python and C code — not random words. Learn syntax as you type.</p>
                </div>

                <div class="feature-card fade-up delay-4">
                    <div style="width:48px;height:48px;border-radius:12px;background:rgba(239,68,68,0.10);border:1px solid rgba(239,68,68,0.20);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#f87171" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                    </div>
                    <h3 style="font-size:1.25rem;margin-bottom:10px;">Difficulty Modes</h3>
                    <p style="color:var(--fg-muted);font-size:0.9375rem;line-height:1.6;">Three difficulty levels — Easy, Medium, Hard — so you always have an appropriate challenge.</p>
                </div>

                <div class="feature-card fade-up delay-5">
                    <div style="width:48px;height:48px;border-radius:12px;background:rgba(94,106,210,0.15);border:1px solid var(--border-accent);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                    </div>
                    <h3 style="font-size:1.25rem;margin-bottom:10px;">Session Analytics</h3>
                    <p style="color:var(--fg-muted);font-size:0.9375rem;line-height:1.6;">Detailed post-session breakdown: WPM, accuracy, mistakes — saved to your personal history.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Footer Band -->
    <section style="padding:80px 0;">
        <div class="container text-center">
            <div style="max-width:560px;margin:0 auto;" class="fade-up">
                <div class="label-tag mb-4">Get started free</div>
                <h2 class="hero-heading text-gradient" style="margin-bottom:16px;">Ready to sharpen<br>your coding speed?</h2>
                <p class="body-large" style="margin-bottom:40px;">Join CodeRush and start measuring what matters. No credit card required.</p>
                <div style="display:flex;gap:16px;justify-content:center;flex-wrap:wrap;">
                    <% if (currentUser != null) { %>
                    <a href="difficulty.jsp" class="btn btn-primary btn-lg">Start Practicing</a>
                    <a href="dashboard" class="btn btn-secondary btn-lg">Your Dashboard</a>
                    <% } else { %>
                    <a href="signup.jsp" class="btn btn-primary btn-lg">Create Free Account</a>
                    <a href="login.jsp" class="btn btn-secondary btn-lg">Log In</a>
                    <% } %>
                </div>
            </div>
        </div>
    </section>
</main>

<script>
    // Mobile nav toggle
    const navToggle = document.getElementById('nav-toggle');
    const mobileMenu = document.getElementById('mobile-menu');

    navToggle.addEventListener('click', () => {
        const isOpen = mobileMenu.classList.toggle('open');
        navToggle.setAttribute('aria-expanded', isOpen);
    });

    // Scroll-triggered fade-up animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(e => {
            if (e.isIntersecting) {
                e.target.style.animationPlayState = 'running';
                observer.unobserve(e.target);
            }
        });
    }, { threshold: 0.15 });

    document.querySelectorAll('.fade-up').forEach(el => {
        el.style.animationPlayState = 'paused';
        observer.observe(el);
    });

    // Mouse-tracking card spotlights
    document.querySelectorAll('.feature-card, .code-window').forEach(card => {
        card.addEventListener('mousemove', (e) => {
            const rect = card.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            card.style.setProperty('--spotlight-x', `${x}px`);
            card.style.setProperty('--spotlight-y', `${y}px`);

            let spotlight = card.querySelector('.spotlight');
            if (!spotlight) {
                spotlight = document.createElement('div');
                spotlight.className = 'spotlight';
                card.appendChild(spotlight);
            }
            spotlight.style.background = `radial-gradient(300px circle at ${x}px ${y}px, rgba(94,106,210,0.12), transparent)`;
        });
    });
</script>
</body>
</html>
