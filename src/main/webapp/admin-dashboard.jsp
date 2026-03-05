<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
    
    System.out.println("\n╔════════════════════════════════════════════╗");
    System.out.println("║  🔐 ADMIN DASHBOARD PAGE LOADING          ║");
    System.out.println("╚════════════════════════════════════════════╝");
    System.out.println("isAdmin: " + isAdmin);
    System.out.println("username: " + username);
    System.out.println("email: " + email);
    
    // ✅ FIXED: Check both ADMIN and staff users
    if (isAdmin == null || !isAdmin) {
        System.out.println("❌ NOT ADMIN - REDIRECTING TO INDEX\n");
        response.sendRedirect("index.jsp");
        return;
    }
    
    System.out.println("✅ ADMIN VERIFIED - LOADING DASHBOARD\n");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Ocean View</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.css" rel="stylesheet">
    
    <!-- ✅ LOAD ALL EXTERNAL SCRIPTS -->
    <script src="js/dashboard-manager.js"></script>
    <script src="js/staff-manager.js"></script>
    <script src="js/rooms-manager.js"></script>
    <script src="js/users-manager.js"></script>
    <script src="js/reservations-manager.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    
    <style>
        * { 
            margin: 0; 
            padding: 0; 
            box-sizing: border-box; 
        }
        
        html, body {
            height: 100%;
            width: 100%;
        }
        
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
            background: #f5f7fa;
            color: #2c3e50;
            font-size: 13px;
            line-height: 1.5;
        }
        
        .admin-wrapper { 
            display: grid; 
            grid-template-columns: 240px 1fr; 
            min-height: 100vh;
            gap: 0;
        }
        
        .admin-sidebar { 
            background: linear-gradient(135deg, #1a1f3a 0%, #16213e 100%);
            color: white; 
            position: fixed; 
            left: 0; 
            top: 0; 
            width: 240px; 
            height: 100vh; 
            overflow-y: auto; 
            z-index: 1000;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.15);
            display: flex;
            flex-direction: column;
            padding: 0;
        }
        
        .admin-sidebar::-webkit-scrollbar {
            width: 6px;
        }
        
        .admin-sidebar::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
        }
        
        .admin-sidebar::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 3px;
        }
        
        .admin-sidebar::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .sidebar-header { 
            padding: 20px 16px; 
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
            background: rgba(0, 0, 0, 0.2);
        }
        
        .sidebar-logo { 
            font-size: 32px; 
            margin-bottom: 8px; 
            display: block;
        }
        
        .sidebar-title { 
            font-size: 15px; 
            font-weight: 700;
            letter-spacing: 0.5px;
            margin-bottom: 2px;
        }
        
        .sidebar-subtitle { 
            font-size: 11px; 
            opacity: 0.7;
            font-weight: 400;
        }
        
        .sidebar-menu { 
            list-style: none; 
            padding: 12px 0; 
            flex: 1;
        }
        
        .sidebar-menu li {
            margin: 0;
        }
        
        .sidebar-menu-link { 
            display: flex; 
            align-items: center; 
            gap: 12px; 
            padding: 11px 16px; 
            color: rgba(255, 255, 255, 0.65); 
            text-decoration: none; 
            cursor: pointer; 
            border-left: 3px solid transparent; 
            transition: all 0.25s ease;
            background: none;
            border: none;
            width: 100%;
            text-align: left;
            font-size: 13px;
            font-weight: 500;
            letter-spacing: 0.3px;
        }
        
        .sidebar-menu-link i {
            width: 16px;
            text-align: center;
            font-size: 13px;
        }
        
        .sidebar-menu-link:hover { 
            background: rgba(255, 255, 255, 0.08); 
            color: #fff;
            border-left-color: #3b82f6;
            padding-left: 18px;
        }
        
        .sidebar-menu-link.active { 
            background: rgba(59, 130, 246, 0.2); 
            color: #60a5fa;
            border-left-color: #3b82f6;
        }
        
        .sidebar-footer {
            padding: 12px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: auto;
            background: rgba(0, 0, 0, 0.1);
        }
        
        .sidebar-user-menu {
            position: relative;
        }
        
        .sidebar-user-toggle {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 8px;
            padding: 9px 11px;
            color: white;
            cursor: pointer;
            transition: all 0.25s ease;
            width: 100%;
            font-size: 12px;
        }
        
        .sidebar-user-toggle:hover {
            background: rgba(255, 255, 255, 0.12);
            border-color: rgba(255, 255, 255, 0.25);
        }
        
        .sidebar-user-avatar {
            width: 28px;
            height: 28px;
            background: linear-gradient(135deg, #3b82f6, #1e40af);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            color: white;
            font-weight: 700;
            border: 1px solid rgba(255, 255, 255, 0.2);
            flex-shrink: 0;
        }
        
        .sidebar-user-info {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            min-width: 0;
            flex: 1;
        }
        
        .sidebar-user-name {
            font-size: 11px;
            font-weight: 600;
            line-height: 1.2;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 100%;
        }
        
        .sidebar-user-role {
            font-size: 9px;
            opacity: 0.75;
            line-height: 1;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 400;
        }
        
        .sidebar-user-dropdown {
            position: absolute;
            bottom: 100%;
            left: 0;
            right: 0;
            background: white;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            padding: 10px 0;
            opacity: 0;
            visibility: hidden;
            transform: translateY(8px);
            transition: all 0.25s ease;
            z-index: 1001;
            border: 1px solid #e5e7eb;
            margin-bottom: 6px;
            min-width: 200px;
        }
        
        .sidebar-user-menu:hover .sidebar-user-dropdown {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }
        
        .sidebar-user-dropdown-header {
            padding: 10px 14px;
            border-bottom: 1px solid #f3f4f6;
            margin-bottom: 6px;
            background: #f9fafb;
        }
        
        .sidebar-user-dropdown-name {
            font-weight: 600;
            color: #1f2937;
            font-size: 13px;
            margin-bottom: 2px;
        }
        
        .sidebar-user-dropdown-role {
            font-weight: 500;
            color: #3b82f6;
            font-size: 11px;
            margin-bottom: 2px;
        }
        
        .sidebar-user-dropdown-email {
            color: #6b7280;
            font-size: 10px;
            font-weight: 400;
        }
        
        .sidebar-user-dropdown-item {
            display: block;
            padding: 9px 14px;
            color: #4b5563;
            text-decoration: none;
            transition: all 0.2s ease;
            font-size: 12px;
            border-bottom: 1px solid #f9fafb;
        }
        
        .sidebar-user-dropdown-item:hover {
            background: #f3f4f6;
            color: #3b82f6;
            padding-left: 18px;
        }
        
        .sidebar-user-dropdown-item i {
            width: 14px;
            margin-right: 8px;
            text-align: center;
            font-size: 11px;
        }
        
        .sidebar-user-dropdown-divider {
            height: 1px;
            background: #f3f4f6;
            margin: 5px 0;
        }
        
        .sidebar-user-dropdown-logout {
            color: #dc2626 !important;
            font-weight: 500;
        }
        
        .sidebar-user-dropdown-logout:hover {
            background: #fee2e2 !important;
            color: #991b1b !important;
        }
        
        .content-area {
            grid-column: 2;
            display: flex;
            flex-direction: column;
            height: 100vh;
            overflow: hidden;
        }
        
        .admin-topbar { 
            background: white; 
            padding: 14px 24px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
            border-bottom: 1px solid #e5e7eb;
            flex-shrink: 0;
        }
        
        .topbar-left {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        
        .topbar-title { 
            font-size: 18px; 
            font-weight: 700;
            color: #1f2937;
            letter-spacing: 0.3px;
        }
        
        .topbar-breadcrumb {
            font-size: 11px;
            color: #9ca3af;
            font-weight: 400;
        }
        
        .topbar-right {
            display: flex;
            gap: 12px;
            align-items: center;
        }
        
        .topbar-icon-btn {
            background: none;
            border: none;
            color: #6b7280;
            cursor: pointer;
            font-size: 14px;
            padding: 6px 10px;
            border-radius: 6px;
            transition: all 0.2s ease;
        }
        
        .topbar-icon-btn:hover {
            background: #f3f4f6;
            color: #1f2937;
        }
        
        .admin-main { 
            flex: 1;
            padding: 20px 24px;
            overflow-y: auto;
            background: #f5f7fa;
        }
        
        .admin-main::-webkit-scrollbar {
            width: 8px;
        }
        
        .admin-main::-webkit-scrollbar-track {
            background: transparent;
        }
        
        .admin-main::-webkit-scrollbar-thumb {
            background: #d1d5db;
            border-radius: 4px;
        }
        
        .admin-main::-webkit-scrollbar-thumb:hover {
            background: #9ca3af;
        }
        
        .loading {
            text-align: center;
            padding: 60px 20px;
            color: #9ca3af;
        }
        
        .spinner {
            border: 3px solid #e5e7eb;
            border-top: 3px solid #3b82f6;
            border-radius: 50%;
            width: 36px;
            height: 36px;
            animation: spin 0.8s linear infinite;
            margin: 0 auto 16px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .page-content {
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(5px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .error-container {
            background: #fee2e2;
            border: 1px solid #fecaca;
            border-radius: 8px;
            padding: 16px;
            text-align: center;
            color: #991b1b;
        }
        
        .error-container i {
            font-size: 32px;
            margin-bottom: 8px;
            display: block;
        }
        
        .error-container p {
            margin: 4px 0;
            font-size: 13px;
        }
        
        @media (max-width: 1024px) {
            .admin-wrapper {
                grid-template-columns: 200px 1fr;
            }
            
            .admin-sidebar {
                width: 200px;
            }
            
            .sidebar-menu-link {
                padding: 10px 14px;
                font-size: 12px;
            }
            
            .topbar-title {
                font-size: 16px;
            }
        }
        
        @media (max-width: 768px) {
            .admin-wrapper {
                grid-template-columns: 1fr;
            }
            
            .admin-sidebar {
                width: 100%;
                height: auto;
                position: relative;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }
            
            .content-area {
                grid-column: 1;
            }
            
            .admin-topbar {
                padding: 12px 16px;
            }
            
            .topbar-title {
                font-size: 15px;
            }
            
            .admin-main {
                padding: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="admin-wrapper">
        
        <!-- ✅ SIDEBAR - LEFT SIDE -->
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">🏨</div>
                <div class="sidebar-title">Ocean View</div>
                <div class="sidebar-subtitle">Admin</div>
            </div>
            
            <ul class="sidebar-menu">
                <li><button class="sidebar-menu-link active" data-page="dashboard"><i class="fas fa-chart-line"></i> Dashboard</button></li>
                <li><button class="sidebar-menu-link" data-page="reservations"><i class="fas fa-calendar-check"></i> Reservations</button></li>
                <li><button class="sidebar-menu-link" data-page="users"><i class="fas fa-user-tie"></i> Customers</button></li>
                <li><button class="sidebar-menu-link" data-page="rooms"><i class="fas fa-door-open"></i> Rooms</button></li>
                <li><button class="sidebar-menu-link" data-page="staff"><i class="fas fa-users-cog"></i> Staff</button></li>
            </ul>
            
            <!-- ✅ USER MENU AT BOTTOM -->
            <div class="sidebar-footer">
                <div class="sidebar-user-menu">
                    <button class="sidebar-user-toggle" id="sidebarUserToggle">
                        <div class="sidebar-user-avatar" id="sidebarUserAvatar">A</div>
                        <div class="sidebar-user-info">
                            <div class="sidebar-user-name" id="sidebarUserName">Admin</div>
                            <div class="sidebar-user-role">Administrator</div>
                        </div>
                        <i class="fas fa-chevron-up" style="font-size: 9px; margin-left: auto; opacity: 0.7;"></i>
                    </button>
                    
                    <div class="sidebar-user-dropdown">
                        <div class="sidebar-user-dropdown-header">
                            <div class="sidebar-user-dropdown-name" id="sidebarUserDropdownName">Admin</div>
                            <div class="sidebar-user-dropdown-role">Administrator</div>
                            <div class="sidebar-user-dropdown-email" id="sidebarUserDropdownEmail">admin@oceanview.com</div>
                        </div>
                        
                        <a href="#" class="sidebar-user-dropdown-item sidebar-user-dropdown-logout" onclick="adminLogout(event)">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </aside>
        
        <!-- ✅ CONTENT AREA -->
        <div class="content-area">
            <!-- ✅ TOPBAR -->
            <div class="admin-topbar">
                <div class="topbar-left">
                    <h1 class="topbar-title" id="pageTitle">📊 Dashboard</h1>
                    <div class="topbar-breadcrumb" id="pageBreadcrumb">Home / Dashboard</div>
                </div>
                <div class="topbar-right">
                    <button class="topbar-icon-btn" title="Notifications">
                        <i class="fas fa-bell"></i>
                    </button>
                    <button class="topbar-icon-btn" title="Settings">
                        <i class="fas fa-sliders-h"></i>
                    </button>
                </div>
            </div>
            
            <!-- ✅ MAIN CONTENT -->
            <main class="admin-main" id="mainContent">
                <div class="loading">
                    <div class="spinner"></div>
                    <p>Loading...</p>
                </div>
            </main>
        </div>
    </div>

    <!-- ✅ DASHBOARD SCRIPT -->
    <script>
        console.log('🚀 Admin Dashboard Loading...');
        console.log('Admin User: <%= firstName %> <%= lastName %>');
        console.log('Email: <%= email %>');
        
        class AdminDashboard {
            constructor() {
                this.titles = { 
                    dashboard: '📊 Dashboard', 
                    staff: '👔 Staff', 
                    users: '👥 Customers',
                    rooms: '🚪 Rooms', 
                    reservations: '📅 Reservations'
                };
                this.adminUser = {
                    name: '<%= firstName != null ? firstName + " " + lastName : "Admin" %>'.trim(),
                    username: '<%= username %>',
                    email: '<%= email != null ? email : "admin@oceanview.com" %>',
                    role: 'Administrator'
                };
                console.log('✅ Admin Dashboard initialized:', this.adminUser);
                this.init();
            }
            
            init() {
                console.log('🔧 Initializing Admin Dashboard...');
                this.setupUserInfo();
                this.attachEventListeners();
                this.loadPage('dashboard');
            }
            
            setupUserInfo() {
                const firstLetter = (this.adminUser.name || 'A').charAt(0).toUpperCase();
                
                document.getElementById('sidebarUserAvatar').textContent = firstLetter;
                document.getElementById('sidebarUserName').textContent = this.adminUser.name;
                document.getElementById('sidebarUserDropdownName').textContent = this.adminUser.name;
                document.getElementById('sidebarUserDropdownEmail').textContent = this.adminUser.email;
                
                console.log('✅ Admin info loaded:', this.adminUser);
            }
            
            attachEventListeners() {
                document.querySelectorAll('.sidebar-menu-link').forEach(link => {
                    link.addEventListener('click', (e) => {
                        e.preventDefault();
                        const page = link.dataset.page;
                        this.loadPage(page);
                    });
                });
            }
            
            loadPage(page) {
                console.log('📄 Loading page:', page);
                
                document.querySelectorAll('.sidebar-menu-link').forEach(l => l.classList.remove('active'));
                const activeLink = document.querySelector('[data-page="' + page + '"]');
                if (activeLink) activeLink.classList.add('active');
                
                const titleText = this.titles[page] || page;
                document.getElementById('pageTitle').textContent = titleText;
                document.getElementById('pageBreadcrumb').textContent = 'Home / ' + titleText.replace(/[📊👔👥🚪📅]/g, '').trim();
                
                document.getElementById('mainContent').innerHTML = `
                    <div class="loading">
                        <div class="spinner"></div>
                        <p>Loading ${page}...</p>
                    </div>
                `;
                
                // ✅ CORRECT PATH - RELATIVE
                const pageUrl = 'admin-pages/' + page + '.jsp';
                console.log('📥 Fetching from:', pageUrl);
                
                fetch(pageUrl)
                    .then(r => {
                        console.log('📊 Response status:', r.status);
                        if (!r.ok) throw new Error('HTTP ' + r.status);
                        return r.text();
                    })
                    .then(html => {
                        console.log('✅ Page loaded successfully');
                        document.getElementById('mainContent').innerHTML = '<div class="page-content">' + html + '</div>';
                        
                        // ✅ WAIT THEN CALL INIT
                        setTimeout(() => {
                            this.initPageScripts(page);
                        }, 500);
                    })
                    .catch(e => {
                        console.error('❌ Error loading page:', e);
                        document.getElementById('mainContent').innerHTML = `
                            <div class="error-container">
                                <i class="fas fa-exclamation-circle"></i>
                                <p><strong>Error loading ${page}</strong></p>
                                <p>${e.message}</p>
                            </div>
                        `;
                    });
            }
            
            initPageScripts(page) {
                console.log('🔧 Initializing scripts for:', page);
                
                if (page === 'dashboard') {
                    console.log('🎯 Calling initDashboardPage()');
                    if (typeof initDashboardPage === 'function') {
                        initDashboardPage();
                    } else {
                        console.warn('⚠️ initDashboardPage not found');
                    }
                }
                
                if (page === 'reservations') {
                    console.log('🎯 Calling initReservationsPage()');
                    if (typeof initReservationsPage === 'function') {
                        initReservationsPage();
                    } else {
                        console.warn('⚠️ initReservationsPage not found');
                    }
                }
                
                if (page === 'staff') {
                    console.log('🎯 Calling initStaffPage()');
                    if (typeof initStaffPage === 'function') {
                        initStaffPage();
                    } else {
                        console.warn('⚠️ initStaffPage not found');
                    }
                }
                
                if (page === 'users') {
                    console.log('🎯 Calling initUsersPage()');
                    if (typeof initUsersPage === 'function') {
                        initUsersPage();
                    } else {
                        console.warn('⚠️ initUsersPage not found');
                    }
                }
                
                if (page === 'rooms') {
                    console.log('🎯 Calling initRoomsPage()');
                    if (typeof initRoomsPage === 'function') {
                        initRoomsPage();
                    } else {
                        console.warn('⚠️ initRoomsPage not found');
                    }
                }
            }
        }
        
        // ✅ LOGOUT FUNCTION
        function adminLogout(event) {
            event.preventDefault();
            
            if (!confirm('Are you sure you want to logout?')) return;
            
            console.log('👋 Admin logging out...');
            
            fetch('logout', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('✅ Admin logout successful');
                    window.location.href = 'index.jsp';
                } else {
                    alert('❌ Error during logout');
                }
            })
            .catch(error => {
                console.error('❌ Logout error:', error);
                alert('⚠️ Network error during logout');
            });
        }
        
        // ✅ START DASHBOARD WHEN DOM READY
        document.addEventListener('DOMContentLoaded', () => {
            console.log('✅ DOM Ready - Starting Admin Dashboard');
            new AdminDashboard();
        });
    </script>
</body>
</html>
