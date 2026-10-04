/**
 * CodeRush - Real-Time Code Typing Engine & Performance Analyzer
 */

let timerInterval = null;
let startTime = null;
let totalSeconds = 0;
let mistakes = 0;
let totalKeystrokes = 0;
let isStarted = false;
let isCompleted = false;
let snippetText = "";
let snippetId = 0;
let language = "java";
let difficulty = "easy";

document.addEventListener('DOMContentLoaded', () => {
    const codeDisplay = document.getElementById('code-display');
    const typingInput = document.getElementById('typing-input');
    const restartBtn = document.getElementById('restart-btn');

    if (!codeDisplay || !typingInput) return;

    // Parse URL parameters
    const urlParams = new URLSearchParams(window.location.search);
    language = urlParams.get('language') || 'java';
    difficulty = urlParams.get('difficulty') || 'easy';

    // Update UI Badges
    const langBadge = document.getElementById('ui-badge-lang');
    const diffBadge = document.getElementById('ui-badge-diff');
    if (langBadge) langBadge.textContent = language.toUpperCase();
    if (diffBadge) {
        diffBadge.textContent = difficulty.toUpperCase();
        diffBadge.className = `badge badge-${difficulty.toLowerCase()}`;
    }

    // Load Snippet from Backend API
    loadSnippet();

    // Event Listeners
    typingInput.addEventListener('input', handleTyping);
    typingInput.addEventListener('keydown', handleKeyDown);

    // Clicking anywhere on code display focuses hidden input
    const codeWindow = document.getElementById('code-window');
    if (codeWindow) {
        codeWindow.addEventListener('click', () => {
            if (!isCompleted) typingInput.focus();
        });
    }

    if (restartBtn) {
        restartBtn.addEventListener('click', resetPractice);
    }
});

function loadSnippet() {
    const codeDisplay = document.getElementById('code-display');
    const descEl = document.getElementById('snippet-desc');

    fetch(`snippet?language=${encodeURIComponent(language)}&difficulty=${encodeURIComponent(difficulty)}`)
        .then(res => res.json())
        .then(data => {
            if (data.error) {
                codeDisplay.innerHTML = `<span style="color: var(--danger)">${data.error}</span>`;
                return;
            }
            snippetId = data.snippetId;
            snippetText = data.codeText.replace(/\r\n/g, '\n'); // Normalize newlines

            if (descEl && data.description) {
                descEl.textContent = data.description.replace(/\\n/g, ' ');
            }

            renderSnippet(snippetText);
            const typingInput = document.getElementById('typing-input');
            typingInput.value = '';
            typingInput.disabled = false;
            typingInput.focus();
        })
        .catch(err => {
            codeDisplay.innerHTML = '<span style="color: var(--danger)">Failed to load snippet from server.</span>';
            console.error('Error loading snippet:', err);
        });
}

function renderSnippet(text) {
    const codeDisplay = document.getElementById('code-display');
    codeDisplay.innerHTML = '';
    for (let i = 0; i < text.length; i++) {
        const span = document.createElement('span');
        span.textContent = text[i];
        if (i === 0) span.classList.add('char-current');
        codeDisplay.appendChild(span);
    }
}

function handleKeyDown(e) {
    // Keyboard Shortcut: Tab or Escape to quick restart
    if (e.key === 'Tab' || e.key === 'Escape') {
        e.preventDefault();
        resetPractice();
        return;
    }
}

function handleTyping(e) {
    if (isCompleted) return;

    if (!isStarted) {
        startTimer();
        isStarted = true;
    }

    totalKeystrokes++;
    const inputVal = e.target.value;
    const chars = document.querySelectorAll('#code-display span');
    let currentMistakes = 0;
    let correctChars = 0;

    for (let i = 0; i < chars.length; i++) {
        chars[i].className = '';
        if (i < inputVal.length) {
            if (inputVal[i] === snippetText[i]) {
                chars[i].classList.add('char-correct');
                correctChars++;
            } else {
                chars[i].classList.add('char-incorrect');
                currentMistakes++;
            }
        } else if (i === inputVal.length) {
            chars[i].classList.add('char-current');
        }
    }

    mistakes = currentMistakes;
    document.getElementById('mistakes-count').textContent = mistakes;

    // Calculate Real-Time Live Stats
    const elapsedMinutes = Math.max(totalSeconds / 60, 0.016); // avoid zero div
    const liveWpm = Math.max(0, Math.round(((inputVal.length / 5) / elapsedMinutes)));
    const liveAccuracy = inputVal.length > 0
        ? Math.max(0, Math.round(((correctChars / inputVal.length) * 100)))
        : 100;

    const liveWpmEl = document.getElementById('live-wpm');
    const liveAccEl = document.getElementById('live-accuracy');
    if (liveWpmEl) liveWpmEl.textContent = liveWpm;
    if (liveAccEl) liveAccEl.textContent = `${liveAccuracy}%`;

    // Check Completion
    if (inputVal.length >= snippetText.length) {
        isCompleted = true;
        endSession(correctChars, inputVal.length);
    }
}

function startTimer() {
    startTime = Date.now();
    timerInterval = setInterval(() => {
        totalSeconds = Math.floor((Date.now() - startTime) / 1000);
        const mins = String(Math.floor(totalSeconds / 60)).padStart(2, '0');
        const secs = String(totalSeconds % 60).padStart(2, '0');
        const timerEl = document.getElementById('timer');
        if (timerEl) timerEl.textContent = `${mins}:${secs}`;
    }, 1000);
}

function endSession(correctChars, totalTyped) {
    clearInterval(timerInterval);
    const durationMinutes = Math.max(totalSeconds / 60, 0.016);
    const totalChars = snippetText.length;

    // Standard WPM = (All Typed Chars / 5) / TimeInMinutes
    const finalWpm = Math.round(((totalChars / 5) / durationMinutes) * 100) / 100;
    const finalAccuracy = Math.max(0, Math.min(100, Math.round(((correctChars / totalChars) * 10000) / 100)));

    // Populate hidden form and submit
    document.getElementById('res-snippetId').value = snippetId;
    document.getElementById('res-language').value = language;
    document.getElementById('res-difficulty').value = difficulty;
    document.getElementById('res-wpm').value = finalWpm;
    document.getElementById('res-accuracy').value = finalAccuracy;
    document.getElementById('res-mistakes').value = mistakes;
    document.getElementById('res-timeTaken').value = Math.max(totalSeconds, 1);

    // Auto-submit to servlet
    setTimeout(() => {
        document.getElementById('result-form').submit();
    }, 300);
}

function resetPractice() {
    clearInterval(timerInterval);
    timerInterval = null;
    startTime = null;
    totalSeconds = 0;
    mistakes = 0;
    totalKeystrokes = 0;
    isStarted = false;
    isCompleted = false;

    const timerEl = document.getElementById('timer');
    const mistakesEl = document.getElementById('mistakes-count');
    const liveWpmEl = document.getElementById('live-wpm');
    const liveAccEl = document.getElementById('live-accuracy');

    if (timerEl) timerEl.textContent = '00:00';
    if (mistakesEl) mistakesEl.textContent = '0';
    if (liveWpmEl) liveWpmEl.textContent = '0';
    if (liveAccEl) liveAccEl.textContent = '100%';

    loadSnippet();
}
