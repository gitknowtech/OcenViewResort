console.log("main.js loaded successfully!");

// Global variables for user state
let currentUser = null;
let isUserLoggedIn = false;

$(document).ready(function() {
    console.log("jQuery ready function called");
    
    // Check user status first, then load home page
    checkUserStatusOnLoad();
    
    // Navigation click handler - EXCLUDE signup form links to prevent redirect
    $(document).on('click', '.navbar-link, [data-page]:not(.signup-form [data-page]):not(.signup-form a[data-page])', function(e) {
        e.preventDefault();
        const page = $(this).data('page') || $(this).attr('data-page');
        console.log("Navigation clicked, page:", page);
        if (page) {
            loadPage(page);
            updateNavigation(page.split('/')[0]); // Handle sub-pages
        }
    });
    
    // Dropdown link handler - FIXED: Use correct dropdown classes
    $(document).on('click', '.navbar-dropdown-link', function(e) {
        e.preventDefault();
        const page = $(this).data('page');
        console.log("Dropdown link clicked, page:", page);
        if (page) {
            loadPage(page);
            updateNavigation(page.split('/')[0]);
        }
        
        // Close mobile menu
        $('.navbar-menu').removeClass('active');
        $('.navbar-hamburger').removeClass('active');
    });
    
    // Mobile menu toggle - FIXED: Use correct hamburger class
    $(document).on('click', '.navbar-hamburger', function() {
        $(this).toggleClass('active');
        $('.navbar-menu').toggleClass('active');
    });
    
    // Close mobile menu when clicking on a link
    $(document).on('click', '.navbar-link', function() {
        $('.navbar-menu').removeClass('active');
        $('.navbar-hamburger').removeClass('active');
    });
    
    // Close mobile menu when clicking outside
    $(document).click(function(e) {
        if (!$(e.target).closest('.navbar').length) {
            $('.navbar-menu').removeClass('active');
            $('.navbar-hamburger').removeClass('active');
        }
    });
});

// Check user status on page load
function checkUserStatusOnLoad() {
    console.log('🔍 Checking user status on page load...');
    
    $.ajax({
        url: 'checkUser',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log('📊 User status response:', data);
            
            if (data.loggedIn) {
                currentUser = data.user;
                isUserLoggedIn = true;
                updateNavbarForLoggedInUser(data.user);
                
                if (data.autoLogin) {
                    showMessage('🎉 Welcome back, ' + data.user.name + '! Auto-logged in.', 'info');
                }
            } else {
                currentUser = null;
                isUserLoggedIn = false;
                updateNavbarForLoggedOutUser();
            }
            
            // Load home page after user status check
            loadPage('home');
        },
        error: function(xhr, status, error) {
            console.error('❌ Error checking user status:', error);
            currentUser = null;
            isUserLoggedIn = false;
            updateNavbarForLoggedOutUser();
            loadPage('home');
        }
    });
}

// Update navbar for logged in user
function updateNavbarForLoggedInUser(user) {
    console.log('✅ Updating navbar for logged in user:', user);
    
    const loginSection = $('#navbarLoginSection');
    const userAvatar = $('#navbarUserAvatar');
    const userName = $('#navbarUserName');
    const userEmail = $('#navbarUserEmail');
    const dropdownName = $('#navbarUserDropdownName');
    const dropdownEmail = $('#navbarUserDropdownEmail');
    
    if (loginSection.length && userAvatar.length && userName.length && userEmail.length) {
        // Switch to logged in state
        loginSection.removeClass('logged-out').addClass('logged-in');
        
        // Update user info
        const displayName = user.name || user.email.split('@')[0];
        const firstLetter = displayName.charAt(0).toUpperCase();
        
        userAvatar.text(firstLetter);
        userName.text(displayName);
        userEmail.text(user.email);
        
        if (dropdownName.length) dropdownName.text(displayName);
        if (dropdownEmail.length) dropdownEmail.text(user.email);
        
        console.log('✅ Navbar updated for user:', displayName);
    }
}

