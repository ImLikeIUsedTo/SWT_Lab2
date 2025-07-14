<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Task" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="model.TaskApplication" %>
<%@ page import="java.util.List" %>
<% Logger logger = Logger.getLogger("taskDetails"); %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Công Việc - JobLinks</title>
    <style>
        .container { max-width: 800px; margin: 0 auto; padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .nav-links a { margin-left: 15px; text-decoration: none; color: #007bff; }
        .task-details { border: 1px solid #ddd; padding: 15px; border-radius: 5px; background-color: #f9f9f9; }
        .task-title { font-size: 1.5em; font-weight: bold; margin-bottom: 15px; }
        .task-info { margin-bottom: 10px; }
        .task-info strong { color: #333; }
        .applications-section { margin-top: 20px; border: 1px solid #ddd; padding: 15px; border-radius: 5px; background-color: #f9f9f9; }
        .application-card { margin-bottom: 10px; padding: 10px; border: 1px solid #eee; border-radius: 3px; }
        .btn { padding: 8px 15px; text-decoration: none; border-radius: 3px; }
        .btn-primary { background-color: #007bff; color: white; }
        .btn-secondary { background-color: #6c757d; color: white; border: none; cursor: pointer; }
        .btn-disabled { background-color: #ccc; color: #666; cursor: not-allowed; text-decoration: none; }
        .btn-accept { background-color: #28a745; color: white; margin-right: 5px; }
        .btn-reject { background-color: #dc3545; color: white; }
        .alert { padding: 10px; margin-bottom: 10px; border-radius: 5px; }
        .alert-error { background-color: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Chi Tiết Công Việc</h1>
            <div class="nav-links">
                <a href="tasks">Danh Sách Công Việc</a>
                <a href="tasks?action=applied">Đơn Ứng Tuyển Của Tôi</a>
                <a href="${pageContext.request.contextPath}/home">Quay lại trang chủ</a>
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
                <h2>Lỗi!</h2>
                <p>Đã xảy ra lỗi khi xử lý yêu cầu của bạn.</p>
                <p><strong>Thông báo lỗi:</strong> <%= errorMessage != null ? errorMessage : "Công việc không tồn tại." %></p>
                <a href="tasks" class="btn btn-secondary">Quay lại Danh Sách Công Việc</a>
            </div>
        <% } else { %>
            <div class="task-details">
                <h2 class="task-title"><%= task.getTitle() != null ? task.getTitle() : "Không có tiêu đề" %></h2>
                <div class="task-info"><strong>Khách hàng:</strong> <%= task.getClientName() != null ? task.getClientName() : "Không xác định" %></div>
                <% if (task.getCategoryName() != null) { %>
                    <div class="task-info"><strong>Danh mục:</strong> <%= task.getCategoryName() %></div>
                <% } %>
                <div class="task-info"><strong>Địa điểm:</strong> <%= task.getLocation() != null ? task.getLocation() : "Không xác định" %></div>
                <% if (task.getScheduledTime() != null) { %>
                    <div class="task-info"><strong>Thời gian dự kiến:</strong> <%= new SimpleDateFormat("dd/MM/yyyy HH:mm").format(task.getScheduledTime()) %></div>
                <% } %>
                <div class="task-info"><strong>Ngân sách:</strong> <%= String.format("%.2f", task.getBudget()) %> VNĐ</div>
                <div class="task-info"><strong>Trạng thái:</strong> <%= task.getStatus() != null ? task.getStatus() : "N/A" %></div>
                <div class="task-info"><strong>Mô tả:</strong> <%= task.getDescription() != null ? task.getDescription().replace("\n", "<br>") : "Không có mô tả" %></div>
                <% if (hasApplied != null && hasApplied) { %>
                    <div class="task-info"><strong>Trạng thái ứng tuyển:</strong> Đã ứng tuyển</div>
                <% } %>
            </div>
            <!-- Thêm section danh sách ứng viên -->
            <% if (userId != null && task.getUserId() == userId.intValue() && applications != null && !applications.isEmpty()) { %>
                <div class="applications-section">
                    <h3>Danh sách ứng viên</h3>
                    <% for (TaskApplication app : applications) { %>
                        <div class="application-card">
                            <div class="task-info"><strong>Tên:</strong> <%= app.getWorkerName() != null ? app.getWorkerName() : "Không rõ" %></div>
                            <div class="task-info"><strong>Email:</strong> <%= app.getWorkerEmail() != null ? app.getWorkerEmail() : "Không rõ" %></div>
                            <div class="task-info"><strong>Số điện thoại:</strong> <%= app.getWorkerPhone() != null ? app.getWorkerPhone() : "Không rõ" %></div>
                            <div class="task-info"><strong>Lời nhắn:</strong> <%= app.getMessage() != null ? app.getMessage() : "Không có lời nhắn" %></div>
                            <div class="task-info"><strong>Trạng thái:</strong> <%= app.getStatus() != null ? app.getStatus() : "Chưa rõ" %></div>
                            <div class="task-info"><strong>Ngày ứng tuyển:</strong> <%= app.getAppliedAt() != null ? new SimpleDateFormat("dd/MM/yyyy HH:mm").format(app.getAppliedAt()) : "Chưa rõ" %></div>
                            <% if ("pending".equalsIgnoreCase(app.getStatus())) { %>
                                <div class="task-actions">
                                    <form action="${pageContext.request.contextPath}/tasks" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="accept">
                                        <input type="hidden" name="application_id" value="<%= app.getApplicationId() %>">
                                        <input type="hidden" name="taskId" value="<%= task.getTaskId() %>">
                                        <button type="submit" class="btn btn-accept">Chấp nhận</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/tasks" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="reject">
                                        <input type="hidden" name="application_id" value="<%= app.getApplicationId() %>">
                                        <input type="hidden" name="taskId" value="<%= task.getTaskId() %>">
                                        <button type="submit" class="btn btn-reject">Từ chối</button>
                                    </form>
                                </div>
                            <% } %>
                        </div>
                    <% } %>
                </div>
            <% } else if (userId != null && task.getUserId() == userId.intValue() && (applications == null || applications.isEmpty())) { %>
                <div class="task-info" style="margin-top: 20px;">Chưa có ứng viên nào ứng tuyển.</div>
            <% } %>
            <div style="margin-top: 20px;">
                <a href="tasks" class="btn btn-secondary">Quay lại Danh Sách Công Việc</a>
                <% 
                    boolean isTaskOwner = userId != null && task.getUserId() == userId.intValue();
                    if (hasApplied == null || !hasApplied) {
                        if (isTaskOwner) { %>
                            <a class="btn btn-disabled" title="Bạn không thể ứng tuyển cho công việc của chính mình">Ứng Tuyển Ngay</a>
                        <% } else { %>
                            <a href="applyTask.jsp?task_id=<%= task.getTaskId() %>" class="btn btn-primary">Ứng Tuyển Ngay</a>
                        <% }
                    }
                %>
            </div>
        <% } %>
    </div>
</body>
</html>