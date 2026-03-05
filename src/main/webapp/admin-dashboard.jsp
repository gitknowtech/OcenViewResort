<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            color: #333;
        }
        
        .admin-wrapper {
            display: grid;
            grid-template-columns: 280px 1fr;
            min-height: 100vh;
        }
        
        .admin-sidebar {
            background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
            color: white;
            padding: 0;
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.3);
            z-index: 1000;
        }
        
        .sidebar-header {
            padding: 30px 20px;
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
            text-align: center;
        }
        
        .sidebar-logo {
            font-size: 40px;
            margin-bottom: 10px;
        }
        
        .sidebar-title {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .sidebar-subtitle {
            font-size: 12px;
            opacity: 0.7;
        }
        
        .sidebar-menu {
            list-style: none;
            padding: 20px 0;
        }
        
        .sidebar-menu-item {
            margin: 0;
        }
        
        .sidebar-menu-link {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
            cursor: pointer;
            font-size: 15px;
        }
        
        .sidebar-menu-link:hover {
            background: rgba(255, 255, 255, 0.05);
            color: white;
            border-left-color: #3b82f6;
        }
        
        .sidebar-menu-link.active {
            background: rgba(59, 130, 246, 0.15);
            color: #3b82f6;
            border-left-color: #3b82f6;
        }
        
        .sidebar-menu-link i {
            width: 20px;
            text-align: center;
            font-size: 16px;
        }
        
        .sidebar-divider {
            height: 1px;
            background: rgba(255, 255, 255, 0.1);
            margin: 15px 0;
        }
        
        .admin-topbar {
            grid-column: 2;
            background: white;
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border-bottom: 1px solid #e5e7eb;
        }
        
        .topbar-title {
            font-size: 28px;
            font-weight: 700;
            color: #0f172a;
        }
        
        .topbar-user {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .user-avatar {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 18px;
            box-shadow: 0 2px 8px rgba(59, 130, 246, 0.3);
        }
        
        .user-info {
            display: flex;
            flex-direction: column;
        }
        
        .user-name {
            font-weight: 600;
            color: #0f172a;
            font-size: 14px;
        }
        
        .user-role {
            font-size: 12px;
            color: #6b7280;
        }
        
        .logout-btn {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }
        
        .admin-main {
            grid-column: 2;
            padding: 30px;
            overflow-y: auto;
            max-height: calc(100vh - 80px);
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        @media (max-width: 1024px) {
            .admin-wrapper {
                grid-template-columns: 1fr;
            }
            
            .admin-sidebar {
                width: 100%;
                height: auto;
                position: static;
            }
            
            .admin-topbar {
                grid-column: 1;
            }
            
            .admin-main {
                grid-column: 1;
                max-height: none;
            }
        }
    </style>
</head>
<body>
    <div class="admin-wrapper">
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">🏨</div>
                <div class="sidebar-title">Ocean View</div>
                <div class="sidebar-subtitle">Admin Panel</div>
            </div>
            
            <ul class="sidebar-menu">
                <li class="sidebar-menu-item">
                    <a href="#" class="sidebar-menu-link active" onclick="loadPage('dashboard', event); return false;">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="#" class="sidebar-menu-link" onclick="loadPage('staff', event); return false;">
                        <i class="fas fa-users-cog"></i>
                        <span>Staff Management</span>
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="#" class="sidebar-menu-link" onclick="loadPage('customers', event); return false;">
                        <i class="fas fa-user-tie"></i>
                        <span>Customers</span>
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="#" class="sidebar-menu-link" onclick="loadPage('rooms', event); return false;">
                        <i class="fas fa-door-open"></i>
                        <span>Rooms</span>
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="#" class="sidebar-menu-link" onclick="loadPage('reservations', event); return false;">
                        <i class="fas fa-calendar-check"></i>
                        <span>Reservations</span>
                    </a>
                </li>
                <li class="sidebar-menu-item">
                    <a href="#" class="sidebar-menu-link" onclick="loadPage('reports', event); return false;">
                        <i class="fas fa-file-alt"></i>
                        <span>Reports</span>
                    </a>
                </li>
                
                <div class="sidebar-divider"></div>
                
                <li class="sidebar-menu-item">
                    <a href="#" class="sidebar-menu-link" onclick="loadPage('settings', event); return false;">
                        <i class="fas fa-cog"></i>
                        <span>Settings</span>
                    </a>
                </li>
            </ul>
        </aside>
        
        <div class="admin-topbar">
            <h1 class="topbar-title" id="pageTitle">📊 Dashboard</h1>
            <div class="topbar-user">
                <div class="user-avatar">A</div>
                <div class="user-info">
                    <div class="user-name">Admin User</div>
                    <div class="user-role">🔐 Administrator</div>
                </div>
                <button class="logout-btn" onclick="adminLogout()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </div>
        </div>
        
        <main class="admin-main" id="mainContent">
            <!-- Content loads here -->
        </main>
    </div>
    
    <script>
        console.log('🚀 Admin Dashboard Loaded');
        
        // ✅ FIXED: loadPage now accepts event parameter
        function loadPage(pageName, event) {
            console.log('📄 Loading admin page:', pageName);
            
            // Update sidebar active link
            document.querySelectorAll('.sidebar-menu-link').forEach(link => {
                link.classList.remove('active');
            });
            
            if (event && event.target) {
                event.target.closest('.sidebar-menu-link').classList.add('active');
            }
            
            const titles = {
                'dashboard': '📊 Dashboard',
                'staff': '👔 Staff Management',
                'customers': '👨‍💼 Customers',
                'rooms': '🚪 Rooms Management',
                'reservations': '📅 Reservations',
                'reports': '📈 Reports',
                'settings': '⚙️ Settings'
            };
            document.getElementById('pageTitle').textContent = titles[pageName] || 'Dashboard';
            
            const mainContent = document.getElementById('mainContent');
            mainContent.innerHTML = '<div style="text-align: center; padding: 50px;"><div style="width: 40px; height: 40px; border: 4px solid #f3f3f3; border-top: 4px solid #3b82f6; border-radius: 50%; animation: spin 1s linear infinite; margin: 0 auto;"></div><p style="margin-top: 20px; color: #6b7280;">Loading...</p></div>';
            
            $.ajax({
                url: 'admin-pages/' + pageName + '.jsp',
                type: 'GET',
                cache: false,
                timeout: 10000,
                success: function(data) {
                    console.log('✅ Admin page loaded:', pageName);
                    mainContent.innerHTML = data;
                },
                error: function(xhr) {
                    console.error('❌ Error loading admin page:', xhr.status);
                    mainContent.innerHTML = '<div style="padding: 40px; text-align: center;"><h2>❌ Error Loading Page</h2><p>Status: ' + xhr.status + '</p></div>';
                }
            });
        }
        
        function adminLogout() {
            if (!confirm('Are you sure you want to logout?')) return;
            
            $.ajax({
                url: 'logout',
                type: 'POST',
                success: function() {
                    window.location.href = 'index.jsp';
                },
                error: function() {
                    window.location.href = 'index.jsp';
                }
            });
        }
        
        $(document).ready(function() {
            console.log('✅ Admin dashboard ready');
            loadPage('dashboard', null);
        });
    </script>
</body>
</html>