// Update navbar for logged out user
function updateNavbarForLoggedOutUser() {
    console.log('📝 Updating navbar for logged out user');
    
    const loginSection = $('#navbarLoginSection');
    if (loginSection.length) {
        loginSection.removeClass('logged-in').addClass('logged-out');
    }
}

// Global logout function
window.logoutUser = function() {
    if (!confirm('Are you sure you want to logout?')) return;
    
    console.log('👋 Logging out user...');
    
    $.ajax({
        url: 'logout',
        type: 'POST',
        dataType: 'json',
        success: function(data) {
            if (data.success) {
                console.log('✅ Logout successful');
                
                // Update global state
                currentUser = null;
                isUserLoggedIn = false;
                
                // Update navbar
                updateNavbarForLoggedOutUser();
                
                // Show success message
                showMessage('👋 ' + data.message, 'info');
                
                // Redirect to home page
                loadPage('home');
            } else {
                console.error('❌ Logout failed:', data.message);
                showMessage('❌ Error during logout', 'error');
            }
        },
        error: function(xhr, status, error) {
            console.error('❌ Logout error:', error);
            showMessage('⚠️ Network error during logout', 'error');
        }
    });
};

// Load page content via AJAX - IMPROVED ERROR HANDLING
function loadPage(pageName) {
    console.log("loadPage function called with:", pageName);
    
    // Handle sub-pages (e.g., events/whale-watching)
    let filePath = pageName;
    let mainPage = pageName;
    
    if (pageName.includes('/')) {
        const parts = pageName.split('/');
        mainPage = parts[0];
        filePath = pageName; // Keep the original path
    }
    
    // Validate main page name
    const validPages = ['home', 'accommodation', 'events', 'gallery', 'contact', 'reservation', 'login'];
    if (!validPages.includes(mainPage)) {
        console.error("Invalid page name:", mainPage);
        filePath = 'home';
        mainPage = 'home';
    }
    
    // Show loading spinner
    $('#loading').show();
    $('#main-content').fadeOut(200);
    
    // Load page content
    $.ajax({
        url: `pages/${filePath}.jsp`,
        type: 'GET',
        cache: false,
        timeout: 10000, // 10 second timeout
        beforeSend: function() {
            console.log("AJAX request starting for:", `pages/${filePath}.jsp`);
        },
        success: function(data) {
            console.log("AJAX success, data received:", data.length, "characters");
            
            // Check if data is actually HTML content
            if (data && data.trim().length > 0) {
                $('#main-content').html(data).fadeIn(200);
                $('#loading').hide();
                
                // Initialize page-specific functionality
                initPageFunctions(mainPage, pageName);
                
                // Update browser history
                if (window.history && window.history.pushState) {
                    window.history.pushState({page: pageName}, '', `#${pageName}`);
                }
                
                // Scroll to top
                window.scrollTo({ top: 0, behavior: 'smooth' });
            } else {
                throw new Error('Empty response received');
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error Details:");
            console.error("- Status:", status);
            console.error("- Error:", error);
            console.error("- HTTP Status:", xhr.status);
            console.error("- Response Text:", xhr.responseText);
            console.error("- Requested URL:", `pages/${filePath}.jsp`);
            
            $('#loading').hide();
            
            let errorMessage = "Sorry, the requested page could not be loaded.";
            let errorDetails = "";
            
            switch(xhr.status) {
                case 404:
                    errorMessage = "Page not found.";
                    errorDetails = `The file 'pages/${filePath}.jsp' does not exist.`;
                    break;
                case 500:
                    errorMessage = "Server error occurred.";
                    errorDetails = "Please check your JSP file for syntax errors.";
                    break;
                case 0:
                    errorMessage = "Network error.";
                    errorDetails = "Please check your internet connection.";
                    break;
                default:
                    errorDetails = `HTTP ${xhr.status}: ${error}`;
            }
            
            $('#main-content').html(`
                <div class="error-container">
                    <div class="error-content">
                        <i class="fas fa-exclamation-triangle"></i>
                        <h2>Oops! Something went wrong</h2>
                        <p><strong>${errorMessage}</strong></p>
                        <p>${errorDetails}</p>
                        <div class="error-actions">
                            <button onclick="loadPage('home')" class="btn-primary">Go Home</button>
                            <button onclick="location.reload()" class="btn-secondary">Reload Page</button>
                        </div>
                        <details class="error-details">
                            <summary>Technical Details</summary>
                            <p><strong>Requested URL:</strong> pages/${filePath}.jsp</p>
                            <p><strong>Status Code:</strong> ${xhr.status}</p>
                            <p><strong>Error:</strong> ${error}</p>
                            <p><strong>Response:</strong> ${xhr.responseText || 'No response'}</p>
                        </details>
                    </div>
                </div>
            `).fadeIn(200);
        }
    });
}

// Handle browser back/forward buttons
window.addEventListener('popstate', function(event) {
    if (event.state && event.state.page) {
        loadPage(event.state.page);
        updateNavigation(event.state.page.split('/')[0]);
    }
});

// Update navigation active state - FIXED: Use correct navbar classes
function updateNavigation(activePage) {
    console.log("Updating navigation for:", activePage);
    $('.navbar-link').removeClass('navbar-link-active');
    $(`.navbar-link[data-page="${activePage}"]`).addClass('navbar-link-active');
    
    // Update page title
    const pageTitle = activePage.charAt(0).toUpperCase() + activePage.slice(1);
    document.title = `Ocean View Beach Resort - ${pageTitle}`;
}

// Initialize page-specific functions
function initPageFunctions(pageName, fullPageName) {
    console.log("Initializing functions for page:", pageName, "Full:", fullPageName);
    
    // Remove any existing event listeners to prevent duplicates
    $('.cta-button, .book-btn, .gallery-filter, .gallery-item img, .event-book-btn').off();
    
    switch(pageName) {
        case 'home':
            initHomePageFunctions();
            break;
        case 'accommodation':
            initAccommodationFunctions();
            break;
        case 'events':
            initEventsFunctions(fullPageName);
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
        case 'login':
            initLoginFunctions();
            break;
    }
}

// FIXED: Login page functions - DO NOT HANDLE FORM SUBMISSION
function initLoginFunctions() {
    console.log("Initializing login page functions - DELEGATED VERSION");
    
    // Handle signup form login links separately (prevent main navigation interference)
    $(document).off('click.signup-login').on('click.signup-login', '.signup-form [data-page], .signup-form a[data-page]', function(e) {
        e.preventDefault();
        e.stopPropagation(); // Prevent main navigation handler
        const page = $(this).data('page') || $(this).attr('data-page');
        console.log("Signup form login link clicked, page:", page);
        if (page) {
            loadPage(page);
            updateNavigation(page.split('/')[0]);
        }
    });
    
    // DO NOT HANDLE LOGIN FORM - Let login page script handle it
    console.log("✅ Login functions initialized - form handling delegated to login page");
}

// Message function
function showMessage(text, type) {
    console.log(`${type.toUpperCase()}: ${text}`);
    
    // Remove existing messages
    $('.main-message').remove();
    
    // Create message element
    const messageClass = type === 'success' ? 'success' : type === 'error' ? 'error' : 'info';
    const bgColor = type === 'success' ? '#10b981' : type === 'error' ? '#ef4444' : '#3b82f6';
    
    const msg = $(`
        <div class="main-message ${messageClass}" style="
            position: fixed; top: 20px; right: 20px; z-index: 9999;
            padding: 15px 20px; border-radius: 8px; color: white; font-weight: bold;
            background: ${bgColor}; box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            animation: slideIn 0.3s ease-out; min-width: 250px;
        ">${text}</div>
    `);
    
    $('body').append(msg);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        msg.fadeOut(300, function() {
            $(this).remove();
        });
    }, 5000);
    
    // Click to dismiss
    msg.click(function() {
        $(this).fadeOut(300, function() {
            $(this).remove();
        });
    });
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
            updateNavigation(page.split('/')[0]);
        }
    });
    
    // Activity cards click handler
    $(document).off('click.activity').on('click.activity', '.activity-card', function(e) {
        e.preventDefault();
        const activity = $(this).data('activity');
        if (activity) {
            loadPage(`events/${activity}`);
            updateNavigation('events');
        }
    });
}

