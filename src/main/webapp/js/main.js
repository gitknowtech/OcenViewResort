
console.log("main.js loaded successfully!");

$(document).ready(function() {
    console.log("jQuery ready function called");
    
    // Load home page by default
    console.log("Loading home page...");
    loadPage('home');
    
    // Navigation click handler - Use event delegation for better reliability
    $(document).on('click', '.nav-link, [data-page]', function(e) {
        e.preventDefault();
        const page = $(this).data('page') || $(this).attr('data-page');
        console.log("Navigation clicked, page:", page);
        if (page) {
            loadPage(page);
            updateNavigation(page);
        }
    });
    
    // Mobile menu toggle
    $(document).on('click', '#hamburger', function() {
        $('#nav-menu').toggleClass('active');
    });
    
    // Close mobile menu when clicking on a link
    $(document).on('click', '.nav-link', function() {
        $('#nav-menu').removeClass('active');
    });
});

// Load page content via AJAX
function loadPage(pageName) {
    console.log("loadPage function called with:", pageName);
    
    // Validate page name
    const validPages = ['home', 'accommodation', 'gallery', 'contact', 'reservation'];
    if (!validPages.includes(pageName)) {
        console.error("Invalid page name:", pageName);
        pageName = 'home';
    }
    
    // Show loading spinner
    $('#loading').show();
    $('#main-content').fadeOut(200);
    
    // Load page content
    $.ajax({
        url: `pages/${pageName}.jsp`,
        type: 'GET',
        cache: false, // Prevent caching issues
        beforeSend: function() {
            console.log("AJAX request starting for:", `pages/${pageName}.jsp`);
        },
        success: function(data) {
            console.log("AJAX success, data received:", data.length, "characters");
            $('#main-content').html(data).fadeIn(200);
            $('#loading').hide();
            
            // Initialize page-specific functionality
            initPageFunctions(pageName);
            
            // Update browser history
            if (window.history && window.history.pushState) {
                window.history.pushState({page: pageName}, '', `#${pageName}`);
            }
            
            // Scroll to top
            window.scrollTo({ top: 0, behavior: 'smooth' });
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error:", status, error);
            console.error("Response:", xhr.responseText);
            console.error("Status Code:", xhr.status);
            $('#loading').hide();
            
            let errorMessage = "Sorry, the requested page could not be loaded.";
            if (xhr.status === 404) {
                errorMessage = "Page not found. Please check if the JSP file exists.";
            } else if (xhr.status === 500) {
                errorMessage = "Server error. Please check your JSP file for syntax errors.";
            }
            
            $('#main-content').html(`
                <div class="error-message" style="text-align: center; padding: 50px; color: #721c24; background: #f8d7da; border: 1px solid #f5c6cb; border-radius: 5px; margin: 20px;">
                    <h2>Oops! Something went wrong</h2>
                    <p>${errorMessage}</p>
                    <p><strong>Error Details:</strong> ${error} (Status: ${xhr.status})</p>
                    <button onclick="loadPage('home')" class="cta-button" style="background: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; margin-top: 15px;">Go Home</button>
                </div>
            `).fadeIn(200);
        }
    });
}

// Handle browser back/forward buttons
window.addEventListener('popstate', function(event) {
    if (event.state && event.state.page) {
        loadPage(event.state.page);
        updateNavigation(event.state.page);
    }
});

// Update navigation active state
function updateNavigation(activePage) {
    console.log("Updating navigation for:", activePage);
    $('.nav-link').removeClass('active');
    $(`.nav-link[data-page="${activePage}"]`).addClass('active');
    
    // Update page title
    const pageTitle = activePage.charAt(0).toUpperCase() + activePage.slice(1);
    document.title = `Hotel Booking - ${pageTitle}`;
}

// Initialize page-specific functions
function initPageFunctions(pageName) {
    console.log("Initializing functions for page:", pageName);
    
    // Remove any existing event listeners to prevent duplicates
    $('.cta-button, .book-btn, .gallery-filter, .gallery-item img').off();
    
    switch(pageName) {
        case 'home':
            initHomePageFunctions();
            break;
        case 'accommodation':
            initAccommodationFunctions();
            break;
        case 'gallery':
            initGalleryFunctions();
            break;
        case 'contact':
            initContactFunctions();
            break;
        case 'reservation':
            initReservationFunctions();
            break;
    }
}

// Home page functions
function initHomePageFunctions() {
    console.log("Initializing home page functions");
    
    // Use event delegation for dynamically loaded content
    $(document).off('click.home').on('click.home', '.cta-button', function(e) {
        e.preventDefault();
        const page = $(this).data('page') || $(this).attr('data-page');
        console.log("CTA button clicked, page:", page);
        if (page) {
            loadPage(page);
            updateNavigation(page);
        }
    });
    
    // Hero slider or carousel initialization (if you have one)
    if ($('.hero-slider').length) {
        // Initialize your slider here
    }
}

