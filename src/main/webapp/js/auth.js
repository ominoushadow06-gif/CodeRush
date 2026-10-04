/**
 * CodeRush - Authentication & Client-Side Validation Suite
 */

document.addEventListener('DOMContentLoaded', () => {
    // Signup Form Handler
    const signupForm = document.getElementById('signup-form');
    if (signupForm) {
        const usernameInput = document.getElementById('username');
        const emailInput = document.getElementById('email');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const strengthMeter = document.getElementById('password-strength-meter');
        const strengthText = document.getElementById('password-strength-text');

        // Dynamic Password Strength Meter
        if (passwordInput && strengthMeter && strengthText) {
            passwordInput.addEventListener('input', () => {
                const val = passwordInput.value;
                let score = 0;
                if (val.length >= 6) score++;
                if (val.length >= 10) score++;
                if (/[A-Z]/.test(val)) score++;
                if (/[0-9]/.test(val)) score++;
                if (/[^A-Za-z0-9]/.test(val)) score++;

                switch (score) {
                    case 0:
                    case 1:
                        strengthMeter.style.width = '20%';
                        strengthMeter.style.backgroundColor = 'var(--danger)';
                        strengthText.textContent = 'Too weak';
                        strengthText.style.color = 'var(--danger)';
                        break;
                    case 2:
                    case 3:
                        strengthMeter.style.width = '60%';
                        strengthMeter.style.backgroundColor = 'var(--warning)';
                        strengthText.textContent = 'Moderate';
                        strengthText.style.color = 'var(--warning)';
                        break;
                    case 4:
                    case 5:
                        strengthMeter.style.width = '100%';
                        strengthMeter.style.backgroundColor = 'var(--success)';
                        strengthText.textContent = 'Strong';
                        strengthText.style.color = 'var(--success)';
                        break;
                }
            });
        }

        // Form Submit Validation
        signupForm.addEventListener('submit', (e) => {
            clearErrors();
            let hasError = false;

            // Username check
            if (usernameInput.value.trim().length < 3) {
                showError('Username must be at least 3 characters long.');
                shakeElement(signupForm);
                e.preventDefault();
                return;
            }

            // Email check
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(emailInput.value.trim())) {
                showError('Please enter a valid email address.');
                shakeElement(signupForm);
                e.preventDefault();
                return;
            }

            // Password matching check
            if (confirmPasswordInput && passwordInput.value !== confirmPasswordInput.value) {
                showError('Passwords do not match.');
                shakeElement(signupForm);
                e.preventDefault();
                return;
            }
        });
    }

    // Login Form Handler
    const loginForm = document.getElementById('login-form');
    if (loginForm) {
        loginForm.addEventListener('submit', (e) => {
            const identifierInput = document.getElementById('identifier');
            const passwordInput = document.getElementById('password');

            if (!identifierInput.value.trim() || !passwordInput.value) {
                e.preventDefault();
                showError('Please fill in both fields.');
                shakeElement(loginForm);
            }
        });
    }
});

function shakeElement(el) {
    el.classList.remove('shake');
    void el.offsetWidth; // Trigger reflow
    el.classList.add('shake');
}

function showError(msg) {
    let errorBox = document.getElementById('client-error-box');
    if (!errorBox) {
        errorBox = document.createElement('div');
        errorBox.id = 'client-error-box';
        errorBox.className = 'alert alert-danger';
        const form = document.querySelector('form');
        form.parentNode.insertBefore(errorBox, form);
    }
    errorBox.textContent = msg;
    errorBox.style.display = 'flex';
}

function clearErrors() {
    const errorBox = document.getElementById('client-error-box');
    if (errorBox) {
        errorBox.style.display = 'none';
    }
}
