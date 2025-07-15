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
            padding: 1.5rem 2rem;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            font-size: 1.75rem;
            color: var(--dark-color);
            font-weight: 700;
            margin: 0;
        }

        .breadcrumb {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .task-details {
            background-color: white;
            padding: 2rem;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 2rem;
        }

        .task-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #e3e6f0;
        }

        .task-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .task-info {
            display: flex;
            flex-direction: column;
            padding: 0.75rem;
            background-color: #f8f9fc;
            border-radius: 0.25rem;
            border-left: 4px solid var(--primary-color);
        }

        .task-info strong {
            color: var(--dark-color);
            font-weight: 600;
            margin-bottom: 0.25rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .task-info-value {
            color: #333;
            font-size: 1rem;
        }

        .task-description {
            background-color: #f8f9fc;
            padding: 1.5rem;
            border-radius: 0.35rem;
            border-left: 4px solid var(--secondary-color);
        }

        .task-description strong {
            display: block;
            color: var(--dark-color);
            font-weight: 600;
            margin-bottom: 0.75rem;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .applications-section {
            background-color: white;
            padding: 2rem;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 2rem;
        }

        .applications-section h3 {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid #e3e6f0;
        }

        .application-card {
            background-color: #f8f9fc;
            border: 1px solid #e3e6f0;
            border-radius: 0.35rem;
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }

        .application-card:hover {
            box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }

        .application-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .application-info {
            display: flex;
            flex-direction: column;
        }

        .application-info strong {
            color: var(--dark-color);
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }

        .application-message {
            grid-column: 1 / -1;
            background-color: white;
            padding: 1rem;
            border-radius: 0.25rem;
            border-left: 3px solid var(--primary-color);
        }

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-accepted {
            background-color: #d4edda;
            color: #155724;
        }

        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }

        .task-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #e3e6f0;
        }
        
        .btn {
            padding: 0.5rem 1rem;
            border-radius: 0.35rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
            cursor: pointer;
            border: none;
            font-size: 0.875rem;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #2e59d9;
            transform: translateY(-1px);
            box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.2);
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #545b62;
            transform: translateY(-1px);
        }
        
        .btn-accept {
            background-color: var(--success-color);
            color: white;
        }

        .btn-accept:hover {
            background-color: #218838;
            transform: translateY(-1px);
        }
        
        .btn-reject {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-reject:hover {
            background-color: #be2617;
            transform: translateY(-1px);
        }
        
        .btn-disabled {
            background-color: #ccc;
            color: #666;
            cursor: not-allowed;
            pointer-events: none;
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
            font-size: 1.25rem;
        }

        .no-applications {
            text-align: center;
            padding: 2rem;
            color: var(--dark-color);
            font-style: italic;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            flex-wrap: wrap;
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

        /* Responsive design */
        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .task-info-grid {
                grid-template-columns: 1fr;
            }

            .application-info-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .task-actions {
                flex-direction: column;
            }

            .breadcrumb {
                justify-content: center;
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="menu">
                <h2>JobLinks</h2>
            </div>
            <div class="nav">
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
    </div>

    <div class="main-content">
        <div class="container">
            <div class="page-header">
                <h1><i class="fas fa-info-circle"></i> Chi Tiết Công Việc</h1>
                <div class="breadcrumb">
                    <a href="tasks" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại Danh Sách
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
                        <i class="fas fa-briefcase"></i>
                        <%= task.getTitle() != null ? task.getTitle() : "Không có tiêu đề" %>
                    </h2>
                    
                    <div class="task-info-grid">
                        <div class="task-info">
                            <strong><i class="fas fa-user"></i> Khách hàng</strong>
                            <span class="task-info-value"><%= task.getClientName() != null ? task.getClientName() : "Không xác định" %></span>
                        </div>
                        
                        <% if (task.getCategoryName() != null) { %>
                        <div class="task-info">
                            <strong><i class="fas fa-tags"></i> Danh mục</strong>
                            <span class="task-info-value"><%= task.getCategoryName() %></span>
                        </div>
                        <% } %>
                        
                        <div class="task-info">
                            <strong><i class="fas fa-map-marker-alt"></i> Địa điểm</strong>
                            <span class="task-info-value"><%= task.getLocation() != null ? task.getLocation() : "Không xác định" %></span>
                        </div>
                        
                        <% if (task.getScheduledTime() != null) { %>
                        <div class="task-info">
                            <strong><i class="fas fa-clock"></i> Thời gian dự kiến</strong>
                            <span class="task-info-value"><%= new SimpleDateFormat("dd/MM/yyyy HH:mm").format(task.getScheduledTime()) %></span>
                        </div>
                        <% } %>
                        
                        <div class="task-info">
                            <strong><i class="fas fa-dollar-sign"></i> Ngân sách</strong>
                            <span class="task-info-value"><%= String.format("%.2f", task.getBudget()) %> VNĐ</span>
                        </div>
                        
                        <div class="task-info">
                            <strong><i class="fas fa-info-circle"></i> Trạng thái</strong>
                            <span class="task-info-value">
                                <span class="status-badge status-<%= task.getStatus() != null ? task.getStatus().toLowerCase() : "pending" %>">
                                    <%= task.getStatus() != null ? task.getStatus() : "N/A" %>
                                </span>
                            </span>
                        </div>
                        
                        <% if (hasApplied != null && hasApplied) { %>
                        <div class="task-info">
                            <strong><i class="fas fa-check-circle"></i> Trạng thái ứng tuyển</strong>
                            <span class="task-info-value">
                                <span class="status-badge status-accepted">Đã ứng tuyển</span>
                            </span>
                        </div>
                        <% } %>
                    </div>
                    
                    <div class="task-description">
                        <strong><i class="fas fa-file-text"></i> Mô tả công việc</strong>
                        <div class="task-info-value">
                            <%= task.getDescription() != null ? task.getDescription().replace("\n", "<br>") : "Không có mô tả" %>
                        </div>
                    </div>
                </div>

                <!-- Danh sách ứng viên -->
                <% if (userId != null && task.getUserId() == userId.intValue()) { %>
                    <div class="applications-section">
                        <h3><i class="fas fa-users"></i> Danh sách ứng viên</h3>
                        
                        <% if (applications != null && !applications.isEmpty()) { %>
                            <% for (TaskApplication app : applications) { %>
                                <div class="application-card">
                                    <div class="application-info-grid">
                                        <div class="application-info">
                                            <strong><i class="fas fa-user"></i> Tên</strong>
                                            <span><%= app.getWorkerName() != null ? app.getWorkerName() : "Không rõ" %></span>
                                        </div>
                                        
                                        <div class="application-info">
                                            <strong><i class="fas fa-envelope"></i> Email</strong>
                                            <span><%= app.getWorkerEmail() != null ? app.getWorkerEmail() : "Không rõ" %></span>
                                        </div>
                                        
                                        <div class="application-info">
                                            <strong><i class="fas fa-phone"></i> Số điện thoại</strong>
                                            <span><%= app.getWorkerPhone() != null ? app.getWorkerPhone() : "Không rõ" %></span>
                                        </div>
                                        
                                        <div class="application-info">
                                            <strong><i class="fas fa-info-circle"></i> Trạng thái</strong>
                                            <span class="status-badge status-<%= app.getStatus() != null ? app.getStatus().toLowerCase() : "pending" %>">
                                                <%= app.getStatus() != null ? app.getStatus() : "Chưa rõ" %>
                                            </span>
                                        </div>
                                        
                                        <div class="application-info">
                                            <strong><i class="fas fa-calendar"></i> Ngày ứng tuyển</strong>
                                            <span><%= app.getAppliedAt() != null ? new SimpleDateFormat("dd/MM/yyyy HH:mm").format(app.getAppliedAt()) : "Chưa rõ" %></span>
                                        </div>
                                        
                                        <div class="application-message">
                                            <strong><i class="fas fa-comment"></i> Lời nhắn</strong>
                                            <p style="margin-top: 0.5rem; margin-bottom: 0;">
                                                <%= app.getMessage() != null ? app.getMessage() : "Không có lời nhắn" %>
                                            </p>
                                        </div>
                                    </div>
                                    
                                    <% if ("pending".equalsIgnoreCase(app.getStatus())) { %>
                                        <div class="task-actions">
                                            <form action="${pageContext.request.contextPath}/tasks" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="accept">
                                                <input type="hidden" name="application_id" value="<%= app.getApplicationId() %>">
                                                <input type="hidden" name="taskId" value="<%= task.getTaskId() %>">
                                                <button type="submit" class="btn btn-accept">
                                                    <i class="fas fa-check"></i> Chấp nhận
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/tasks" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="reject">
                                                <input type="hidden" name="application_id" value="<%= app.getApplicationId() %>">
                                                <input type="hidden" name="taskId" value="<%= task.getTaskId() %>">
                                                <button type="submit" class="btn btn-reject">
                                                    <i class="fas fa-times"></i> Từ chối
                                                </button>
                                            </form>
                                        </div>
                                    <% } %>
                                </div>
                            <% } %>
                        <% } else { %>
                            <div class="no-applications">
                                <i class="fas fa-users" style="font-size: 3rem; color: #ccc; margin-bottom: 1rem;"></i>
                                <p>Chưa có ứng viên nào ứng tuyển cho công việc này.</p>
                            </div>
                        <% } %>
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
                        }
                    %>
                </div>
            <% } %>
        </div>
    </div>

    <div class="footer">
        <div class="container">
            <p>&copy; 2024 JobLinks. All rights reserved.</p>
        </div>
    </div>
</body>
</html>