// Accommodation page functions
function initAccommodationFunctions() {
    console.log("Initializing accommodation page functions");
    
    $(document).off('click.accommodation').on('click.accommodation', '.book-btn', function(e) {
        e.preventDefault();
        const roomType = $(this).data('room');
        console.log("Book button clicked, room:", roomType);
        
        loadPage('reservation');
        updateNavigation('reservation');
        
        // Pre-select room type after page loads
        setTimeout(() => {
            if ($(`select[name="roomType"]`).length) {
                $(`select[name="roomType"] option[value="${roomType}"]`).prop('selected', true);
            }
        }, 500);
    });
}

// Gallery functions
function initGalleryFunctions() {
    console.log("Initializing gallery page functions");
    
    // Gallery filter
    $(document).off('click.gallery-filter').on('click.gallery-filter', '.gallery-filter', function(e) {
        e.preventDefault();
        $('.gallery-filter').removeClass('active');
        $(this).addClass('active');
        
        const filter = $(this).data('filter');
        console.log("Gallery filter clicked:", filter);
        
        if (filter === 'all') {
            $('.gallery-item').fadeIn(300);
        } else {
            $('.gallery-item').fadeOut(300);
            $(`.gallery-item[data-category="${filter}"]`).fadeIn(300);
        }
    });
    
    // Gallery lightbox
    $(document).off('click.gallery-lightbox').on('click.gallery-lightbox', '.gallery-item img', function(e) {
        e.preventDefault();
        const src = $(this).attr('src');
        const alt = $(this).attr('alt') || 'Gallery Image';
        
        const lightbox = $(`
            <div class="lightbox" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.9); z-index: 9999; display: flex; align-items: center; justify-content: center;">
                <div class="lightbox-content" style="position: relative; max-width: 90%; max-height: 90%;">
                    <span class="close" style="position: absolute; top: -40px; right: 0; color: white; font-size: 30px; cursor: pointer;">&times;</span>
                    <img src="${src}" alt="${alt}" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                </div>
            </div>
        `);
        
        $('body').append(lightbox);
        
        $('.close, .lightbox').click(function(e) {
            if (e.target === this) {
                $('.lightbox').fadeOut(200, function() {
                    $(this).remove();
                });
            }
        });
        
        // Close on escape key
        $(document).on('keyup.lightbox', function(e) {
            if (e.keyCode === 27) {
                $('.lightbox').fadeOut(200, function() {
                    $(this).remove();
                });
                $(document).off('keyup.lightbox');
            }
        });
    });
}

// Contact form functions
function initContactFunctions() {
    console.log("Initializing contact page functions");
    
    $(document).off('submit.contact').on('submit.contact', '#contactForm', function(e) {
        e.preventDefault();
        
        // Validate form
        let isValid = true;
        $(this).find('input[required], textarea[required], select[required]').each(function() {
            if (!$(this).val().trim()) {
                $(this).addClass('error');
                isValid = false;
            } else {
                $(this).removeClass('error');
            }
        });
        
        if (!isValid) {
            alert('Please fill in all required fields.');
            return;
        }
        
        // Get form data
        const formData = {
            name: $('input[name="name"]').val(),
            email: $('input[name="email"]').val(),
            phone: $('input[name="phone"]').val(),
            subject: $('select[name="subject"]').val(),
            message: $('textarea[name="message"]').val()
        };
        
        console.log("Contact form submitted:", formData);
        
        // Here you would normally send to server via AJAX
        // For now, just show success message
        alert('Thank you for your message! We will get back to you soon.');
        $('#contactForm')[0].reset();
    });
}

// Reservation form functions
function initReservationFunctions() {
    console.log("Initializing reservation page functions");
    
    // Set minimum date to today
    const today = new Date().toISOString().split('T')[0];
    $('input[name="checkInDate"]').attr('min', today);
    $('input[name="checkOutDate"]').attr('min', today);
    
    // Update checkout minimum date when checkin changes
    $(document).off('change.checkin').on('change.checkin', 'input[name="checkInDate"]', function() {
        const checkInDate = new Date($(this).val());
        checkInDate.setDate(checkInDate.getDate() + 1);
        const minCheckOut = checkInDate.toISOString().split('T')[0];
        $('input[name="checkOutDate"]').attr('min', minCheckOut);
        
        // Clear checkout date if it's before new minimum
        const checkOutValue = $('input[name="checkOutDate"]').val();
        if (checkOutValue && checkOutValue <= $(this).val()) {
            $('input[name="checkOutDate"]').val('');
        }
    });
    
    // Room type change handler
    $(document).off('change.roomtype').on('change.roomtype', 'select[name="roomType"]', function() {
        calculateTotal();
    });
    
    // Date change handlers
    $(document).off('change.dates').on('change.dates', 'input[name="checkInDate"], input[name="checkOutDate"]', function() {
        calculateTotal();
    });
}

