console.log("✅ main.js loaded successfully!");

let currentUser = null;
let isUserLoggedIn = false;

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

function checkUserStatusOnLoad() {
    console.log('🔍 Checking user status...');
    $.ajax({
        url: 'checkUser',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            if (data.loggedIn) {
                currentUser = data.user;
                isUserLoggedIn = true;
                updateNavbarForLoggedInUser(data.user);
            } else {
                updateNavbarForLoggedOutUser();
            }
            loadPage('home');
        },
        error: function() {
            updateNavbarForLoggedOutUser();
            loadPage('home');
        }
    });
}

function updateNavbarForLoggedInUser(user) {
    const displayName = user.name || user.email.split('@')[0];
    $('#navbarLoginSection').removeClass('logged-out').addClass('logged-in');
    $('#navbarUserAvatar').text(displayName.charAt(0).toUpperCase());
    $('#navbarUserName').text(displayName);
    $('#navbarUserEmail').text(user.email);
    $('#navbarUserDropdownName').text(displayName);
    $('#navbarUserDropdownEmail').text(user.email);
}

function updateNavbarForLoggedOutUser() {
    $('#navbarLoginSection').removeClass('logged-in').addClass('logged-out');
}

window.logoutUser = function() {
    if (!confirm('Logout?')) return;
    $.ajax({
        url: 'logout',
        type: 'POST',
        dataType: 'json',
        success: function(data) {
            updateNavbarForLoggedOutUser();
            showMessage('👋 Logged out', 'info');
            loadPage('home');
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
            console.log("✅ Profile page loaded");
            break;
    }
}

function showMessage(text, type) {
    const bgColor = type === 'success' ? '#10b981' : type === 'error' ? '#ef4444' : '#3b82f6';
    const msg = $(`<div style="position: fixed; top: 20px; right: 20px; z-index: 9999; padding: 15px 20px; border-radius: 8px; color: white; font-weight: bold; background: ${bgColor}; box-shadow: 0 4px 12px rgba(0,0,0,0.15); min-width: 250px;">${text}</div>`);
    $('body').append(msg);
    setTimeout(() => msg.fadeOut(300, function() { $(this).remove(); }), 5000);
}

function initHomePageFunctions() {
    $(document).off('click.home').on('click.home', '.cta-button', function(e) {
        e.preventDefault();
        const page = $(this).data('page');
        if (page) loadPage(page);
    });
}

function initAccommodationFunctions() {
    $(document).off('click.accommodation').on('click.accommodation', '.book-btn', function(e) {
        e.preventDefault();
        loadPage('reservation');
    });
}

function initEventsFunctions(fullPageName) {
    $(document).off('click.events').on('click.events', '.event-book-btn', function(e) {
        e.preventDefault();
        loadPage('reservation');
    });
}

function initGalleryFunctions() {
    console.log("Gallery initialized");
}

function initContactFunctions() {
    console.log("Contact initialized");
}

function initReservationFunctions() {
    console.log("Reservation initialized");
}

window.loadPage = loadPage;
window.updateNavbarForLoggedInUser = updateNavbarForLoggedInUser;
window.updateNavbarForLoggedOutUser = updateNavbarForLoggedOutUser;
window.showMessage = showMessage;

console.log("✅ main.js fully loaded!");
