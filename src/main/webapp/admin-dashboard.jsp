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
    <title>Admin Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <!-- ✅ LOAD EXTERNAL SCRIPTS -->
    <script src="js/staff-manager.js"></script>
    
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f2f5; }
        
        .admin-wrapper { display: grid; grid-template-columns: 1fr 280px; min-height: 100vh; }
        
        /* ✅ MAIN CONTENT - LEFT SIDE */
        .admin-main { 
            grid-column: 1; 
            padding: 30px; 
            overflow-y: auto; 
            max-height: 100vh;
            background: #f0f2f5;
        }
        
        /* ✅ SIDEBAR - RIGHT SIDE */
        .admin-sidebar { 
            background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%); 
            color: white; 
            position: fixed; 
            right: 0; 
            top: 0; 
            width: 280px; 
            height: 100vh; 
            overflow-y: auto; 
            z-index: 1000;
            box-shadow: -2px 0 10px rgba(0,0,0,0.1);
        }
        
        .sidebar-header { 
            padding: 30px 20px; 
            border-bottom: 2px solid rgba(255, 255, 255, 0.1); 
            text-align: center; 
        }
        
        .sidebar-logo { font-size: 40px; margin-bottom: 10px; }
        .sidebar-title { font-size: 20px; font-weight: 700; }
        .sidebar-subtitle { font-size: 12px; opacity: 0.7; }
        
        .sidebar-menu { 
            list-style: none; 
            padding: 20px 0; 
        }
        
        .sidebar-menu-link { 
            display: flex; 
            align-items: center; 
            gap: 15px; 
            padding: 15px 20px; 
            color: rgba(255, 255, 255, 0.7); 
            text-decoration: none; 
            cursor: pointer; 
            border-left: 4px solid transparent; 
            transition: all 0.3s;
            background: none;
            border: none;
            width: 100%;
            text-align: left;
            font-size: 14px;
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
        
        /* ✅ TOPBAR */
        .admin-topbar { 
            background: white; 
            padding: 20px 30px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-right: 280px;
            position: sticky;
            top: 0;
            z-index: 999;
        }
        
        .topbar-title { 
            font-size: 28px; 
            font-weight: 700; 
            color: #0f172a; 
        }
        
        .logout-btn { 
            background: #ef4444; 
            color: white; 
            border: none; 
            padding: 10px 20px; 
            border-radius: 8px; 
            cursor: pointer; 
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .logout-btn:hover { 
            background: #dc2626; 
        }
        
        /* ✅ CONTENT AREA */
        .content-area {
            margin-right: 280px;
            margin-top: 0;
        }
        
        .page-content {
            display: none;
        }
        
        .page-content.active {
            display: block;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        /* ✅ LOADING STATE */
        .loading {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        
        .spinner {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #3b82f6;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="admin-wrapper">
        
        <!-- ✅ MAIN CONTENT - LEFT SIDE -->
        <div class="content-area">
            <div class="admin-topbar">
                <h1 class="topbar-title" id="pageTitle">📊 Dashboard</h1>
                <button class="logout-btn" id="logoutBtn">Logout</button>
            </div>
            
            <main class="admin-main" id="mainContent">
                <div class="loading">
                    <div class="spinner"></div>
                    <p>Loading...</p>
                </div>
            </main>
        </div>
        
        <!-- ✅ SIDEBAR - RIGHT SIDE -->
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">🏨</div>
                <div class="sidebar-title">Ocean View</div>
                <div class="sidebar-subtitle">Admin Panel</div>
            </div>
            <ul class="sidebar-menu">
                <li><button class="sidebar-menu-link active" data-page="dashboard"><i class="fas fa-chart-line"></i> Dashboard</button></li>
                <li><button class="sidebar-menu-link" data-page="staff"><i class="fas fa-users-cog"></i> Staff</button></li>
                <li><button class="sidebar-menu-link" data-page="customers"><i class="fas fa-user-tie"></i> Customers</button></li>
                <li><button class="sidebar-menu-link" data-page="rooms"><i class="fas fa-door-open"></i> Rooms</button></li>
                <li><button class="sidebar-menu-link" data-page="reservations"><i class="fas fa-calendar-check"></i> Reservations</button></li>
                <li><button class="sidebar-menu-link" data-page="reports"><i class="fas fa-file-alt"></i> Reports</button></li>
            </ul>
        </aside>
    </div>

    <!-- ✅ DASHBOARD SCRIPT -->
    <script>
        class DashboardManager {
            constructor() {
                this.titles = { 
                    dashboard: '📊 Dashboard', 
                    staff: '👔 Staff', 
                    customers: '👥 Customers', 
                    rooms: '🚪 Rooms', 
                    reservations: '📅 Reservations', 
                    reports: '📈 Reports' 
                };
                this.init();
            }
            
            init() {
                console.log('🔧 Initializing Dashboard...');
                this.attachEventListeners();
                this.loadPage('dashboard');
            }
            
            attachEventListeners() {
                // Sidebar menu clicks
                document.querySelectorAll('.sidebar-menu-link').forEach(link => {
                    link.addEventListener('click', (e) => {
                        e.preventDefault();
                        const page = link.dataset.page;
                        this.loadPage(page);
                    });
                });
                
                // Logout button
                document.getElementById('logoutBtn').addEventListener('click', () => {
                    if (confirm('Are you sure you want to logout?')) {
                        window.location.href = 'logout';
                    }
                });
            }
            
            loadPage(page) {
                console.log('📄 Loading page:', page);
                
                // Update sidebar active state
                document.querySelectorAll('.sidebar-menu-link').forEach(l => l.classList.remove('active'));
                document.querySelector('[data-page="' + page + '"]').classList.add('active');
                
                // Update title
                document.getElementById('pageTitle').textContent = this.titles[page] || page;
                
                // Show loading
                document.getElementById('mainContent').innerHTML = `
                    <div class="loading">
                        <div class="spinner"></div>
                        <p>Loading ${page}...</p>
                    </div>
                `;
                
                // Fetch page
                fetch('admin-pages/' + page + '.jsp')
                    .then(r => {
                        if (!r.ok) throw new Error('HTTP ' + r.status);
                        return r.text();
                    })
                    .then(html => {
                        document.getElementById('mainContent').innerHTML = html;
                        
                        // Initialize page-specific scripts
                        this.initPageScripts(page);
                    })
                    .catch(e => {
                        console.error('❌ Error loading page:', e);
                        document.getElementById('mainContent').innerHTML = `
                            <div class="loading" style="color: red;">
                                <i class="fas fa-exclamation-circle" style="font-size: 40px;"></i>
                                <p>❌ Error loading page</p>
                                <p style="font-size: 12px; color: #666;">${e.message}</p>
                            </div>
                        `;
                    });
            }
            
            initPageScripts(page) {
                console.log('🔧 Initializing scripts for:', page);
                
                if (page === 'staff' && typeof initStaffPage === 'function') {
                    setTimeout(() => initStaffPage(), 100);
                }
                // Add more page initializations here
                // else if (page === 'customers' && typeof initCustomersPage === 'function') {
                //     setTimeout(() => initCustomersPage(), 100);
                // }
            }
        }
        
        // ✅ START DASHBOARD WHEN DOM READY
        document.addEventListener('DOMContentLoaded', () => {
            new DashboardManager();
        });
    </script>
</body>
</html>
