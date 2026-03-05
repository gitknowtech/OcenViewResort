console.log("✅ main.js loading...");

let currentUser = null;
let isUserLoggedIn = false;
let isAdminLoggedIn = false;

$(document).ready(function() {
    console.log("✅ jQuery ready");
    checkUserStatusOnLoad();
    
    // ✅ NAVBAR LINK CLICK HANDLERS
    $(document).on('click', '.navbar-link, [data-page]', function(e) {
        // Don't prevent default for external links
        if ($(this).attr('href') && $(this).attr('href').startsWith('http')) {
            return true;
        }
        
        e.preventDefault();
        const page = $(this).data('page');
        if (page && page.trim()) {
            loadPage(page);
        }
    });
    
    // ✅ DROPDOWN LINK HANDLERS
    $(document).on('click', '.navbar-dropdown-link', function(e) {
        e.preventDefault();
        const page = $(this).data('page');
        if (page && page.trim()) {
            loadPage(page);
        }
        $('.navbar-menu').removeClass('active');
        $('.navbar-hamburger').removeClass('active');
    });
    
    // ✅ HAMBURGER MENU TOGGLE
    $(document).on('click', '.navbar-hamburger', function() {
        $(this).toggleClass('active');
        $('.navbar-menu').toggleClass('active');
    });
    
    // ✅ CLOSE MENU ON LINK CLICK
    $(document).on('click', '.navbar-link', function() {
        $('.navbar-menu').removeClass('active');
        $('.navbar-hamburger').removeClass('active');
    });
});

// ✅✅✅ MAIN USER STATUS CHECK - WITH ADMIN/STAFF REDIRECT ✅✅✅
function checkUserStatusOnLoad() {
    console.log('\n╔═══════════════════════════════════════════╗');
    console.log('║  🔍 CHECKING USER STATUS ON PAGE LOAD    ║');
    console.log('╚═══════════════════════════════════════════╝\n');
    
    $.ajax({
        url: 'checkUser',
        type: 'GET',
        dataType: 'json',
        timeout: 5000,
        success: function(data) {
            console.log('📊 User status response:', data);
            console.log('   - loggedIn:', data.loggedIn);
            console.log('   - user:', data.user);
            
            if (data.loggedIn) {
                currentUser = data.user;
                isUserLoggedIn = true;
                
                console.log('\n✅ USER IS LOGGED IN');
                console.log('   - Username:', data.user.username || data.user.name);
                console.log('   - Email:', data.user.email);
                console.log('   - isAdmin:', data.user.isAdmin);
                console.log('   - Type:', typeof data.user.isAdmin);
                
                // ✅✅✅ CHECK IF ADMIN OR STAFF - IMMEDIATE REDIRECT ✅✅✅
                if (data.user.isAdmin === true || data.user.isAdmin == 1 || data.user.isAdmin === 1) {
                    console.log('\n🔐🔐🔐 ADMIN/STAFF DETECTED 🔐🔐🔐');
                    console.log('   - isAdmin value:', data.user.isAdmin);
                    console.log('⏰ REDIRECTING TO admin-dashboard.jsp NOW...\n');
                    
                    isAdminLoggedIn = true;
                    
                    // ✅ STOP ALL JQUERY HANDLERS
                    $(document).off();
                    
                    // ✅ MULTIPLE REDIRECT METHODS FOR RELIABILITY
                    console.log('🔄 Attempting redirect...');
                    window.location.href = 'admin-dashboard.jsp';
                    
                    setTimeout(() => {
                        window.location.replace('admin-dashboard.jsp');
                    }, 100);
                    
                    return;
                } else {
                    console.log('\n👤 REGULAR USER DETECTED');
                    console.log('📝 Updating navbar and loading home page...\n');
                    
                    updateNavbarForLoggedInUser(data.user);
                    loadPage('home');
                }
            } else {
                console.log('\n📝 NO USER LOGGED IN');
                console.log('📝 Showing login form...\n');
                
                updateNavbarForLoggedOutUser();
                loadPage('home');
            }
        },
        error: function(xhr, status, error) {
            console.error('❌ Error checking user status:');
            console.error('   - Status:', status);
            console.error('   - Error:', error);
            
            updateNavbarForLoggedOutUser();
            loadPage('home');
        }
    });
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
    
    // ✅ MAKE GLOBAL CURRENT USER AVAILABLE
    window.currentUser = user;
    window.currentNavbarUser = user;
    
    console.log('✅ User navbar updated');
}

