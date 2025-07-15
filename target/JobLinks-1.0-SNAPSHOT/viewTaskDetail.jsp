<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Task" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="model.TaskApplication" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% Logger logger = Logger.getLogger("taskDetails"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Công Việc - JobLinks</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --danger-color: #e74a3b;
            --warning-color: #f6c23e;
            --light-color: #f8f9fc;
            --dark-color: #5a5c69;
            --success-color: #28a745;
            --info-color: #17a2b8;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fc;
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        /* Header styles */
        .header {
            background-color: white;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(44, 62, 80, 0.15);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .logo-img {
            height: 40px;
        }

        .menu {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .greeting {
            font-weight: 500;
            color: #2c3e50;
            margin-right: 20px;
        }

        .nav {
            display: flex;
            gap: 15px;
        }

        .nav-link {
            color: #2c3e50;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: color 0.3s;
            border-radius: 0.35rem;
        }

        .nav-link.active, .nav-link:hover {
            color: #3498db;
            background-color: #ecf0f1;
        }

        .header-actions, .dropdown {
            margin-left: auto;
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-toggle {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.5rem;
            color: #2c3e50;
            padding: 0.5rem;
            border-radius: 0.35rem;
            transition: background-color 0.3s;
        }

        .dropdown-toggle:hover {
            background-color: #ecf0f1;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            border-radius: 0.35rem;
            min-width: 200px;
            z-index: 1000;
        }

        .dropdown-menu.show {
            display: block;
        }

        .dropdown-item {
            display: block;
            padding: 0.5rem 1rem;
            color: #2c3e50;
            text-decoration: none;
            font-size: 0.9rem;
            transition: background-color 0.3s;
        }

        .dropdown-item:hover {
            background-color: #ecf0f1;
            color: #3498db;
        }
        
        /* Main content styles */
        .main-content {
            flex: 1;
            padding: 2rem 0;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-header {
            background-color: white;
            padding: 2rem;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 2rem;
            text-align: center;
        }

        .page-header h1 {
            font-size: 2rem;
            color: var(--dark-color);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .breadcrumb {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 1rem;
        }

        .breadcrumb .nav-link {
            background-color: var(--light-color);
            color: var(--primary-color);
            padding: 0.5rem 1rem;
            border-radius: 0.35rem;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }

        .breadcrumb .nav-link:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-1px);
        }
        
        .task-details {
            background-color: white;
            padding: 2rem;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 2rem;
        }
        
        .task-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 0.5rem;
        }
        
        .task-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .task-info {
            background-color: var(--light-color);
            padding: 1rem;
            border-radius: 0.35rem;
            border-left: 4px solid var(--primary-color);
        }

        .task-info strong {
            color: var(--dark-color);
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .task-info .value {
            color: #495057;
            font-size: 0.95rem;
        }

        .task-description {
            background-color: #fff;
            border: 1px solid #e3e6f0;
            padding: 1.5rem;
            border-radius: 0.35rem;
            margin-top: 1rem;
        }

        .task-description strong {
            color: var(--dark-color);
            font-size: 1.1rem;
            margin-bottom: 1rem;
            display: block;
        }

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 0.25rem;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-in-progress {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-applied {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        
        .applications-section {
            background-color: white;
            padding: 2rem;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 2rem;
        }

        .applications-section h3 {
            font-size: 1.5rem;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            border-bottom: 2px solid var(--secondary-color);
            padding-bottom: 0.5rem;
        }
        
        .application-card {
            border: 1px solid #e3e6f0;
            border-radius: 0.35rem;
            padding: 1.5rem;
            margin-bottom: 1rem;
            background-color: var(--light-color);
            transition: all 0.3s;
        }

        .application-card:hover {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transform: translateY(-2px);
        }

        .application-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .application-info-item {
            background-color: white;
            padding: 0.75rem;
            border-radius: 0.25rem;
            border-left: 3px solid var(--info-color);
        }

        .application-info-item strong {
            color: var(--dark-color);
            font-size: 0.9rem;
            display: block;
            margin-bottom: 0.25rem;
        }

        .application-info-item .value {
            color: #495057;
            font-size: 0.9rem;
        }

        .task-actions {
            display: flex;
            gap: 0.5rem;
            justify-content: flex-end;
            margin-top: 1rem;
        }
        
        .btn {
            padding: 0.6rem 1.2rem;
            border-radius: 0.35rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s;
            cursor: pointer;
            border: none;
            font-size: 0.9rem;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #2e59d9;
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(78, 115, 223, 0.3);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
        }
        
        .btn-success {
            background-color: var(--success-color);
            color: white;
        }

        .btn-success:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-danger:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }
        
        .btn-disabled {
            background-color: #e9ecef;
            color: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .btn-disabled:hover {
            transform: none;
            box-shadow: none;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }
        
        .alert {
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: 0.35rem;
            border-left: 4px solid;
        }
        
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border-left-color: var(--danger-color);
        }

        .alert h2 {
            margin-bottom: 0.5rem;
            font-size: 1.3rem;
        }

        .no-applications {
            text-align: center;
            padding: 2rem;
            color: var(--dark-color);
            font-style: italic;
        }
        
        /* Footer styles */
        .footer {
            background-color: #2c3e50;
            color: white;
            padding: 1.5rem;
            text-align: center;
            margin-top: auto;
        }

        .footer .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            box-shadow: none;
            background-color: transparent;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 1.5rem;
        }

        .footer-col h3 {
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }

        .footer-links, .footer-contact {
            list-style: none;
            padding: 0;
        }

        .footer-links li, .footer-contact li {
            margin-bottom: 0.5rem;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: #3498db;
        }

        .social-links a {
            color: white;
            margin: 0 10px;
            font-size: 1.2rem;
            transition: color 0.3s;
        }

        .social-links a:hover {
            color: #3498db;
        }

        .newsletter-form {
            display: flex;
            gap: 10px;
        }

        .form-control {
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 0.35rem;
            flex: 1;
        }

        .footer-bottom {
            border-top: 1px solid #34495e;
            padding-top: 1rem;
            margin-top: 1rem;
        }

        .footer-legal a {
            color: white;
            margin: 0 10px;
            text-decoration: none;
        }

        .footer-legal a:hover {
            color: #3498db;
        }

        .back-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border-radius: 50%;
            text-decoration: none;
            display: none;
            transition: all 0.3s;
        }

        .back-to-top.show {
            display: block;
        }

        .back-to-top:hover {
            background-color: #2980b9;
            transform: scale(1.1);
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
            }

            .task-info-grid {
                grid-template-columns: 1fr;
            }

            .application-info {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }

            .page-header h1 {
                font-size: 1.5rem;
            }

            .breadcrumb {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <%@include file="jobPosterHeader.jsp" %>
    
    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <h1><i class="fas fa-briefcase"></i> Chi Tiết Công Việc</h1>
                <div class="breadcrumb">
                    <a href="tasks" class="nav-link">
                        <i class="fas fa-list"></i> Danh Sách Công Việc
                    </a>
                    <a href="tasks?action=applied" class="nav-link">
                        <i class="fas fa-file-alt"></i> Đơn Ứng Tuyển Của Tôi
                    </a>
                    <a href="${pageContext.request.contextPath}/home" class="nav-link">
                        <i class="fas fa-home"></i> Trang Chủ
                    </a>
                </div>
            </div>

            <% 
                Task task = (Task) request.getAttribute("task");
                String errorMessage = (String) request.getAttribute("error");
                Boolean hasApplied = (Boolean) request.getAttribute("hasApplied");
                Integer userId = (Integer) session.getAttribute("userId");
                List<TaskApplication> applications = (List<TaskApplication>) request.getAttribute("applications");
                logger.info("Task from request attribute: " + (task != null ? task.getTitle() : "null"));
            %>

            <% if (errorMessage != null || task == null) { %>
                <div class="alert alert-error">
                    <h2><i class="fas fa-exclamation-triangle"></i> Lỗi!</h2>
                    <p>Đã xảy ra lỗi khi xử lý yêu cầu của bạn.</p>
                    <p><strong>Thông báo lỗi:</strong> <%= errorMessage != null ? errorMessage : "Công việc không tồn tại." %></p>
                    <div style="margin-top: 1rem;">
                        <a href="tasks" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại Danh Sách Công Việc
                        </a>
                    </div>
                </div>
            <% } else { %>
                <div class="task-details">
                    <h2 class="task-title">
                        <i class="fas fa-tasks"></i> 
                        <%= task.getTitle() != null ? task.getTitle() : "Không có tiêu đề" %>
                    </h2>
                    
                    <div class="task-info-grid">
                        <div class="task-info">
                            <strong><i class="fas fa-user"></i> Khách hàng:</strong>
                            <div class="value"><%= task.getClientName() != null ? task.getClientName() : "Không xác định" %></div>
                        </div>
                        
                        <% if (task.getCategoryName() != null) { %>
                        <div class="task-info">
                            <strong><i class="fas fa-tags"></i> Danh mục:</strong>
                            <div class="value"><%= task.getCategoryName() %></div>
                        </div>
                        <% } %>
                        
                        <div class="task-info">
                            <strong><i class="fas fa-map-marker-alt"></i> Địa điểm:</strong>
                            <div class="value"><%= task.getLocation() != null ? task.getLocation() : "Không xác định" %></div>
                        </div>
                        
                        <% if (task.getScheduledTime() != null) { %>
                        <div class="task-info">
                            <strong><i class="fas fa-clock"></i> Thời gian dự kiến:</strong>
                            <div class="value"><%= new SimpleDateFormat("dd/MM/yyyy HH:mm").format(task.getScheduledTime()) %></div>
                        </div>
                        <% } %>
                        
                        <div class="task-info">
                            <strong><i class="fas fa-money-bill-wave"></i> Ngân sách:</strong>
                            <div class="value"><%= String.format("%.2f", task.getBudget()) %> VNĐ</div>
                        </div>
                        
                        <div class="task-info">
                            <strong><i class="fas fa-info-circle"></i> Trạng thái:</strong>
                            <div class="value">
                                <span class="status-badge status-<%= task.getStatus() != null ? task.getStatus().toLowerCase().replace("_", "-") : "pending" %>">
                                    <%= task.getStatus() != null ? task.getStatus() : "N/A" %>
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <% if (hasApplied != null && hasApplied) { %>
                    <div class="task-info" style="margin-top: 1rem;">
                        <strong><i class="fas fa-check-circle"></i> Trạng thái ứng tuyển:</strong>
                        <div class="value">
                            <span class="status-badge status-applied">Đã ứng tuyển</span>
                        </div>
                    </div>
                    <% } %>
                    
                    <div class="task-description">
                        <strong><i class="fas fa-file-alt"></i> Mô tả:</strong>
                        <div><%= task.getDescription() != null ? task.getDescription().replace("\n", "<br>") : "Không có mô tả" %></div>
                    </div>
                </div>

                <!-- Applications Section -->
                <% if (userId != null && task.getUserId() == userId.intValue() && applications != null && !applications.isEmpty()) { %>
                    <div class="applications-section">
                        <h3><i class="fas fa-users"></i> Danh sách ứng viên (<%= applications.size() %> ứng viên)</h3>
                        <% for (TaskApplication app : applications) { %>
                            <div class="application-card">
                                <div class="application-info">
                                    <div class="application-info-item">
                                        <strong><i class="fas fa-user"></i> Tên:</strong>
                                        <div class="value"><%= app.getWorkerName() != null ? app.getWorkerName() : "Không rõ" %></div>
                                    </div>
                                    
                                    <div class="application-info-item">
                                        <strong><i class="fas fa-envelope"></i> Email:</strong>
                                        <div class="value"><%= app.getWorkerEmail() != null ? app.getWorkerEmail() : "Không rõ" %></div>
                                    </div>
                                    
                                    <div class="application-info-item">
                                        <strong><i class="fas fa-phone"></i> Số điện thoại:</strong>
                                        <div class="value"><%= app.getWorkerPhone() != null ? app.getWorkerPhone() : "Không rõ" %></div>
                                    </div>
                                    
                                    <div class="application-info-item">
                                        <strong><i class="fas fa-calendar"></i> Ngày ứng tuyển:</strong>
                                        <div class="value"><%= app.getAppliedAt() != null ? new SimpleDateFormat("dd/MM/yyyy HH:mm").format(app.getAppliedAt()) : "Chưa rõ" %></div>
                                    </div>
                                </div>
                                
                                <div class="application-info-item" style="margin-top: 1rem;">
                                    <strong><i class="fas fa-comment"></i> Lời nhắn:</strong>
                                    <div class="value"><%= app.getMessage() != null ? app.getMessage() : "Không có lời nhắn" %></div>
                                </div>
                                
                                <div class="application-info-item">
                                    <strong><i class="fas fa-info-circle"></i> Trạng thái:</strong>
                                    <div class="value">
                                        <span class="status-badge status-<%= app.getStatus() != null ? app.getStatus().toLowerCase() : "pending" %>">
                                            <%= app.getStatus() != null ? app.getStatus() : "Chưa rõ" %>
                                        </span>
                                    </div>
                                </div>
                                
                                <% if ("pending".equalsIgnoreCase(app.getStatus())) { %>
                                    <div class="task-actions">
                                        <form action="${pageContext.request.contextPath}/tasks" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="accept">
                                            <input type="hidden" name="application_id" value="<%= app.getApplicationId() %>">
                                            <input type="hidden" name="taskId" value="<%= task.getTaskId() %>">
                                            <button type="submit" class="btn btn-success">
                                                <i class="fas fa-check"></i> Chấp nhận
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/tasks" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="reject">
                                            <input type="hidden" name="application_id" value="<%= app.getApplicationId() %>">
                                            <input type="hidden" name="taskId" value="<%= task.getTaskId() %>">
                                            <button type="submit" class="btn btn-danger">
                                                <i class="fas fa-times"></i> Từ chối
                                            </button>
                                        </form>
                                    </div>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                <% } else if (userId != null && task.getUserId() == userId.intValue() && (applications == null || applications.isEmpty())) { %>
                    <div class="applications-section">
                        <h3><i class="fas fa-users"></i> Danh sách ứng viên</h3>
                        <div class="no-applications">
                            <i class="fas fa-user-slash" style="font-size: 3rem; color: #6c757d; margin-bottom: 1rem;"></i>
                            <p>Chưa có ứng viên nào ứng tuyển cho công việc này.</p>
                        </div>
                    </div>
                <% } %>

                <div class="action-buttons">
                    <a href="tasks" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại Danh Sách Công Việc
                    </a>
                    <% 
                        boolean isTaskOwner = userId != null && task.getUserId() == userId.intValue();
                        if (hasApplied == null || !hasApplied) {
                            if (isTaskOwner) { %>
                                <span class="btn btn-disabled" title="Bạn không thể ứng tuyển cho công việc của chính mình">
                                    <i class="fas fa-ban"></i> Ứng Tuyển Ngay
                                </span>
                            <% } else { %>
                                <a href="applyTask.jsp?task_id=<%= task.getTaskId() %>" class="btn btn-primary">
                                    <i class="fas fa-paper-plane"></i> Ứng Tuyển Ngay
                                </a>
                            <% }
                        } else { %>
                            <span class="btn btn-success">
                                <i class="fas fa-check-circle"></i> Đã Ứng Tuyển
                            </span>
                        <% }
                    %>
                </div>
            <% } %>
        </div>
    </div>

    <%@include file="jobPosterFooter.jsp" %>

    <a href="#" class="back-to-top" id="backToTop">
        <i class="fas fa-chevron-up"></i>
    </a>

    <script>
      // Dropdown functionality
window.addEventListener('load', function() {
    let attempts = 0;
    const maxAttempts = 10;
    
    function initDropdown() {
        const dropdownButton = document.getElementById('dropdownMenuButton');
        const dropdownMenu = document.getElementById('dropdownMenu');
        
        if (dropdownButton && dropdownMenu) {
            dropdownButton.removeEventListener('click', toggleDropdown);
            dropdownButton.addEventListener('click', toggleDropdown);

            document.removeEventListener('click', closeDropdownOnClickOutside);
            document.addEventListener('click', closeDropdownOnClickOutside);
            
            console.log('Dropdown initialized successfully');
            return true;
        } else {
            attempts++;
            if (attempts < maxAttempts) {
                console.log('Dropdown elements not found, retrying... (attempt ' + attempts + ')');
                setTimeout(initDropdown, 500);
            } else {
                console.log('Failed to initialize dropdown after ' + maxAttempts + ' attempts');
            }
            return false;
        }
    }
    
    function toggleDropdown(e) {
        e.preventDefault();
        e.stopPropagation();
        const dropdownMenu = document.getElementById('dropdownMenu');
        if (dropdownMenu) {
            dropdownMenu.classList.toggle('show');
        }
    }
    
    function closeDropdownOnClickOutside(e) {
        const dropdownMenu = document.getElementById('dropdownMenu');
        const dropdownButton = document.getElementById('dropdownMenuButton');
        
        if (dropdownMenu && dropdownButton && 
            !dropdownButton.contains(e.target) && 
            !dropdownMenu.contains(e.target)) {
            dropdownMenu.classList.remove('show');
        }
    }
    
    // Initialize dropdown
    initDropdown();
});

// Back to top button functionality
document.addEventListener('DOMContentLoaded', function() {
    const backToTopButton = document.getElementById('backToTop');
    
    if (backToTopButton) {
        // Show/hide back to top button based on scroll position
        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                backToTopButton.classList.add('show');
            } else {
                backToTopButton.classList.remove('show');
            }
        });
        
        // Smooth scroll to top when clicked
        backToTopButton.addEventListener('click', function(e) {
            e.preventDefault();
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }
});

// Form submission confirmations
document.addEventListener('DOMContentLoaded', function() {
    // Accept application confirmation
    const acceptForms = document.querySelectorAll('form[action*="accept"]');
    acceptForms.forEach(form => {
        form.addEventListener('submit', function(e) {
            const confirmed = confirm('Bạn có chắc chắn muốn chấp nhận ứng viên này không?');
            if (!confirmed) {
                e.preventDefault();
            }
        });
    });
    
    // Reject application confirmation
    const rejectForms = document.querySelectorAll('form[action*="reject"]');
    rejectForms.forEach(form => {
        form.addEventListener('submit', function(e) {
            const confirmed = confirm('Bạn có chắc chắn muốn từ chối ứng viên này không?');
            if (!confirmed) {
                e.preventDefault();
            }
        });
    });
});

// Enhanced animations and interactions
document.addEventListener('DOMContentLoaded', function() {
    // Add loading states to buttons
    const submitButtons = document.querySelectorAll('button[type="submit"]');
    submitButtons.forEach(button => {
        button.addEventListener('click', function() {
            const originalText = this.innerHTML;
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
            this.disabled = true;
            
            // Re-enable button after form submission (in case of validation errors)
            setTimeout(() => {
                this.innerHTML = originalText;
                this.disabled = false;
            }, 3000);
        });
    });
    
    // Smooth animations for application cards
    const applicationCards = document.querySelectorAll('.application-card');
    applicationCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
            this.style.boxShadow = '0 0.5rem 2rem rgba(58, 59, 69, 0.2)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(-2px)';
            this.style.boxShadow = '0 0.15rem 1.75rem rgba(58, 59, 69, 0.1)';
        });
    });
    
    // Auto-hide alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            alert.style.transition = 'opacity 0.5s ease';
            setTimeout(() => {
                alert.style.display = 'none';
            }, 500);
        }, 5000);
    });
});