// Reservation form navigation
function nextStep(step) {
    console.log("Moving to step:", step);
    if (validateCurrentStep(step - 1)) {
        $(`.form-step`).hide();
        $(`#step${step}`).fadeIn(300);
        
        if (step === 3) {
            updateBookingSummary();
        }
    }
}

function prevStep(step) {
    console.log("Going back to step:", step);
    $(`.form-step`).hide();
    $(`#step${step}`).fadeIn(300);
}

function validateCurrentStep(step) {
    console.log("Validating step:", step);
    let isValid = true;
    const currentStep = $(`#step${step}`);
    
    currentStep.find('input[required], select[required], textarea[required]').each(function() {
        const value = $(this).val();
        if (!value || value.trim() === '') {
            $(this).addClass('error');
            isValid = false;
        } else {
            $(this).removeClass('error');
        }
    });
    
    // Additional validation for email
    const email = currentStep.find('input[type="email"]');
    if (email.length && email.val()) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email.val())) {
            email.addClass('error');
            isValid = false;
        }
    }
    
    if (!isValid) {
        alert('Please fill in all required fields correctly.');
    }
    
    return isValid;
}

function updateBookingSummary() {
    console.log("Updating booking summary");
    $('#summaryName').text($('input[name="guestName"]').val() || 'Not specified');
    $('#summaryEmail').text($('input[name="guestEmail"]').val() || 'Not specified');
    $('#summaryRoom').text($('select[name="roomType"] option:selected').text() || 'Not selected');
    $('#summaryCheckIn').text($('input[name="checkInDate"]').val() || 'Not selected');
    $('#summaryCheckOut').text($('input[name="checkOutDate"]').val() || 'Not selected');
    
    calculateTotal();
}

function calculateTotal() {
    const checkInValue = $('input[name="checkInDate"]').val();
    const checkOutValue = $('input[name="checkOutDate"]').val();
    const roomPrice = parseFloat($('select[name="roomType"] option:selected').data('price')) || 0;
    
    console.log("Calculating total - CheckIn:", checkInValue, "CheckOut:", checkOutValue, "Price:", roomPrice);
    
    if (checkInValue && checkOutValue && roomPrice > 0) {
        const checkIn = new Date(checkInValue);
        const checkOut = new Date(checkOutValue);
        
        if (checkOut > checkIn) {
            const nights = Math.ceil((checkOut - checkIn) / (1000 * 60 * 60 * 24));
            const subtotal = nights * roomPrice;
            const tax = subtotal * 0.1; // 10% tax
            const total = subtotal + tax;
            
            $('#summaryNights').text(nights);
            $('#summarySubtotal').text(`$${subtotal.toFixed(2)}`);
            $('#summaryTax').text(`$${tax.toFixed(2)}`);
            $('#summaryTotal').text(`$${total.toFixed(2)}`);
        }
    }
}

// Form submission
$(document).on('submit', '#reservationForm', function(e) {
    e.preventDefault();
    console.log("Reservation form submitted");
    
    // Validate all steps
    let allValid = true;
    for (let i = 1; i <= 2; i++) {
        if (!validateCurrentStep(i)) {
            allValid = false;
            break;
        }
    }
    
    if (!allValid) {
        alert('Please complete all required fields in previous steps.');
        return;
    }
    
    // Collect all form data
    const formData = new FormData(this);
    const reservationData = {};
    for (let [key, value] of formData.entries()) {
        reservationData[key] = value;
    }
    
    console.log("Reservation data:", reservationData);
    
    // Here you would normally send to server
    // For demo purposes, just show success message
    alert('Reservation submitted successfully! We will contact you shortly to confirm your booking.');
    
    // Reset form and go back to step 1
    this.reset();
    $('.form-step').hide();
    $('#step1').fadeIn(300);
});

// Utility function to handle errors gracefully
function handleError(error, context) {
    console.error(`Error in ${context}:`, error);
    // You could send error reports to your server here
}

// Initialize error handling
window.addEventListener('error', function(e) {
    handleError(e.error, 'Global error handler');
});

// Add loading states for better UX
function showLoading(element) {
    if (element) {
        element.addClass('loading').prop('disabled', true);
    }
}

function hideLoading(element) {
    if (element) {
        element.removeClass('loading').prop('disabled', false);
    }
}
