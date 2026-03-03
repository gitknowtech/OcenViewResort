<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/contact.css">

<!-- Contact Section -->
<section class="section active" id="contact">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Get In Touch</h2>
            <p class="section-subtitle">We're here to help make your ocean adventure unforgettable</p>
        </div>
        
        <div class="contact-content">
            <!-- Contact Information -->
            <div class="contact-info">
                <div class="info-header">
                    <h3>Contact Information</h3>
                    <p>Reach out to us anytime</p>
                </div>
                
                <div class="contact-items">
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="contact-details">
                            <h4>Location</h4>
                            <p>Ocean View Beach Resort<br>
                            Mirissa Beach Road<br>
                            Mirissa 81740, Sri Lanka</p>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div class="contact-details">
                            <h4>Phone</h4>
                            <p><a href="tel:+94771234567">+94 77 123 4567</a><br>
                            <a href="tel:+94412258888">+94 41 225 8888</a></p>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="contact-details">
                            <h4>Email</h4>
                            <p><a href="mailto:info@oceanviewresort.lk">info@oceanviewresort.lk</a><br>
                            <a href="mailto:reservations@oceanviewresort.lk">reservations@oceanviewresort.lk</a></p>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="contact-details">
                            <h4>Office Hours</h4>
                            <p>Reception: 24/7<br>
                            Tours: 6:00 AM - 8:00 PM</p>
                        </div>
                    </div>
                </div>
                
                <!-- Social Media -->
                <div class="social-section">
                    <h4>Follow Us</h4>
                    <div class="social-links">
                        <a href="#" class="social-link facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-link instagram">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="social-link twitter">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="social-link whatsapp">
                            <i class="fab fa-whatsapp"></i>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Contact Form -->
            <div class="contact-form-container">
                <div class="form-header">
                    <h3>Send us a Message</h3>
                    <p>We'll get back to you within 24 hours</p>
                </div>
                
                <form id="contactForm" class="contact-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="name">Full Name *</label>
                            <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email Address *</label>
                            <input type="email" id="email" name="email" placeholder="Enter your email" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone" placeholder="+94 77 123 4567">
                        </div>
                        <div class="form-group">
                            <label for="subject">Subject *</label>
                            <select id="subject" name="subject" required>
                                <option value="">Choose a subject</option>
                                <option value="reservation">🏨 Reservation Inquiry</option>
                                <option value="whale-watching">🐋 Whale Watching</option>
                                <option value="activities">🏄 Water Activities</option>
                                <option value="dining">🍽️ Dining Options</option>
                                <option value="transport">🚗 Transportation</option>
                                <option value="general">💬 General Information</option>
                                <option value="feedback">⭐ Feedback</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group full-width">
                        <label for="message">Message *</label>
                        <textarea id="message" name="message" placeholder="Tell us how we can help you..." rows="4" required></textarea>
                        <div class="char-counter">
                            <span id="charCount">0</span>/500 characters
                        </div>
                    </div>
                    
                    <div class="form-group checkbox-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="newsletter" id="newsletter">
                            <span class="checkmark"></span>
                            Subscribe to our newsletter for special offers and updates
                        </label>
                    </div>
                    
                    <div class="form-actions">
                        <button type="reset" class="reset-btn">
                            <i class="fas fa-undo"></i>
                            Clear Form
                        </button>
                        <button type="submit" class="submit-btn">
                            <i class="fas fa-paper-plane"></i>
                            Send Message
                        </button>
                    </div>
                </form>
                
                <!-- Success Message -->
                <div id="successMessage" class="success-message" style="display: none;">
                    <div class="success-content">
                        <i class="fas fa-check-circle"></i>
                        <h4>Message Sent Successfully!</h4>
                        <p>Thank you for contacting us. We'll get back to you within 24 hours.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const contactForm = document.getElementById('contactForm');
    const messageTextarea = document.getElementById('message');
    const charCount = document.getElementById('charCount');
    const successMessage = document.getElementById('successMessage');
    const maxChars = 500;
    
    // Character counter for message textarea
    messageTextarea.addEventListener('input', function() {
        const currentLength = this.value.length;
        charCount.textContent = currentLength;
        
        if (currentLength > maxChars) {
            charCount.style.color = '#ef4444';
            this.value = this.value.substring(0, maxChars);
            charCount.textContent = maxChars;
        } else if (currentLength > maxChars * 0.8) {
            charCount.style.color = '#f59e0b';
        } else {
            charCount.style.color = '#64748b';
        }
    });
    
    // Form submission
    contactForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Show loading state
        const submitBtn = this.querySelector('.submit-btn');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
        submitBtn.disabled = true;
        
        // Simulate form submission (replace with actual submission logic)
        setTimeout(() => {
            // Hide form and show success message
            contactForm.style.display = 'none';
            successMessage.style.display = 'block';
            
            // Reset form after showing success
            setTimeout(() => {
                contactForm.reset();
                charCount.textContent = '0';
                charCount.style.color = '#64748b';
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
                contactForm.style.display = 'block';
                successMessage.style.display = 'none';
            }, 3000);
        }, 2000);
    });
    
    // Reset button functionality
    const resetBtn = contactForm.querySelector('.reset-btn');
    resetBtn.addEventListener('click', function() {
        charCount.textContent = '0';
        charCount.style.color = '#64748b';
    });
    
    // Input validation and styling
    const inputs = contactForm.querySelectorAll('input, select, textarea');
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            if (this.hasAttribute('required') && !this.value.trim()) {
                this.classList.add('error');
            } else {
                this.classList.remove('error');
            }
        });
        
        input.addEventListener('focus', function() {
            this.classList.remove('error');
        });
    });
});
</script>
