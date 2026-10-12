<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coderush.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Typing Arena — CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Typing canvas styles */
        #code-display {
            white-space: pre-wrap;
            word-break: break-all;
            line-height: 1.9;
            min-height: 200px;
            user-select: none;
            -webkit-user-select: none;
        }
        #code-display span { transition: color 50ms, background 50ms; border-radius: 2px; }

        /* Overlay focus prompt */
        #focus-overlay {
            position: absolute;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(5,5,6,0.85);
            backdrop-filter: blur(4px);
            border-radius: inherit;
            flex-direction: column;
            gap: 12px;
            cursor: pointer;
            z-index: 10;
            transition: opacity 200ms;
        }
        #focus-overlay.hidden { opacity: 0; pointer-events: none; }
    </style>
</head>
<body>

<!-- Ambient Background -->
<div class="ambient-bg" aria-hidden="true">
    <div class="blob blob-1" style="opacity:0.25;"></div>
    <div class="blob blob-4" style="opacity:0.4;"></div>
</div>
<div class="grid-overlay" aria-hidden="true"></div>

<!-- Navbar -->
<nav class="navbar">
    <a href="index.jsp" class="brand-logo">Code<span>Rush</span></a>
    <div class="nav-links desktop-only">
        <a href="difficulty.jsp" class="nav-link">Mode</a>
        <a href="dashboard" class="nav-link">Dashboard</a>
        <a href="history" class="nav-link">History</a>
    </div>
    <div class="nav-actions desktop-only" style="display:flex;align-items:center;gap:12px;">
        <span style="font-size:0.875rem;color:var(--fg-muted);"><%= user.getUsername() %></span>
        <a href="logout" class="btn btn-ghost btn-sm">Log out</a>
    </div>
    <button class="nav-toggle" id="nav-toggle" aria-label="Toggle menu">
        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5">
            <path d="M3 6h14M3 10h14M3 14h14"/>
        </svg>
    </button>
</nav>
<div class="mobile-menu" id="mobile-menu">
    <a href="difficulty.jsp" class="nav-link">Mode</a>
    <a href="dashboard" class="nav-link">Dashboard</a>
    <a href="history" class="nav-link">History</a>
    <a href="logout" class="btn btn-ghost btn-sm" style="margin-top:8px;">Log out</a>
</div>

