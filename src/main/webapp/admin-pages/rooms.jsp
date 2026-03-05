<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .rooms-container {
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
    }
    
    .badge-available {
        background: #d1fae5;
        color: #065f46;
    }
    
    .badge-occupied {
        background: #fecaca;
        color: #991b1b;
    }
    
    .badge-maintenance {
        background: #fef3c7;
        color: #92400e;
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

<div class="rooms-container">
    <div class="container-header">
        <h3>🚪 Rooms</h3>
        <input type="text" class="search-box" placeholder="Search rooms...">
    </div>
    
    <div class="table-wrapper">
        <table class="data-table">
            <thead>
                <tr>
                    <th>Room Number</th>
                    <th>Type</th>
                    <th>Capacity</th>
                    <th>Price/Night</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>101</strong></td>
                    <td>Single</td>
                    <td>1</td>
                    <td>$80</td>
                    <td><span class="badge badge-available">Available</span></td>
                    <td>
                        <div class="action-btns">
                            <button class="btn-icon btn-view" title="View"><i class="fas fa-eye"></i></button>
                            <button class="btn-icon btn-edit" title="Edit"><i class="fas fa-edit"></i></button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><strong>205</strong></td>
                    <td>Double</td>
                    <td>2</td>
                    <td>$120</td>
                    <td><span class="badge badge-occupied">Occupied</span></td>
                    <td>
                        <div class="action-btns">
                            <button class="btn-icon btn-view" title="View"><i class="fas fa-eye"></i></button>
                            <button class="btn-icon btn-edit" title="Edit"><i class="fas fa-edit"></i></button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><strong>310</strong></td>
                    <td>Suite</td>
                    <td>4</td>
                    <td>$200</td>
                    <td><span class="badge badge-maintenance">Maintenance</span></td>
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
