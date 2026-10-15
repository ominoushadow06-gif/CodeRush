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
    <title>Practice Arena — CodeRush</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="brand-logo">Code<span>Rush</span><span class="brand-badge">Trainer</span></a>
        
        <div class="nav-links desktop-only">
            <a href="dashboard" class="nav-link">Dashboard</a>
            <a href="difficulty.jsp" class="nav-link active">Practice</a>
            <a href="history" class="nav-link">History</a>
        </div>

        <div class="nav-actions desktop-only">
            <div class="user-pill">
                <span class="user-avatar"><%= user.getUsername().substring(0, 1) %></span>
                <span><%= user.getUsername() %></span>
            </div>
            <a href="logout" class="btn btn-ghost btn-sm">Log out</a>
        </div>

        <button class="nav-toggle" id="nav-toggle" aria-label="Toggle menu">
            <svg width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.75">
                <path d="M3 5h14M3 10h14M3 15h14"/>
            </svg>
        </button>
    </div>
</nav>

<!-- Mobile Menu -->
<div class="mobile-menu" id="mobile-menu">
    <div style="padding: 4px 14px 8px; font-weight: 600; color: var(--text-primary);">
        Signed in as <%= user.getUsername() %>
    </div>
    <a href="dashboard" class="nav-link">Dashboard</a>
    <a href="difficulty.jsp" class="nav-link active">Practice</a>
    <a href="history" class="nav-link">History</a>
    <a href="logout" class="btn btn-secondary btn-sm" style="margin-top:8px;">Log out</a>
</div>

<!-- Main Practice Workspace (Full Desktop Utilization: ~1400px) -->
<main>
    <div class="container container-practice" style="padding-top:28px; padding-bottom:48px;">

        <!-- 1. Top Section: Badges & Live Telemetry (Full Width) -->
        <div class="stat-bar fade-up">
            <!-- Left Info: Language, Difficulty, Snippet Topic -->
            <div style="display:flex; gap:10px; align-items:center; flex-wrap:wrap;">
                <span id="ui-badge-lang" class="badge badge-lang">JAVA</span>
                <span id="ui-badge-diff" class="badge badge-easy">EASY</span>
                <span id="snippet-desc" style="font-size:0.875rem; color:var(--text-secondary); margin-left:6px; font-weight:500;">Loading challenge...</span>
            </div>

            <!-- Right Telemetry: Timer, WPM, Accuracy, Mistakes, Restart -->
            <div class="stat-bar-group">
                <div class="stat-bar-item" title="Elapsed Time">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                    <span id="timer" class="stat-bar-value">00:00</span>
                </div>

                <div class="stat-bar-item" title="Live Typing Speed">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="var(--royal-blue)" stroke-width="2"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>
                    <span id="live-wpm" class="stat-bar-value" style="color:var(--royal-blue);">0</span>
                    <span style="font-size:0.75rem; color:var(--text-muted);">WPM</span>
                </div>

                <div class="stat-bar-item" title="Typing Accuracy">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="var(--success)" stroke-width="2"><polyline points="22 11.08 22 12 a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                    <span id="live-accuracy" class="stat-bar-value" style="color:var(--success);">100%</span>
                </div>

                <div class="stat-bar-item" title="Total Keystroke Errors">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="var(--error)" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
                    <span id="mistakes-count" class="stat-bar-value" style="color:var(--error);">0</span>
                    <span style="font-size:0.75rem; color:var(--text-muted);">ERR</span>
                </div>

                <button id="restart-btn" class="btn btn-secondary btn-sm" title="Restart snippet (Tab or Esc)">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="1 4 1 10 7 10"/><path d="M3.51 15a9 9 0 1 0 .49-3.01"/></svg>
                    <span>Restart</span>
                </button>
            </div>
        </div>

        <!-- 2. Main Section: Coding Editor Panel (Full Width of ~1400px Workspace) -->
        <div id="code-window" class="code-window fade-up delay-1">
            <div class="code-window-header">
                <div class="code-window-dots">
                    <span></span><span></span><span></span>
                </div>
                <span id="file-label" style="font-weight:500; color:#CBD5E1;">editor.java</span>
                <span style="font-size:0.75rem; color:var(--muted-blue-gray);">
                    <kbd>Tab</kbd> or <kbd>Esc</kbd> to restart
                </span>
            </div>

            <div class="code-window-body">
                <!-- Focus prompt overlay -->
                <div id="focus-overlay">
                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#FFFFFF" stroke-width="2"><path d="M15 3h6v6M9 21H3v-6M21 3l-7 7M3 21l7-7"/></svg>
                    <span>Click anywhere in this code block to start typing</span>
                </div>

                <!-- Text presentation -->
                <div id="code-display">Loading snippet...</div>

                <!-- Hidden capture textarea -->
                <textarea
                    id="typing-input"
                    class="typing-input-hidden"
                    autocomplete="off"
                    autocorrect="off"
                    autocapitalize="off"
                    spellcheck="false"
                    aria-label="Code typing input"
                ></textarea>
            </div>
        </div>

        <!-- 3. Bottom Section: Mechanical Virtual Keyboard (Full Width matching Editor) -->
        <div id="virtual-keyboard" class="virtual-keyboard fade-up delay-2">
            <!-- Row 1: Numbers & Symbols -->
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

            <!-- Row 2: QWERTY -->
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

            <!-- Row 3: ASDF -->
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

            <!-- Row 4: ZXCV -->
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

            <!-- Row 5: Space & Modifiers -->
            <div class="kb-row">
                <div class="kb-key kb-key-wide" data-key="Ctrl">Ctrl</div>
                <div class="kb-key kb-key-wide" data-key="Alt">Alt</div>
                <div class="kb-key kb-key-space" data-key=" ">Space</div>
                <div class="kb-key kb-key-wide" data-key="Alt">Alt</div>
                <div class="kb-key kb-key-wide" data-key="Ctrl">Ctrl</div>
            </div>
        </div>

        <!-- Hidden result submission form (Required by typing.js) -->
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
    if (navToggle && mobileMenu) {
        navToggle.addEventListener('click', () => mobileMenu.classList.toggle('open'));
    }

    // Overlay focus management
    const focusOverlay = document.getElementById('focus-overlay');
    const codeWindow   = document.getElementById('code-window');
    const typingInput  = document.getElementById('typing-input');

    if (codeWindow && typingInput && focusOverlay) {
        codeWindow.addEventListener('click', () => {
            typingInput.focus();
            focusOverlay.classList.add('hidden');
        });

        typingInput.addEventListener('focus', () => {
            focusOverlay.classList.add('hidden');
        });

        typingInput.addEventListener('blur', () => {
            if (window._typingStarted) return;
            focusOverlay.classList.remove('hidden');
        });
    }
</script>
<script src="js/typing.js"></script>
</body>
</html>