// Responsive navigation handling
document.addEventListener('DOMContentLoaded', function() {
    // Handle mobile menu if needed
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    const nav = document.querySelector('.nav');
    
    if (mobileMenuToggle && nav) {
        mobileMenuToggle.addEventListener('click', function() {
            nav.classList.toggle('show');
        });
    }
    
    // Close mobile menu when clicking outside
    document.addEventListener('click', function(e) {
        if (nav && mobileMenuToggle && 
            !nav.contains(e.target) && 
            !mobileMenuToggle.contains(e.target)) {
            nav.classList.remove('show');
        }
    });
});

// Form validation enhancement
document.addEventListener('DOMContentLoaded', function() {
    // Add real-time validation feedback
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            const requiredFields = this.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    field.style.borderColor = '#e74a3b';
                    field.style.boxShadow = '0 0 0 0.2rem rgba(231, 74, 59, 0.25)';
                    isValid = false;
                } else {
                    field.style.borderColor = '#28a745';
                    field.style.boxShadow = '0 0 0 0.2rem rgba(40, 167, 69, 0.25)';
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                // Show error message
                showNotification('Vui lòng điền đầy đủ thông tin bắt buộc.', 'error');
            }
        });
    });
});

// Notification system
function showNotification(message, type = 'info') {
    // Remove existing notifications
    const existingNotifications = document.querySelectorAll('.notification');
    existingNotifications.forEach(notification => notification.remove());
    
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
        <div class="notification-content">
            <i class="fas fa-${getNotificationIcon(type)}"></i>
            <span>${message}</span>
            <button class="notification-close" onclick="this.parentElement.parentElement.remove()">
                <i class="fas fa-times"></i>
            </button>
        </div>
    `;
    
    // Add styles
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${getNotificationColor(type)};
        color: white;
        padding: 1rem;
        border-radius: 0.35rem;
        box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.3);
        z-index: 1050;
        min-width: 300px;
        animation: slideInRight 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    // Auto-remove after 5 seconds
    setTimeout(() => {
        if (notification.parentElement) {
            notification.style.animation = 'slideOutRight 0.3s ease';
            setTimeout(() => notification.remove(), 300);
        }
    }, 5000);
}

function getNotificationIcon(type) {
    switch(type) {
        case 'success': return 'check-circle';
        case 'error': return 'exclamation-triangle';
        case 'warning': return 'exclamation-circle';
        default: return 'info-circle';
    }
}

function getNotificationColor(type) {
    switch(type) {
        case 'success': return '#28a745';
        case 'error': return '#e74a3b';
        case 'warning': return '#f6c23e';
        default: return '#17a2b8';
    }
}

// Add CSS animations
const style = document.createElement('style');
style.textContent = `
    @keyframes slideInRight {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOutRight {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
    
    .notification-content {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .notification-close {
        background: none;
        border: none;
        color: white;
        cursor: pointer;
        margin-left: auto;
        padding: 0.25rem;
        border-radius: 0.25rem;
        transition: background-color 0.3s;
    }
    
    .notification-close:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }
`;
document.head.appendChild(style);

// Page performance monitoring
document.addEventListener('DOMContentLoaded', function() {
    // Log page load time
    window.addEventListener('load', function() {
        const loadTime = performance.now();
        console.log('Page loaded in ' + Math.round(loadTime) + 'ms');
        
        // Show notification if page loads slowly
        if (loadTime > 3000) {
            showNotification('Trang tải chậm. Vui lòng kiểm tra kết nối mạng.', 'warning');
        }
    });
    
    // Monitor for JavaScript errors
    window.addEventListener('error', function(e) {
        console.error('JavaScript error:', e.error);
        showNotification('Đã xảy ra lỗi. Vui lòng tải lại trang.', 'error');
    });
});

// Accessibility improvements
document.addEventListener('DOMContentLoaded', function() {
    // Add keyboard navigation support
    document.addEventListener('keydown', function(e) {
        // ESC key to close dropdowns
        if (e.key === 'Escape') {
            const dropdownMenu = document.getElementById('dropdownMenu');
            if (dropdownMenu && dropdownMenu.classList.contains('show')) {
                dropdownMenu.classList.remove('show');
            }
        }
        
        // Enter key for buttons
        if (e.key === 'Enter' && e.target.classList.contains('btn')) {
            e.target.click();
        }
    });
    
    // Add focus indicators
    const focusableElements = document.querySelectorAll('button, a, input, textarea, select');
    focusableElements.forEach(element => {
        element.addEventListener('focus', function() {
            this.style.outline = '2px solid #4e73df';
            this.style.outlineOffset = '2px';
        });
        
        element.addEventListener('blur', function() {
            this.style.outline = 'none';
        });
    });
});

console.log('Task Details page JavaScript loaded successfully');