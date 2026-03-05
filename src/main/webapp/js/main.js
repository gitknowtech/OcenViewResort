console.log("✅ main.js loaded successfully!");

let currentUser = null;
let isUserLoggedIn = false;
let isAdminLoggedIn = false;

$(document).ready(function() {
    console.log("✅ jQuery ready");
    checkUserStatusOnLoad();
    
    $(document).on('click', '.navbar-link, [data-page]:not(.signup-form [data-page])', function(e) {
        e.preventDefault();
        const page = $(this).data('page');
        if (page && page.trim()) {
            loadPage(page);
        }
    });
    
    $(document).on('click', '.navbar-dropdown-link', function(e) {
        e.preventDefault();
        const page = $(this).data('page');
        if (page && page.trim()) {
            loadPage(page);
        }
        $('.navbar-menu').removeClass('active');
        $('.navbar-hamburger').removeClass('active');
    });
    
    $(document).on('click', '.navbar-hamburger', function() {
        $(this).toggleClass('active');
        $('.navbar-menu').toggleClass('active');
    });
    
    $(document).on('click', '.navbar-link', function() {
        $('.navbar-menu').removeClass('active');
        $('.navbar-hamburger').removeClass('active');
    });
});




// In main.js, update checkUserStatusOnLoad():

function checkUserStatusOnLoad() {
    console.log('🔍 Checking user status...');
    $.ajax({
        url: 'checkUser',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log('📊 User status response:', data);
            
            if (data.loggedIn) {
                currentUser = data.user;
                isUserLoggedIn = true;
                
                // ✅ CHECK IF ADMIN - DIRECT REDIRECT
                if (data.user.isAdmin) {
                    console.log('🔐 Admin user detected - DIRECT REDIRECT');
                    isAdminLoggedIn = true;
                    
                    // ⚠️ DIRECT REDIRECT - NO NAVBAR UPDATE
                    console.log('🔄 Redirecting directly to admin-dashboard.jsp...');
                    window.location.href = 'admin-dashboard.jsp';
                    return; // Stop execution
                } else {
                    console.log('👤 Regular user detected');
                    updateNavbarForLoggedInUser(data.user);
                    loadPage('home');
                }
            } else {
                console.log('📝 No user logged in');
                updateNavbarForLoggedOutUser();
                loadPage('home');
            }
        },
        error: function(error) {
            console.error('❌ Error checking user status:', error);
            updateNavbarForLoggedOutUser();
            loadPage('home');
        }
    });
}




// ✅ UPDATE NAVBAR FOR ADMIN USER
function updateNavbarForAdminUser(user) {
    console.log('🔐 Updating navbar for admin user:', user);
    
    const displayName = user.firstName || user.username || 'Admin';
    const username = user.username || 'admin';
    
    $('#navbarLoginSection').removeClass('logged-out').addClass('logged-in');
    $('#navbarUserAvatar').text(displayName.charAt(0).toUpperCase());
    $('#navbarUserName').text(displayName);
    $('#navbarUserUsername').text('@' + username);
    $('#navbarUserEmail').text(user.email || 'admin@oceanview.lk');
    
    $('#navbarUserDropdownName').text(displayName);
    $('#navbarUserDropdownUsername').text('@' + username);
    $('#navbarUserDropdownEmail').text(user.email || 'admin@oceanview.lk');
    
    // Add admin indicator
    $('#navbarUserRole').html('<span style="color: #ef4444; font-weight: bold;">🔐 ADMIN</span>');
    
    console.log('✅ Admin navbar updated');
}

// ✅ UPDATE NAVBAR FOR REGULAR LOGGED IN USER
function updateNavbarForLoggedInUser(user) {
    console.log('👤 Updating navbar for regular user:', user);
    
    const firstName = user.firstName || '';
    const lastName = user.lastName || '';
    const displayName = (firstName + ' ' + lastName).trim() || user.username || user.email.split('@')[0];
    const username = user.username || user.email.split('@')[0];
    
    $('#navbarLoginSection').removeClass('logged-out').addClass('logged-in');
    $('#navbarUserAvatar').text(displayName.charAt(0).toUpperCase());
    $('#navbarUserName').text(displayName);
    $('#navbarUserUsername').text('@' + username);
    $('#navbarUserEmail').text(user.email);
    
    $('#navbarUserDropdownName').text(displayName);
    $('#navbarUserDropdownUsername').text('@' + username);
    $('#navbarUserDropdownEmail').text(user.email);
    
    console.log('✅ User navbar updated');
}