// Events page functions
function initEventsFunctions(fullPageName) {
    console.log("Initializing events page functions for:", fullPageName);
    
    // Event booking button handler
    $(document).off('click.events').on('click.events', '.event-book-btn, .book-event-btn', function(e) {
        e.preventDefault();
        const eventType = $(this).data('event') || $(this).data('activity');
        console.log("Event book button clicked, event:", eventType);
        
        loadPage('reservation');
        updateNavigation('reservation');
        
        // Pre-select event type after page loads
        setTimeout(() => {
            if ($(`select[name="eventType"]`).length) {
                $(`select[name="eventType"] option[value="${eventType}"]`).prop('selected', true);
            }
        }, 500);
    });
    
    // Event filter functionality
    $(document).off('click.event-filter').on('click.event-filter', '.event-filter', function(e) {
        e.preventDefault();
        $('.event-filter').removeClass('active');
        $(this).addClass('active');
        
        const filter = $(this).data('filter');
        console.log("Event filter clicked:", filter);
        
        if (filter === 'all') {
            $('.event-card').fadeIn(300);
        } else {
            $('.event-card').fadeOut(300);
            $(`.event-card[data-category="${filter}"]`).fadeIn(300);
        }
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
            showMessage('Please fill in all required fields.', 'error');
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
        showMessage('Thank you for your message! We will get back to you soon.', 'success');
        $('#contactForm')[0].reset();
    });
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
}

