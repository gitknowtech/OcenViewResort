// Login Modal Functionality
document.addEventListener('DOMContentLoaded', function() {
    const loginBtn = document.getElementById('loginBtn');
    const loginModal = document.getElementById('loginModal');
    const loginClose = document.getElementById('loginClose');
    const loginModalOverlay = document.getElementById('loginModalOverlay');
    const loginForm = document.getElementById('loginForm');
    const passwordToggle = document.getElementById('passwordToggle');
    const loginPassword = document.getElementById('loginPassword');
    const loginSuccess = document.getElementById('loginSuccess');
    const signupLink = document.getElementById('signupLink');

    // Open login modal
    loginBtn.addEventListener('click', function() {
        loginModal.classList.add('active');
        document.body.style.overflow = 'hidden';
    });

    // Close login modal
    function closeModal() {
        loginModal.classList.remove('active');
        document.body.style.overflow = 'auto';
        // Reset form
        loginForm.reset();
        loginForm.style.display = 'block';
        loginSuccess.style.display = 'none';
        // Remove error states
        const inputs = loginForm.querySelectorAll('input');
        inputs.forEach(input => input.classList.remove('error'));
    }

    loginClose.addEventListener('click', closeModal);
    loginModalOverlay.addEventListener('click', closeModal);

    // Close modal on Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && loginModal.classList.contains('active')) {
            closeModal();
        }
    });

    // Password toggle
    passwordToggle.addEventListener('click', function() {
        const type = loginPassword.getAttribute('type') === 'password' ? 'text' : 'password';
        loginPassword.setAttribute('type', type);
        
        const icon = this.querySelector('i');
        if (type === 'text') {
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    });

    // Form submission
    loginForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const email = document.getElementById('loginEmail').value;
        const password = document.getElementById('loginPassword').value;
        const submitBtn = this.querySelector('.login-submit-btn');
        
        // Basic validation
        let isValid = true;
        
        if (!email || !isValidEmail(email)) {
            document.getElementById('loginEmail').classList.add('error');
            isValid = false;
        } else {
            document.getElementById('loginEmail').classList.remove('error');
        }
        
        if (!password || password.length < 6) {
            document.getElementById('loginPassword').classList.add('error');
            isValid = false;
        } else {
            document.getElementById('loginPassword').classList.remove('error');
        }
        
        if (!isValid) {
            return;
        }
        
        // Show loading state
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing In...';
        submitBtn.classList.add('loading');
        
        // Simulate login process (replace with actual API call)
        setTimeout(() => {
            // Hide form and show success message
            loginForm.style.display = 'none';
            loginSuccess.style.display = 'block';
            
            // Update login button to show user is logged in
            setTimeout(() => {
                loginBtn.innerHTML = '<i class="fas fa-user-check"></i><span>Welcome!</span>';
                loginBtn.style.background = 'linear-gradient(135deg, #10b981, #059669)';
                
                // Close modal after success
                setTimeout(() => {
                    closeModal();
                    // Reset button after modal closes
                    setTimeout(() => {
                        submitBtn.innerHTML = originalText;
                        submitBtn.classList.remove('loading');
                    }, 300);
                }, 2000);
            }, 1000);
            
        }, 2000);
    });

    // Social login buttons
    const socialButtons = document.querySelectorAll('.social-btn');
    socialButtons.forEach(button => {
        button.addEventListener('click', function() {
            const provider = this.classList.contains('google-btn') ? 'Google' : 'Facebook';
            
            // Show loading state
            const originalText = this.innerHTML;
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Connecting...';
            this.style.pointerEvents = 'none';
            
            // Simulate social login (replace with actual OAuth)
            setTimeout(() => {
                alert(`${provider} login will be implemented soon!`);
                this.innerHTML = originalText;
                this.style.pointerEvents = 'auto';
            }, 1500);
        });
    });

    // Signup link
    signupLink.addEventListener('click', function(e) {
        e.preventDefault();
        alert('Signup functionality will be implemented soon!');
    });

    // Input focus effects
    const inputs = loginForm.querySelectorAll('input');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.classList.remove('error');
        });
    });

    // Email validation function
    function isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }
});