// ✅ UPDATE NAVBAR FOR LOGGED OUT USER
function updateNavbarForLoggedOutUser() {
    console.log('📝 Updating navbar for logged out user');
    
    $('#navbarLoginSection').removeClass('logged-in').addClass('logged-out');
    isUserLoggedIn = false;
    isAdminLoggedIn = false;
    currentUser = null;
}

// ✅ LOGOUT FUNCTION
window.logoutUser = function() {
    if (!confirm('Are you sure you want to logout?')) return;
    
    console.log('👋 Logging out user...');
    
    $.ajax({
        url: 'logout',
        type: 'POST',
        dataType: 'json',
        success: function(data) {
            console.log('✅ Logout successful:', data);
            updateNavbarForLoggedOutUser();
            showMessage('👋 Logged out successfully', 'info');
            
            // Redirect to home
            setTimeout(() => {
                window.location.href = 'index.jsp';
            }, 1000);
        },
        error: function(error) {
            console.error('❌ Logout error:', error);
            showMessage('⚠️ Error during logout', 'error');
        }
    });
};

// ✅ ADMIN LOGOUT FUNCTION
window.adminLogout = function() {
    if (!confirm('Are you sure you want to logout from admin panel?')) return;
    
    console.log('👋 Admin logging out...');
    
    $.ajax({
        url: 'logout',
        type: 'POST',
        dataType: 'json',
        success: function(data) {
            console.log('✅ Admin logout successful:', data);
            
            // Clear admin session
            isAdminLoggedIn = false;
            currentUser = null;
            
            // Redirect to login
            window.location.href = 'index.jsp';
        },
        error: function(error) {
            console.error('❌ Admin logout error:', error);
            window.location.href = 'index.jsp';
        }
    });
};

// ✅ MAIN LOAD FUNCTION - NO VALIDATION
function loadPage(pageName) {
    console.log("📄 Loading:", pageName);
    
    if (!pageName || !pageName.trim()) {
        pageName = 'home';
    }
    pageName = pageName.trim();
    
    let filePath = pageName;
    let mainPage = pageName;
    
    if (pageName.includes('/')) {
        mainPage = pageName.split('/')[0];
        filePath = pageName;
    }
    
    console.log("📁 Requesting: pages/" + filePath + ".jsp");
    
    $('#loading').show();
    $('#main-content').fadeOut(200);
    
    $.ajax({
        url: 'pages/' + filePath + '.jsp',
        type: 'GET',
        cache: false,
        timeout: 10000,
        success: function(data) {
            if (data && data.trim().length > 0) {
                $('#main-content').html(data).fadeIn(200);
                $('#loading').hide();
                
                initPageFunctions(mainPage, pageName);
                
                if (window.history && window.history.pushState) {
                    window.history.pushState({page: pageName}, '', '#' + pageName);
                }
                
                updateNavigation(mainPage);
                window.scrollTo(0, 0);
            }
        },
        error: function(xhr) {
            console.error("❌ Error:", xhr.status);
            $('#loading').hide();
            $('#main-content').html(`
                <div style="padding: 40px; text-align: center;">
                    <h2>❌ Page Not Found</h2>
                    <p>Could not load: pages/${filePath}.jsp</p>
                    <button onclick="loadPage('home')" style="padding: 10px 20px; background: #003366; color: white; border: none; border-radius: 5px; cursor: pointer;">
                        Go Home
                    </button>
                </div>
            `).fadeIn(200);
        }
    });
}

// ✅ SAFE NAVIGATION UPDATE
function updateNavigation(activePage) {
    if (!activePage || !activePage.trim()) {
        activePage = 'home';
    }
    
    activePage = activePage.trim().toLowerCase();
    
    $('.navbar-link').removeClass('navbar-link-active');
    $('.navbar-link[data-page="' + activePage + '"]').addClass('navbar-link-active');
    
    const pageTitle = activePage.charAt(0).toUpperCase() + activePage.slice(1);
    document.title = 'Ocean View Beach Resort - ' + pageTitle;
}

// ✅ INITIALIZE PAGE FUNCTIONS
function initPageFunctions(pageName, fullPageName) {
    console.log("⚙️ Init:", pageName);
    
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
        case 'profile':
            initProfileFunctions();
            break;
        case 'login':
            initLoginPageFunctions();
            break;
        default:
            console.log("⚠️ No init function for:", pageName);
    }
}