// Make functions globally accessible
window.loadPage = loadPage;
window.updateNavbarForLoggedInUser = updateNavbarForLoggedInUser;
window.updateNavbarForLoggedOutUser = updateNavbarForLoggedOutUser;
window.showMessage = showMessage;

// Add slideIn animation CSS if not present
if (!$('style[data-main-animations]').length) {
    $('head').append(`
        <style data-main-animations>
            @keyframes slideIn {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
        </style>
    `);
}

// Add error container styles if not already present
if (!$('style[data-error-styles]').length) {
    $('head').append(`
        <style data-error-styles>
            .error-container {
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 60vh;
                padding: 40px 20px;
            }
            
            .error-content {
                text-align: center;
                max-width: 600px;
                padding: 40px;
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }
            
            .error-content i {
                font-size: 4rem;
                color: #ff6b6b;
                margin-bottom: 20px;
            }
            
            .error-content h2 {
                color: #333;
                margin-bottom: 15px;
                font-size: 1.8rem;
            }
            
            .error-content p {
                color: #666;
                margin-bottom: 15px;
                line-height: 1.6;
            }
            
            .error-actions {
                margin: 20px 0;
            }
            
            .btn-primary, .btn-secondary {
                display: inline-block;
                padding: 12px 24px;
                margin: 5px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s ease;
            }
            
            .btn-primary {
                background: #003366;
                color: white;
            }
            
            .btn-primary:hover {
                background: #0066cc;
                transform: translateY(-2px);
            }
            
            .btn-secondary {
                background: #6c757d;
                color: white;
            }
            
            .btn-secondary:hover {
                background: #5a6268;
                transform: translateY(-2px);
            }
            
            .error-details {
                margin-top: 20px;
                text-align: left;
                background: #f8f9fa;
                padding: 15px;
                border-radius: 8px;
                border: 1px solid #e9ecef;
            }
            
            .error-details summary {
                cursor: pointer;
                font-weight: bold;
                margin-bottom: 10px;
            }
            
            .error-details p {
                margin: 5px 0;
                font-family: monospace;
                font-size: 0.9rem;
            }
        </style>
    `);
}

console.log("✅ Enhanced main.js loaded with FIXED login delegation!");
