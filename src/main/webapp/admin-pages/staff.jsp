<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ✅ FONT AWESOME -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<style>
    .container { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; }
    .card { background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); padding: 20px; }
    .card-title { font-size: 18px; font-weight: 700; margin-bottom: 20px; border-bottom: 2px solid #e5e7eb; padding-bottom: 15px; }
    table { width: 100%; border-collapse: collapse; }
    th, td { padding: 12px; text-align: left; border-bottom: 1px solid #e5e7eb; }
    th { background: #f9fafb; font-weight: 600; }
    .btn { padding: 8px 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 14px; }
    .btn-primary { background: #3b82f6; color: white; }
    .btn-primary:hover { background: #2563eb; }
    .btn-secondary { background: #e5e7eb; color: #374151; }
    .btn-secondary:hover { background: #d1d5db; }
    .btn-small { width: 36px; height: 36px; padding: 0; display: inline-flex; align-items: center; justify-content: center; border-radius: 6px; margin-right: 5px; }
    .btn-view { background: #dbeafe; color: #1d4ed8; }
    .btn-view:hover { background: #bfdbfe; }
    .btn-edit { background: #fef3c7; color: #b45309; }
    .btn-edit:hover { background: #fde68a; }
    .btn-delete { background: #fee2e2; color: #991b1b; }
    .btn-delete:hover { background: #fecaca; }
    input { width: 100%; padding: 10px; border: 1px solid #d1d5db; border-radius: 8px; margin-bottom: 15px; font-size: 14px; }
    input:focus { outline: none; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1); }
    .msg { position: fixed; top: 20px; right: 20px; padding: 15px 20px; border-radius: 8px; color: white; display: none; z-index: 9999; font-weight: 600; }
    .msg.success { background: #10b981; }
    .msg.error { background: #ef4444; }
    .msg.show { display: block; animation: slideIn 0.3s ease; }
    @keyframes slideIn { from { transform: translateX(400px); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
    @media (max-width: 1400px) { .container { grid-template-columns: 1fr; } }
</style>

<div id="msg" class="msg"></div>

<div class="container">
    <div class="card">
        <div class="card-title">👔 Staff Members</div>
        <input type="text" id="search" placeholder="🔍 Search...">
        <table>
            <thead>
                <tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Actions</th></tr>
            </thead>
            <tbody id="staffTable">
                <tr><td colspan="5" style="text-align: center; padding: 40px;">Loading...</td></tr>
            </tbody>
        </table>
    </div>
    
    <div class="card">
        <div class="card-title" id="formTitle">➕ Add Staff</div>
        <input type="hidden" id="staffId">
        <input type="hidden" id="mode" value="add">
        <input type="text" id="name" placeholder="Full Name" required>
        <input type="text" id="username" placeholder="Username" required>
        <input type="email" id="email" placeholder="Email" required>
        <input type="password" id="password" placeholder="Password" required>
        <input type="tel" id="phone" placeholder="Phone" required>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
            <button class="btn btn-primary" id="submitBtn"><i class="fas fa-save"></i> Add Staff</button>
            <button class="btn btn-secondary" id="resetBtn"><i class="fas fa-redo"></i> Clear</button>
        </div>
    </div>
</div>

<script>
function showMsg(text, type) {
    const msg = document.getElementById('msg');
    if (!msg) return;
    msg.textContent = text;
    msg.className = 'msg ' + type + ' show';
    setTimeout(() => msg.classList.remove('show'), 4000);
}

function loadStaff() {
    console.log('📥 Loading staff from: ../staff?action=getAll');
    
    fetch('../staff?action=getAll')
        .then(r => {
            console.log('Response status:', r.status);
            return r.json();
        })
        .then(data => {
            console.log('✅ Staff data:', data);
            let html = '';
            if (data && data.length > 0) {
                data.forEach(s => {
                    html += '<tr>';
                    html += '<td><strong>#' + s.id + '</strong></td>';
                    html += '<td>' + s.name + '</td>';
                    html += '<td>' + s.email + '</td>';
                    html += '<td>' + s.phone + '</td>';
                    html += '<td>';
                    html += '<button class="btn btn-small btn-view" onclick="viewStaff(' + s.id + ')" title="View"><i class="fas fa-eye"></i></button>';
                    html += '<button class="btn btn-small btn-edit" onclick="editStaff(' + s.id + ')" title="Edit"><i class="fas fa-edit"></i></button>';
                    html += '<button class="btn btn-small btn-delete" onclick="deleteStaff(' + s.id + ')" title="Delete"><i class="fas fa-trash"></i></button>';
                    html += '</td>';
                    html += '</tr>';
                });
            } else {
                html = '<tr><td colspan="5" style="text-align: center; padding: 40px;">No staff members</td></tr>';
            }
            document.getElementById('staffTable').innerHTML = html;
        })
        .catch(e => {
            console.error('❌ Error loading staff:', e);
            showMsg('❌ Error loading staff', 'error');
            document.getElementById('staffTable').innerHTML = '<tr><td colspan="5" style="text-align: center; padding: 40px;">Error loading staff</td></tr>';
        });
}

function viewStaff(id) {
    console.log('👁️ Viewing staff:', id);
    fetch('../staff?action=getById&id=' + id)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const s = d.staff;
                alert('👤 STAFF DETAILS\n\nID: ' + s.id + '\nName: ' + s.name + '\nUsername: ' + s.username + '\nEmail: ' + s.email + '\nPhone: ' + s.phone);
            } else {
                showMsg('❌ Error loading staff', 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showMsg('❌ Error', 'error');
        });
}

function editStaff(id) {
    console.log('✏️ Editing staff:', id);
    fetch('../staff?action=getById&id=' + id)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const s = d.staff;
                document.getElementById('staffId').value = s.id;
                document.getElementById('mode').value = 'edit';
                document.getElementById('name').value = s.name;
                document.getElementById('username').value = s.username;
                document.getElementById('username').disabled = true;
                document.getElementById('email').value = s.email;
                document.getElementById('phone').value = s.phone;
                document.getElementById('password').value = '';
                document.getElementById('password').required = false;
                document.getElementById('password').placeholder = 'Leave empty to keep current password';
                document.getElementById('formTitle').textContent = '✏️ Edit - ' + s.name;
                document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Update Staff';
                showMsg('📝 Editing: ' + s.name, 'success');
                document.querySelector('.card:last-child').scrollIntoView({ behavior: 'smooth' });
            } else {
                showMsg('❌ Error loading staff', 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showMsg('❌ Error', 'error');
        });
}

function deleteStaff(id) {
    if (!confirm('⚠️ Are you sure you want to delete this staff member?')) return;
    console.log('🗑️ Deleting staff:', id);
    
    // ✅ USE URLSearchParams
    const params = new URLSearchParams();
    params.append('action', 'delete');
    params.append('id', id);
    
    console.log('📤 Sending delete params:', params.toString());
    
    fetch('../staff', { 
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                showMsg('✅ Staff deleted successfully!', 'success');
                loadStaff();
            } else {
                showMsg('❌ ' + (d.message || 'Error deleting'), 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showMsg('❌ Error deleting', 'error');
        });
}

function submitForm() {
    const mode = document.getElementById('mode').value;
    const name = document.getElementById('name').value.trim();
    const username = document.getElementById('username').value.trim();
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value.trim();
    const phone = document.getElementById('phone').value.trim();
    
    console.log('📝 Submitting form:', { mode, name, username, email, phone });
    
    if (!name || !username || !email || !phone) {
        showMsg('❌ All fields required', 'error');
        return;
    }
    if (mode === 'add' && !password) {
        showMsg('❌ Password required for new staff', 'error');
        return;
    }
    
    // ✅ USE URLSearchParams INSTEAD OF FormData
    const params = new URLSearchParams();
    params.append('action', mode === 'add' ? 'add' : 'update');
    params.append('name', name);
    params.append('username', username);
    params.append('email', email);
    params.append('phone', phone);
    if (mode === 'add' || password) params.append('password', password);
    if (mode === 'edit') params.append('id', document.getElementById('staffId').value);
    
    console.log('📤 Sending params:', params.toString());
    
    fetch('../staff', { 
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
        .then(r => {
            console.log('Response status:', r.status);
            return r.json();
        })
        .then(d => {
            console.log('✅ Response:', d);
            if (d.success) {
                showMsg('✅ ' + (d.message || 'Operation successful'), 'success');
                resetForm();
                loadStaff();
            } else {
                showMsg('❌ ' + (d.message || 'Error'), 'error');
            }
        })
        .catch(e => {
            console.error('❌ Error:', e);
            showMsg('❌ Error: ' + e.message, 'error');
        });
}

function resetForm() {
    document.getElementById('staffId').value = '';
    document.getElementById('mode').value = 'add';
    document.getElementById('name').value = '';
    document.getElementById('username').value = '';
    document.getElementById('username').disabled = false;
    document.getElementById('email').value = '';
    document.getElementById('phone').value = '';
    document.getElementById('password').value = '';
    document.getElementById('password').required = true;
    document.getElementById('password').placeholder = 'Password';
    document.getElementById('formTitle').textContent = '➕ Add Staff';
    document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Add Staff';
    showMsg('✅ Form cleared', 'success');
}

document.getElementById('submitBtn').addEventListener('click', submitForm);
document.getElementById('resetBtn').addEventListener('click', resetForm);
document.getElementById('search').addEventListener('keyup', function() {
    const term = this.value.toLowerCase();
    const rows = document.querySelectorAll('#staffTable tr');
    rows.forEach(row => {
        if (!row) return;
        const text = row.textContent || '';
        row.style.display = text.toLowerCase().includes(term) ? '' : 'none';
    });
});

console.log('✅ Staff page loaded');
loadStaff();
</script>
