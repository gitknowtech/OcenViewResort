<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ✅ FONT AWESOME -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<style>
    .container { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; }
    .card { background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); padding: 20px; }
    .card-title { font-size: 18px; font-weight: 700; margin-bottom: 20px; border-bottom: 2px solid #e5e7eb; padding-bottom: 15px; }
    table { width: 100%; border-collapse: collapse; font-size: 12px; }
    th, td { padding: 10px; text-align: left; border-bottom: 1px solid #e5e7eb; }
    th { background: #f9fafb; font-weight: 600; }
    .btn { padding: 8px 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 14px; }
    .btn-primary { background: #3b82f6; color: white; }
    .btn-primary:hover { background: #2563eb; }
    .btn-secondary { background: #e5e7eb; color: #374151; }
    .btn-secondary:hover { background: #d1d5db; }
    .btn-small { width: 32px; height: 32px; padding: 0; display: inline-flex; align-items: center; justify-content: center; border-radius: 6px; margin-right: 4px; font-size: 12px; }
    .btn-view { background: #dbeafe; color: #1d4ed8; }
    .btn-view:hover { background: #bfdbfe; }
    .btn-edit { background: #fef3c7; color: #b45309; }
    .btn-edit:hover { background: #fde68a; }
    .btn-delete { background: #fee2e2; color: #991b1b; }
    .btn-delete:hover { background: #fecaca; }
    input, select, textarea { width: 100%; padding: 10px; border: 1px solid #d1d5db; border-radius: 8px; margin-bottom: 15px; font-size: 14px; }
    input:focus, select:focus, textarea:focus { outline: none; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1); }
    .msg { position: fixed; top: 20px; right: 20px; padding: 15px 20px; border-radius: 8px; color: white; display: none; z-index: 9999; font-weight: 600; }
    .msg.success { background: #10b981; }
    .msg.error { background: #ef4444; }
    .msg.show { display: block; animation: slideIn 0.3s ease; }
    @keyframes slideIn { from { transform: translateX(400px); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
    .badge { display: inline-block; padding: 4px 8px; border-radius: 4px; font-size: 11px; font-weight: 600; }
    .badge-active { background: #d1fae5; color: #065f46; }
    .badge-inactive { background: #fee2e2; color: #991b1b; }
    @media (max-width: 1400px) { .container { grid-template-columns: 1fr; } }
</style>

<div id="msg" class="msg"></div>

<div class="container">
    <div class="card">
        <div class="card-title">👥 Users Management (Website Customers)</div>
        <input type="text" id="search" placeholder="🔍 Search...">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>City</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="usersTable">
                <tr><td colspan="7" style="text-align: center; padding: 40px;">Loading...</td></tr>
            </tbody>
        </table>
    </div>
    
    <div class="card">
        <div class="card-title" id="formTitle">➕ Add User</div>
        <input type="hidden" id="userId">
        <input type="hidden" id="mode" value="add">
        <input type="text" id="name" placeholder="Full Name" required>
        <input type="email" id="email" placeholder="Email" required>
        <input type="tel" id="phone" placeholder="Phone Number" required>
        <input type="text" id="address" placeholder="Address">
        <input type="text" id="city" placeholder="City">
        <input type="text" id="country" placeholder="Country">
        
        <select id="status" required>
            <option value="">Select Status</option>
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
        </select>
        
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
            <button class="btn btn-primary" id="submitBtn"><i class="fas fa-save"></i> Add User</button>
            <button class="btn btn-secondary" id="resetBtn"><i class="fas fa-redo"></i> Clear</button>
        </div>
    </div>
</div>
