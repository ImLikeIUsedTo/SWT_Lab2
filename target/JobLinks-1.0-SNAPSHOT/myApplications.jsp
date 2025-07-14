<%@ page import="model.Task" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Theo dõi công việc - JobLinks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }
        .section-title {
            font-size: 22px;
            font-weight: bold;
            color: #333;
            margin: 30px 0 15px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
        }
        .task-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .task-card {
            position: relative; /* Thêm để định vị nút X */
            background: #f9f9f9;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 8px;
            transition: transform 0.2s;
        }
        .task-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .task-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        .task-info {
            margin-bottom: 8px;
            color: #555;
            font-size: 14px;
        }
        .task-info strong {
            color: #222;
        }
        .task-actions {
            margin-top: 10px;
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            color: white;
            text-align: center;
        }
        .btn-view {
            background-color: #007bff;
        }
        .btn-cancel {
            background-color: #dc3545;
        }
        .btn-view-applications {
            background-color: #28a745;
        }
        .btn-add-task {
            background-color: #007bff;
        }
        .btn-delete {
            background-color: #ff4444;
        }
        .delete-icon {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #ff4444;
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 12px;
            line-height: 1;
        }
        .delete-icon:hover {
            background: #cc0000;
        }
        .empty-state {
            text-align: center;
            padding: 20px;
            color: #666;
        }
        .alert {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 14px;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }
    </style>
</head>
<body>
<div class="container">
    <%
        String error = (String) request.getAttribute("error");
        String success = (String) request.getAttribute("success");
        if (error != null) {
    %>
        <div class="alert alert-error"><%= error %></div>
    <%
        }
        if (success != null) {
    %>
        <div class="alert alert-success"><%= success %></div>
    <%
        }
    %>

    <div class="section-title">Công việc tôi đã ứng tuyển</div>
    <% List<Task> tasks = (List<Task>) request.getAttribute("tasks"); %>
    <% if (tasks == null || tasks.isEmpty()) { %>
        <div class="empty-state">
            <p>Bạn chưa ứng tuyển công việc nào.</p>
        </div>
    <% } else { %>
        <div class="task-grid">
            <% for (Task task : tasks) { %>
                <div class="task-card">
                    <% if ("cancelled".equalsIgnoreCase(task.getApplicationStatus())) { %>
                        <form action="${pageContext.request.contextPath}/tasks" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="application_id" value="<%= task.getApplicationId() %>">
                            <button type="submit" class="delete-icon" onclick="return confirm('Bạn có chắc muốn xóa ứng tuyển này không?')">X</button>
                        </form>
                    <% } %>
                    <div class="task-title"><%= task.getTitle() != null ? task.getTitle() : "Không có tiêu đề" %></div>
                    <div class="task-info"><strong>Mô tả:</strong> <%= task.getDescription() != null ? task.getDescription() : "Không có mô tả" %></div>
                    <div class="task-info"><strong>Trạng thái ứng tuyển:</strong> <%= task.getApplicationStatus() != null ? task.getApplicationStatus() : "Chưa rõ" %></div>
                    <div class="task-info"><strong>Ngày ứng tuyển:</strong> <%= task.getAppliedAt() != null ? new SimpleDateFormat("dd/MM/yyyy HH:mm").format(task.getAppliedAt()) : "Chưa rõ" %></div>
                    <div class="task-actions">
                        <a href="${pageContext.request.contextPath}/tasks?action=details&taskId=<%= task.getTaskId() %>" class="btn btn-view">Xem chi tiết</a>
                        <% if ("pending".equalsIgnoreCase(task.getApplicationStatus())) { %>
                            <form action="${pageContext.request.contextPath}/tasks" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="application_id" value="<%= task.getApplicationId() %>">
                                <button type="submit" class="btn btn-cancel" onclick="return confirm('Bạn có chắc muốn hủy ứng tuyển này không?')">Hủy ứng tuyển</button>
                            </form>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>

    <div class="section-title">Công việc tôi đã đăng</div>
    <% List<Task> postedTasks = (List<Task>) request.getAttribute("postedTasks"); %>
    <% if (postedTasks == null || postedTasks.isEmpty()) { %>
        <div class="empty-state">
            <p>Bạn chưa đăng công việc nào.</p>
            <p><a href="tasks" class="btn btn-add-task">Đăng công việc mới</a></p>
        </div>
    <% } else { %>
        <div class="task-grid">
            <% for (Task task : postedTasks) { %>
                <div class="task-card">
                    <div class="task-title"><%= task.getTitle() != null ? task.getTitle() : "Không có tiêu đề" %></div>
                    <div class="task-info"><strong>Trạng thái:</strong> <%= task.getStatus() != null ? task.getStatus() : "Chưa rõ" %></div>
                    <% if (task.getCategoryName() != null) { %>
                        <div class="task-info"><strong>Danh mục:</strong> <%= task.getCategoryName() %></div>
                    <% } %>
                    <div class="task-info"><strong>Ngày đăng:</strong> <%= task.getCreatedAt() != null ? new SimpleDateFormat("dd/MM/yyyy HH:mm").format(task.getCreatedAt()) : "Chưa rõ" %></div>
                    <div class="task-info"><strong>Số lượng ứng tuyển:</strong> <%= task.getApplicationCount() != null ? task.getApplicationCount() : 0 %></div>
                    <div class="task-actions">
                        <% if (task.getApplicationCount() != null && task.getApplicationCount() > 0) { %>
                            <a href="${pageContext.request.contextPath}/tasks?action=details&taskId=<%= task.getTaskId() %>" class="btn btn-view-applications">Xem ứng tuyển</a>
                        <% } %>
                        <% if ("cancelled".equalsIgnoreCase(task.getStatus())) { %>
                            <form action="${pageContext.request.contextPath}/tasks" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="deleteTask">
                                <input type="hidden" name="taskId" value="<%= task.getTaskId() %>">
                                <button type="submit" class="btn btn-delete" onclick="return confirm('Bạn có chắc muốn xóa công việc này không?')">Xóa</button>
                            </form>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>
</div>

<script>
    setTimeout(() => {
        document.querySelectorAll('.alert').forEach(alert => {
            alert.style.opacity = '0';
            setTimeout(() => alert.style.display = 'none', 300);
        });
    }, 5000);
</script>
</body>
</html>