<!-- Main Content -->
<main>
    <div class="container" style="padding-top:40px;padding-bottom:80px;max-width:920px;">

        <!-- Top Row: Badges + Live Stats -->
        <div class="stat-bar fade-up" style="margin-bottom:24px;">
            <div style="display:flex;gap:8px;align-items:center;">
                <span id="ui-badge-lang" class="badge badge-lang">JAVA</span>
                <span id="ui-badge-diff" class="badge badge-easy">EASY</span>
                <span id="snippet-desc" style="font-size:0.8125rem;color:var(--fg-muted);margin-left:12px;"></span>
            </div>
            <div style="display:flex;gap:24px;align-items:center;">
                <div class="stat-bar-item">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                    <span id="timer" class="stat-bar-value" style="font-family:var(--font-mono);">00:00</span>
                </div>
                <div class="stat-bar-item">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>
                    <span id="live-wpm" class="stat-bar-value" style="font-family:var(--font-mono);">0</span>
                    <span>WPM</span>
                </div>
                <div class="stat-bar-item">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="22 11.08 22 12 a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                    <span id="live-accuracy" class="stat-bar-value" style="font-family:var(--font-mono);">100%</span>
                </div>
                <div class="stat-bar-item">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#f87171" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
                    <span id="mistakes-count" class="stat-bar-value" style="font-family:var(--font-mono);color:#f87171;">0</span>
                    <span>Errors</span>
                </div>
                <button id="restart-btn" class="btn btn-ghost btn-sm" title="Restart (Tab or Esc)">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="1 4 1 10 7 10"/><path d="M3.51 15a9 9 0 1 0 .49-3.01"/></svg>
                    Restart
                </button>
            </div>
        </div>

        <!-- Code Window -->
        <div id="code-window" class="code-window fade-up delay-1" style="cursor:text;position:relative;">
            <div class="code-window-header">
                <div class="code-window-dots">
                    <span></span><span></span><span></span>
                </div>
                <span id="file-label" style="color:var(--fg-muted);font-size:0.8125rem;">Loading snippet...</span>
                <span style="font-size:0.75rem;color:var(--fg-muted);">
                    <kbd style="background:rgba(255,255,255,0.05);border:1px solid var(--border);border-radius:4px;padding:1px 6px;">Tab</kbd> to restart
                </span>
            </div>
            <div class="code-window-body" style="position:relative;">
                <!-- Focus overlay -->
                <div id="focus-overlay">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--fg-muted)" stroke-width="1.5"><path d="M15 3h6v6M9 21H3v-6M21 3l-7 7M3 21l7-7"/></svg>
                    <span style="color:var(--fg-muted);font-size:0.875rem;">Click here to start typing</span>
                </div>
                <div id="code-display">Loading snippet...</div>
                <!-- Hidden typing input -->
                <textarea
                    id="typing-input"
                    class="typing-input-hidden"
                    autocomplete="off"
                    autocorrect="off"
                    autocapitalize="off"
                    spellcheck="false"
                    aria-label="Type the code shown above"
                ></textarea>
            </div>
        </div>

        <!-- Virtual Keyboard -->
        <div id="virtual-keyboard" class="virtual-keyboard fade-up delay-2">
            <div class="kb-row">
                <div class="kb-key" data-key="`"><span class="top-label">~</span><span class="bottom-label">`</span></div>
                <div class="kb-key" data-key="1"><span class="top-label">!</span><span class="bottom-label">1</span></div>
                <div class="kb-key" data-key="2"><span class="top-label">@</span><span class="bottom-label">2</span></div>
                <div class="kb-key" data-key="3"><span class="top-label">#</span><span class="bottom-label">3</span></div>
                <div class="kb-key" data-key="4"><span class="top-label">$</span><span class="bottom-label">4</span></div>
                <div class="kb-key" data-key="5"><span class="top-label">%</span><span class="bottom-label">5</span></div>
                <div class="kb-key" data-key="6"><span class="top-label">^</span><span class="bottom-label">6</span></div>
                <div class="kb-key" data-key="7"><span class="top-label">&</span><span class="bottom-label">7</span></div>
                <div class="kb-key" data-key="8"><span class="top-label">*</span><span class="bottom-label">8</span></div>
                <div class="kb-key" data-key="9"><span class="top-label">(</span><span class="bottom-label">9</span></div>
                <div class="kb-key" data-key="0"><span class="top-label">)</span><span class="bottom-label">0</span></div>
                <div class="kb-key" data-key="-"><span class="top-label">_</span><span class="bottom-label">-</span></div>
                <div class="kb-key" data-key="="><span class="top-label">+</span><span class="bottom-label">=</span></div>
                <div class="kb-key kb-key-wide" data-key="Backspace">Backspace</div>
            </div>
            <div class="kb-row">
                <div class="kb-key kb-key-wide" data-key="Tab">Tab</div>
                <div class="kb-key" data-key="q">Q</div>
                <div class="kb-key" data-key="w">W</div>
                <div class="kb-key" data-key="e">E</div>
                <div class="kb-key" data-key="r">R</div>
                <div class="kb-key" data-key="t">T</div>
                <div class="kb-key" data-key="y">Y</div>
                <div class="kb-key" data-key="u">U</div>
                <div class="kb-key" data-key="i">I</div>
                <div class="kb-key" data-key="o">O</div>
                <div class="kb-key" data-key="p">P</div>
                <div class="kb-key" data-key="["><span class="top-label">{</span><span class="bottom-label">[</span></div>
                <div class="kb-key" data-key="]"><span class="top-label">}</span><span class="bottom-label">]</span></div>
                <div class="kb-key" data-key="\"><span class="top-label">|</span><span class="bottom-label">\</span></div>
            </div>
            <div class="kb-row">
                <div class="kb-key kb-key-wide" data-key="CapsLock">Caps</div>
                <div class="kb-key" data-key="a">A</div>
                <div class="kb-key" data-key="s">S</div>
                <div class="kb-key" data-key="d">D</div>
                <div class="kb-key" data-key="f">F</div>
                <div class="kb-key" data-key="g">G</div>
                <div class="kb-key" data-key="h">H</div>
                <div class="kb-key" data-key="j">J</div>
                <div class="kb-key" data-key="k">K</div>
                <div class="kb-key" data-key="l">L</div>
                <div class="kb-key" data-key=";"><span class="top-label">:</span><span class="bottom-label">;</span></div>
                <div class="kb-key" data-key="'"><span class="top-label">"</span><span class="bottom-label">'</span></div>
                <div class="kb-key kb-key-wide" data-key="Enter">Enter</div>
            </div>
            <div class="kb-row">
                <div class="kb-key kb-key-wide" data-key="ShiftLeft">Shift</div>
                <div class="kb-key" data-key="z">Z</div>
                <div class="kb-key" data-key="x">X</div>
                <div class="kb-key" data-key="c">C</div>
                <div class="kb-key" data-key="v">V</div>
                <div class="kb-key" data-key="b">B</div>
                <div class="kb-key" data-key="n">N</div>
                <div class="kb-key" data-key="m">M</div>
                <div class="kb-key" data-key=","><span class="top-label"><</span><span class="bottom-label">,</span></div>
                <div class="kb-key" data-key="."><span class="top-label">></span><span class="bottom-label">.</span></div>
                <div class="kb-key" data-key="/"><span class="top-label">?</span><span class="bottom-label">/</span></div>
                <div class="kb-key kb-key-wide" data-key="ShiftRight">Shift</div>
            </div>
            <div class="kb-row">
                <div class="kb-key kb-key-wide" data-key="Ctrl">Ctrl</div>
                <div class="kb-key kb-key-wide" data-key="Alt">Alt</div>
                <div class="kb-key kb-key-space" data-key=" ">Space</div>
                <div class="kb-key kb-key-wide" data-key="Alt">Alt</div>
                <div class="kb-key kb-key-wide" data-key="Ctrl">Ctrl</div>
            </div>
        </div>

        <!-- Hidden result submission form -->
        <form id="result-form" action="result" method="POST" style="display:none;">
            <input type="hidden" id="res-snippetId"  name="snippetId">
            <input type="hidden" id="res-language"   name="language">
            <input type="hidden" id="res-difficulty" name="difficulty">
            <input type="hidden" id="res-wpm"        name="wpm">
            <input type="hidden" id="res-accuracy"   name="accuracy">
            <input type="hidden" id="res-mistakes"   name="mistakes">
            <input type="hidden" id="res-timeTaken"  name="timeTaken">
        </form>

    </div>
</main>

<script>
    const navToggle = document.getElementById('nav-toggle');
    const mobileMenu = document.getElementById('mobile-menu');
    navToggle.addEventListener('click', () => mobileMenu.classList.toggle('open'));

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(e => { if (e.isIntersecting) { e.target.style.animationPlayState = 'running'; observer.unobserve(e.target); } });
    }, { threshold: 0.1 });
    document.querySelectorAll('.fade-up').forEach(el => { el.style.animationPlayState = 'paused'; observer.observe(el); });

    // Hide focus overlay once typing starts
    const focusOverlay = document.getElementById('focus-overlay');
    const codeWindow   = document.getElementById('code-window');
    const typingInput  = document.getElementById('typing-input');

    codeWindow.addEventListener('click', () => {
        typingInput.focus();
        focusOverlay.classList.add('hidden');
    });

    typingInput.addEventListener('focus', () => {
        focusOverlay.classList.add('hidden');
    });

    typingInput.addEventListener('blur', () => {
        if (window._typingStarted) return; // keep hidden once started
        focusOverlay.classList.remove('hidden');
    });
</script>
<script src="js/typing.js"></script>
</body>
</html>