// ✅ SHOW MESSAGE FUNCTION
function showMessage(text, type) {
    console.log(`📢 ${type.toUpperCase()}: ${text}`);
    
    const bgColor = type === 'success' ? '#10b981' : 
                   type === 'error' ? '#ef4444' : 
                   type === 'warning' ? '#f59e0b' : '#3b82f6';
    
    const msg = $(`<div style="position: fixed; top: 20px; right: 20px; z-index: 9999; padding: 15px 20px; border-radius: 8px; color: white; font-weight: bold; background: ${bgColor}; box-shadow: 0 4px 12px rgba(0,0,0,0.15); min-width: 250px; animation: slideIn 0.3s ease-out;">${text}</div>`);
    $('body').append(msg);
    
    setTimeout(() => {
        msg.fadeOut(300, function() { 
            $(this).remove(); 
        });
    }, 5000);
}

// ✅ HOME PAGE FUNCTIONS
function initHomePageFunctions() {
    console.log("🏠 Initializing home page functions");
    
    $(document).off('click.home').on('click.home', '.cta-button', function(e) {
        e.preventDefault();
        const page = $(this).data('page');
        if (page) {
            console.log('🔗 CTA button clicked, loading:', page);
            loadPage(page);
        }
    });
}

// ✅ ACCOMMODATION PAGE FUNCTIONS
function initAccommodationFunctions() {
    console.log("🏨 Initializing accommodation page functions");
    
    $(document).off('click.accommodation').on('click.accommodation', '.book-btn', function(e) {
        e.preventDefault();
        
        // Check if user is logged in
        if (!isUserLoggedIn && !isAdminLoggedIn) {
            console.log('⚠️ User not logged in, redirecting to login');
            showMessage('Please login to make a booking', 'warning');
            setTimeout(() => {
                loadPage('login/login');
            }, 1000);
            return;
        }
        
        console.log('📦 Book button clicked');
        loadPage('reservation');
    });
}

// ✅ EVENTS PAGE FUNCTIONS
function initEventsFunctions(fullPageName) {
    console.log("🎉 Initializing events page functions");
    
    $(document).off('click.events').on('click.events', '.event-book-btn', function(e) {
        e.preventDefault();
        
        // Check if user is logged in
        if (!isUserLoggedIn && !isAdminLoggedIn) {
            console.log('⚠️ User not logged in, redirecting to login');
            showMessage('Please login to book an event', 'warning');
            setTimeout(() => {
                loadPage('login/login');
            }, 1000);
            return;
        }
        
        console.log('🎫 Event book button clicked');
        loadPage('reservation');
    });
}

// ✅ GALLERY PAGE FUNCTIONS
function initGalleryFunctions() {
    console.log("🖼️ Gallery initialized");
    
    $(document).off('click.gallery').on('click.gallery', '.gallery-item', function(e) {
        e.preventDefault();
        console.log('📸 Gallery item clicked');
    });
}

// ✅ CONTACT PAGE FUNCTIONS
function initContactFunctions() {
    console.log("📞 Contact initialized");
    
    $(document).off('submit.contact').on('submit.contact', '.contact-form', function(e) {
        e.preventDefault();
        console.log('📧 Contact form submitted');
    });
}

// ✅ RESERVATION PAGE FUNCTIONS
function initReservationFunctions() {
    console.log("📅 Reservation initialized");
    
    // Reservation page has its own script
    if (typeof initializeReservationPage === 'function') {
        initializeReservationPage();
    }
}

// ✅ PROFILE PAGE FUNCTIONS
function initProfileFunctions() {
    console.log("👤 Profile page initialized");
    
    $(document).off('click.profile').on('click.profile', '.edit-profile-btn', function(e) {
        e.preventDefault();
        console.log('✏️ Edit profile clicked');
    });
}

// ✅ LOGIN PAGE FUNCTIONS
function initLoginPageFunctions() {
    console.log("🔐 Login page initialized");
    
    // Login page has its own script
    if (typeof checkLoginPageUserStatus === 'function') {
        checkLoginPageUserStatus();
    }
}

// ✅ EXPORT GLOBAL FUNCTIONS
window.loadPage = loadPage;
window.updateNavbarForLoggedInUser = updateNavbarForLoggedInUser;
window.updateNavbarForAdminUser = updateNavbarForAdminUser;
window.updateNavbarForLoggedOutUser = updateNavbarForLoggedOutUser;
window.showMessage = showMessage;
window.checkUserStatusOnLoad = checkUserStatusOnLoad;
window.isUserLoggedIn = isUserLoggedIn;
window.isAdminLoggedIn = isAdminLoggedIn;
window.currentUser = currentUser;

console.log("✅ main.js fully loaded with admin support!");
