<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is admin
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    String username = (String) session.getAttribute("username");
    
    if (isAdmin == null || !isAdmin || !"ADMIN".equals(username)) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Ocean View Resort</title>
    
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            color: #333;
        }
        
        .admin-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }
        
        /* ============================================
           SIDEBAR STYLES
           ============================================ */
        
        .admin-sidebar {
            background: linear-gradient(180deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 30px 0;
            position: fixed;
            left: 0;
            top: 0;
            width: 250px;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }
        
        .admin-sidebar-header {
            padding: 20px;
            text-align: center;
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 20px;
        }
        
        .admin-logo {
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .admin-logo-text {
            font-size: 18px;
            font-weight: bold;
            display: block;
        }
        
        .admin-logo-subtext {
            font-size: 12px;
            opacity: 0.8;
            margin-top: 5px;
        }
        
        .admin-sidebar-menu {
            list-style: none;
        }
        
        .admin-sidebar-item {
            margin: 0;
        }
        
        .admin-sidebar-link {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
            cursor: pointer;
        }
        
        .admin-sidebar-link:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border-left-color: #10b981;
        }
        
        .admin-sidebar-link.active {
            background: rgba(16, 185, 129, 0.2);
            color: #10b981;
            border-left-color: #10b981;
        }
        
        .admin-sidebar-link i {
            width: 20px;
            text-align: center;
        }
        
        .admin-sidebar-divider {
            height: 1px;
            background: rgba(255, 255, 255, 0.1);
            margin: 15px 0;
        }
        
        /* ============================================
           MAIN CONTENT STYLES
           ============================================ */
        
        .admin-main {
            margin-left: 250px;
            padding: 30px;
            background: #f5f7fa;
            min-height: 100vh;
        }
        
        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .admin-header-title {
            font-size: 28px;
            font-weight: bold;
            color: #1e3c72;
        }
        
        .admin-header-user {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .admin-user-avatar {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 18px;
        }
        
        .admin-user-info {
            display: flex;
            flex-direction: column;
        }
        
        .admin-user-name {
            font-weight: 600;
            color: #333;
        }
        
        .admin-user-role {
            font-size: 12px;
            color: #10b981;
            font-weight: 500;
        }
        
        .admin-logout-btn {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }
        
        .admin-logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }
        
        .admin-content {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 30px;
            min-height: 500px;
        }
        
        /* Loading spinner */
        .admin-loading {
            text-align: center;
            padding: 50px;
        }
        
        .admin-spinner {
            width: 40px;
            height: 40px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #1e3c72;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 20px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .admin-container {
                grid-template-columns: 1fr;
            }
            
            .admin-sidebar {
                width: 100%;
                height: auto;
                position: static;
            }
            
            .admin-main {
                margin-left: 0;
                padding: 20px;
            }
            
            .admin-header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar -->
        <aside class="admin-sidebar">
            <div class="admin-sidebar-header">
                <div class="admin-logo">🏨</div>
                <div class="admin-logo-text">Ocean View</div>
                <div class="admin-logo-subtext">Admin Panel</div>
            </div>
            
            <ul class="admin-sidebar-menu">
                <li class="admin-sidebar-item">
                    <a href="#" class="admin-sidebar-link active" onclick="loadAdminPage('dashboard')">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="admin-sidebar-item">
                    <a href="#" class="admin-sidebar-link" onclick="loadAdminPage('users')">
                        <i class="fas fa-users"></i>
                        <span>Users</span>
                    </a>
                </li>
                <li class="admin-sidebar-item">
                    <a href="#" class="admin-sidebar-link" onclick="loadAdminPage('customers')">
                        <i class="fas fa-user-tie"></i>
                        <span>Customers</span>
                    </a>
                </li>
                <li class="admin-sidebar-item">
                    <a href="#" class="admin-sidebar-link" onclick="loadAdminPage('rooms')">
                        <i class="fas fa-door-open"></i>
                        <span>Rooms</span>
                    </a>
                </li>
                <li class="admin-sidebar-item">
                    <a href="#" class="admin-sidebar-link" onclick="loadAdminPage('reservations')">
                        <i class="fas fa-calendar-check"></i>
                        <span>Reservations</span>
                    </a>
                </li>
                <li class="admin-sidebar-item">
                    <a href="#" class="admin-sidebar-link" onclick="loadAdminPage('reports')">
                        <i class="fas fa-file-alt"></i>
                        <span>Reports</span>
                    </a>
                </li>
                
                <div class="admin-sidebar-divider"></div>
                
                <li class="admin-sidebar-item">
                    <a href="#" class="admin-sidebar-link" onclick="loadAdminPage('settings')">
                        <i class="fas fa-cog"></i>
                        <span>Settings</span>
                    </a>
                </li>
            </ul>
        </aside>
        
        <!-- Main Content -->
        <main class="admin-main">
            <!-- Header -->
            <div class="admin-header">
                <h1 class="admin-header-title" id="pageTitle">Dashboard</h1>
                <div class="admin-header-user">
                    <div class="admin-user-avatar">A</div>
                    <div class="admin-user-info">
                        <div class="admin-user-name">Admin User</div>
                        <div class="admin-user-role">🔐 Administrator</div>
                    </div>
                    <button class="admin-logout-btn" onclick="adminLogout()">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </div>
            </div>
            
            <!-- Content Area -->
            <div class="admin-content" id="adminContent">
                <div class="admin-loading">
                    <div class="admin-spinner"></div>
                    <p>Loading...</p>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        console.log('🚀 Admin Dashboard Loaded');
        
        // Load admin page
        function loadAdminPage(pageName) {
            console.log('📄 Loading admin page:', pageName);
            
            // Update active link
            document.querySelectorAll('.admin-sidebar-link').forEach(link => {
                link.classList.remove('active');
            });
            event.target.closest('.admin-sidebar-link').classList.add('active');
            
            // Update page title
            const titles = {
                'dashboard': 'Dashboard',
                'users': 'Users Management',
                'customers': 'Customers',
                'rooms': 'Rooms Management',
                'reservations': 'Reservations',
                'reports': 'Reports',
                'settings': 'Settings'
            };
            document.getElementById('pageTitle').textContent = titles[pageName] || 'Dashboard';
            
            // Load content
            const contentArea = document.getElementById('adminContent');
            contentArea.innerHTML = '<div class="admin-loading"><div class="admin-spinner"></div><p>Loading...</p></div>';
            
            $.ajax({
                url: 'admin/' + pageName + '.jsp',
                type: 'GET',
                cache: false,
                timeout: 10000,
                success: function(data) {
                    console.log('✅ Page loaded:', pageName);
                    contentArea.innerHTML = data;
                    
                    // Call page-specific init function if exists
                    const initFunc = 'init' + pageName.charAt(0).toUpperCase() + pageName.slice(1);
                    if (typeof window[initFunc] === 'function') {
                        window[initFunc]();
                    }
                },
                error: function(xhr) {
                    console.error('❌ Error loading page:', xhr.status);
                    contentArea.innerHTML = '<div style="padding: 40px; text-align: center;"><h2>❌ Error Loading Page</h2><p>Could not load admin/' + pageName + '.jsp</p></div>';
                }
            });
        }
        
        // Admin logout
        function adminLogout() {
            if (!confirm('Are you sure you want to logout from admin panel?')) return;
            
            console.log('👋 Admin logging out...');
            
            $.ajax({
                url: 'logout',
                type: 'POST',
                success: function(data) {
                    console.log('✅ Admin logout successful');
                    window.location.href = 'index.jsp';
                },
                error: function() {
                    window.location.href = 'index.jsp';
                }
            });
        }
        
        // Initialize on page load
        $(document).ready(function() {
            console.log('✅ Admin dashboard initialized');
            loadAdminPage('dashboard');
        });
    </script>
</body>
</html>
