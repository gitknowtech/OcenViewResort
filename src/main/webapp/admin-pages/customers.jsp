<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .customers-container {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        overflow: hidden;
    }
    
    .container-header {
        padding: 20px 30px;
        background: linear-gradient(135deg, #f8f9fa 0%, #e5e7eb 100%);
        border-bottom: 2px solid #e5e7eb;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .container-header h3 {
        margin: 0;
        color: #0f172a;
        font-size: 18px;
        font-weight: 700;
    }
    
    .search-box {
        padding: 10px 15px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        font-size: 14px;
        width: 300px;
    }
    
    .table-wrapper {
        overflow-x: auto;
    }
    
    .data-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .data-table thead {
        background: #f9fafb;
    }
    
    .data-table th {
        padding: 15px;
        text-align: left;
        font-weight: 600;
        color: #374151;
        font-size: 13px;
        border-bottom: 2px solid #e5e7eb;
    }
    
    .data-table td {
        padding: 15px;
        border-bottom: 1px solid #f3f4f6;
        font-size: 14px;
    }
    
    .data-table tbody tr:hover {
        background: #f9fafb;
    }
    
    .badge {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        background: #d1fae5;
        color: #065f46;
    }
    
    .action-btns {
        display: flex;
        gap: 8px;
    }
    
    .btn-icon {
        width: 36px;
        height: 36px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
        font-size: 14px;
    }
    
    .btn-view {
        background: #dbeafe;
        color: #1d4ed8;
    }
    
    .btn-view:hover {
        background: #bfdbfe;
    }
    
    .btn-edit {
        background: #fef3c7;
        color: #b45309;
    }
    
    .btn-edit:hover {
        background: #fde68a;
    }
</style>

<div class="customers-container">
    <div class="container-header">
        <h3>👥 Customers</h3>
        <input type="text" class="search-box" placeholder="Search customers...">
    </div>
    
    <div class="table-wrapper">
        <table class="data-table">
            <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Total Bookings</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>#CUST001</strong></td>
                    <td>Alice Brown</td>
                    <td>alice@example.com</td>
                    <td>555-1001</td>
                    <td>5</td>
                    <td><span class="badge">Active</span></td>
                    <td>
                        <div class="action-btns">
                            <button class="btn-icon btn-view" title="View"><i class="fas fa-eye"></i></button>
                            <button class="btn-icon btn-edit" title="Edit"><i class="fas fa-edit"></i></button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><strong>#CUST002</strong></td>
                    <td>Bob Wilson</td>
                    <td>bob@example.com</td>
                    <td>555-1002</td>
                    <td>3</td>
                    <td><span class="badge">Active</span></td>
                    <td>
                        <div class="action-btns">
                            <button class="btn-icon btn-view" title="View"><i class="fas fa-eye"></i></button>
                            <button class="btn-icon btn-edit" title="Edit"><i class="fas fa-edit"></i></button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><strong>#CUST003</strong></td>
                    <td>Carol White</td>
                    <td>carol@example.com</td>
                    <td>555-1003</td>
                    <td>8</td>
                    <td><span class="badge">Active</span></td>
                    <td>
                        <div class="action-btns">
                            <button class="btn-icon btn-view" title="View"><i class="fas fa-eye"></i></button>
                            <button class="btn-icon btn-edit" title="Edit"><i class="fas fa-edit"></i></button>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
