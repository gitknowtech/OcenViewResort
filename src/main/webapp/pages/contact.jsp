<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Contact Section -->
<section class="section active">
    <div class="container">
        <h2 class="section-title">CONTACT US</h2>
        <div class="contact-content">
            <div class="contact-info">
                <div class="contact-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <div>
                        <h4>Address</h4>
                        <p>Ocean View Beach Resort<br>
                        Kalpitiya Peninsula<br>
                        North Western Province<br>
                        Sri Lanka</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-phone"></i>
                    <div>
                        <h4>Phone</h4>
                        <p>+94 77 123 4567<br>
                        +94 31 225 8888</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-envelope"></i>
                    <div>
                        <h4>Email</h4>
                        <p>info@oceanviewresort.lk<br>
                        reservations@oceanviewresort.lk</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-clock"></i>
                    <div>
                        <h4>Office Hours</h4>
                        <p>Monday - Sunday<br>
                        24/7 Reception</p>
                    </div>
                </div>
            </div>
            <div class="contact-form">
                <h3>Send us a Message</h3>
                <form id="contactForm">
                    <div class="form-group">
                        <input type="text" name="name" placeholder="Your Name" required>
                    </div>
                    <div class="form-group">
                        <input type="email" name="email" placeholder="Your Email" required>
                    </div>
                    <div class="form-group">
                        <input type="tel" name="phone" placeholder="Your Phone">
                    </div>
                    <div class="form-group">
                        <select name="subject" required>
                            <option value="">Select Subject</option>
                            <option value="reservation">Reservation Inquiry</option>
                            <option value="activities">Activities Information</option>
                            <option value="dining">Dining Options</option>
                            <option value="general">General Information</option>
                            <option value="feedback">Feedback</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <textarea name="message" placeholder="Your Message" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="submit-btn">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</section>
