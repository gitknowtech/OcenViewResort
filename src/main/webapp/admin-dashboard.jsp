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
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f2f5; }
        .admin-wrapper { display: grid; grid-template-columns: 280px 1fr; min-height: 100vh; }
        .admin-sidebar { background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%); color: white; position: fixed; left: 0; top: 0; width: 280px; height: 100vh; overflow-y: auto; z-index: 1000; }
        .sidebar-header { padding: 30px 20px; border-bottom: 2px solid rgba(255, 255, 255, 0.1); text-align: center; }
        .sidebar-logo { font-size: 40px; margin-bottom: 10px; }
        .sidebar-title { font-size: 20px; font-weight: 700; }
        .sidebar-subtitle { font-size: 12px; opacity: 0.7; }
        .sidebar-menu { list-style: none; padding: 20px 0; }
        .sidebar-menu-link { display: flex; align-items: center; gap: 15px; padding: 15px 20px; color: rgba(255, 255, 255, 0.7); text-decoration: none; cursor: pointer; border-left: 4px solid transparent; transition: all 0.3s; }
        .sidebar-menu-link:hover { background: rgba(255, 255, 255, 0.05); color: white; border-left-color: #3b82f6; }
        .sidebar-menu-link.active { background: rgba(59, 130, 246, 0.15); color: #3b82f6; border-left-color: #3b82f6; }
        .admin-topbar { grid-column: 2; background: white; padding: 20px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .topbar-title { font-size: 28px; font-weight: 700; color: #0f172a; }
        .logout-btn { background: #ef4444; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-weight: 600; }
        .logout-btn:hover { background: #dc2626; }
        .admin-main { grid-column: 2; padding: 30px; overflow-y: auto; max-height: calc(100vh - 80px); }
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
                <li><a href="#" class="sidebar-menu-link active" data-page="dashboard"><i class="fas fa-chart-line"></i> Dashboard</a></li>
                <li><a href="#" class="sidebar-menu-link" data-page="staff"><i class="fas fa-users-cog"></i> Staff</a></li>
                <li><a href="#" class="sidebar-menu-link" data-page="customers"><i class="fas fa-user-tie"></i> Customers</a></li>
                <li><a href="#" class="sidebar-menu-link" data-page="rooms"><i class="fas fa-door-open"></i> Rooms</a></li>
                <li><a href="#" class="sidebar-menu-link" data-page="reservations"><i class="fas fa-calendar-check"></i> Reservations</a></li>
                <li><a href="#" class="sidebar-menu-link" data-page="reports"><i class="fas fa-file-alt"></i> Reports</a></li>
            </ul>
        </aside>
        
        <div class="admin-topbar">
            <h1 class="topbar-title" id="pageTitle">📊 Dashboard</h1>
            <button class="logout-btn" id="logoutBtn">Logout</button>
        </div>
        
        <main class="admin-main" id="mainContent">Loading...</main>
    </div>

    <script>
        const titles = { dashboard: '📊 Dashboard', staff: '👔 Staff', customers: '👥 Customers', rooms: '🚪 Rooms', reservations: '📅 Reservations', reports: '📈 Reports' };
        
        function loadPage(page) {
            document.querySelectorAll('.sidebar-menu-link').forEach(l => l.classList.remove('active'));
            document.querySelector('[data-page="' + page + '"]').classList.add('active');
            document.getElementById('pageTitle').textContent = titles[page] || page;
            document.getElementById('mainContent').innerHTML = '<p>Loading...</p>';
            
            fetch('admin-pages/' + page + '.jsp')
                .then(r => r.text())
                .then(html => document.getElementById('mainContent').innerHTML = html)
                .catch(e => document.getElementById('mainContent').innerHTML = '<p>Error loading page</p>');
        }
        
        document.querySelectorAll('.sidebar-menu-link').forEach(link => {
            link.addEventListener('click', e => {
                e.preventDefault();
                loadPage(link.dataset.page);
            });
        });
        
        document.getElementById('logoutBtn').addEventListener('click', () => {
            if (confirm('Logout?')) window.location.href = 'logout';
        });
        
        loadPage('dashboard');
    </script>
</body>
</html>