// ✅ UPDATE NAVBAR FOR LOGGED OUT USER
function updateNavbarForLoggedOutUser() {
    console.log('📝 Updating navbar for logged out user');
    
    $('#navbarLoginSection').removeClass('logged-in').addClass('logged-out');
    isUserLoggedIn = false;
    isAdminLoggedIn = false;
    currentUser = null;
    window.currentUser = null;
    window.currentNavbarUser = null;
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

// ✅ MAIN LOAD FUNCTION
function loadPage(pageName) {
    console.log("📄 Loading page:", pageName);
    
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
        case 'bookings':
            initBookingsFunctions();
            break;
        case 'booking-view':
            initBookingViewFunctions();
            break;
        case 'profile':
            initProfileFunctions();
            break;
        case 'login':
            initLoginPageFunctions();
            break;
        case 'settings':
            initSettingsFunctions();
            break;
        case 'help':
            initHelpFunctions();
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
        
        if (!isUserLoggedIn && !isAdminLoggedIn) {
            console.log('⚠️ User not logged in, redirecting to login');
            showMessage('Please login to make a booking', 'warning');
            setTimeout(() => {
                loadPage('login/login');
            }, 1000);
            return;
        }
        
        console.log('📦 Book button clicked');
        loadPage('booking');
    });
}

// ✅ EVENTS PAGE FUNCTIONS
function initEventsFunctions(fullPageName) {
    console.log("🎉 Initializing events page functions");
    
    $(document).off('click.events').on('click.events', '.event-book-btn', function(e) {
        e.preventDefault();
        
        if (!isUserLoggedIn && !isAdminLoggedIn) {
            console.log('⚠️ User not logged in, redirecting to login');
            showMessage('Please login to book an event', 'warning');
            setTimeout(() => {
                loadPage('login/login');
            }, 1000);
            return;
        }
        
        console.log('🎫 Event book button clicked');
        loadPage('bookings');
    });
}

// ✅ GALLERY PAGE FUNCTIONS
function initGalleryFunctions() {
    console.log("🖼️ Gallery initialized");
}

// ✅ CONTACT PAGE FUNCTIONS
function initContactFunctions() {
    console.log("📞 Contact initialized");
}

// ✅ NEW BOOKING PAGE FUNCTIONS
function initBookingsFunctions() {
    console.log("🏨 New booking page initialized");
    
    if (typeof initializeBookingPage === 'function') {
        initializeBookingPage();
    }
}

// ✅ MY BOOKINGS VIEW PAGE FUNCTIONS
function initBookingViewFunctions() {
    console.log("📅 My bookings view page initialized");
    
    if (typeof initializeBookingView === 'function') {
        initializeBookingView();
    }
}

// ✅ PROFILE PAGE FUNCTIONS
function initProfileFunctions() {
    console.log("👤 Profile page initialized");
    
    if (typeof initializeProfilePage === 'function') {
        initializeProfilePage();
    }
}

// ✅ LOGIN PAGE FUNCTIONS
function initLoginPageFunctions() {
    console.log("🔐 Login page initialized");
}

// ✅ SETTINGS PAGE FUNCTIONS
function initSettingsFunctions() {
    console.log("⚙️ Settings page initialized");
}

// ✅ HELP PAGE FUNCTIONS
function initHelpFunctions() {
    console.log("❓ Help page initialized");
}

// ✅ EXPORT GLOBAL FUNCTIONS
window.loadPage = loadPage;
window.updateNavbarForLoggedInUser = updateNavbarForLoggedInUser;
window.updateNavbarForLoggedOutUser = updateNavbarForLoggedOutUser;
window.showMessage = showMessage;
window.checkUserStatusOnLoad = checkUserStatusOnLoad;

console.log("✅ main.js fully loaded!\n");
