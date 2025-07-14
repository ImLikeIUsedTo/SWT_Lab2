<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa công việc</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --danger-color: #e74a3b;
            --warning-color: #f6c23e;
            --light-color: #f8f9fc;
            --dark-color: #5a5c69;
        }

        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fc;
            color: #333;
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: white;
            padding: 2rem;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            width: 100%;
            max-width: 500px;
        }

        .header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .header h1 {
            font-size: 1.5rem;
            color: var(--dark-color);
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }

        input, textarea {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #e3e6f0;
            border-radius: 0.25rem;
            font-size: 1rem;
        }

        textarea {
            resize: vertical;
        }

        .category-display {
            padding: 0.5rem;
            border: 1 categoryIdpx solid #e3e6f0;
            border-radius: 0.25rem;
            font-size: 1rem;
            background-color: #f8f9fc;
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
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: #2e59d9;
            transform: translateY(-1px);
        }

        .btn-danger {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-danger:hover {
            background-color: #be2617;
        }

        .error {
            color: var(--danger-color);
            margin-bottom: 10px;
            text-align: center;
        }

        .disabled {
            opacity: 0.6;
            cursor: not-allowed;
            pointer-events: none;
            background-color: #e9ecef; /* Làm tối nút */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Chỉnh sửa công việc</h1>
        </div>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <c:set var="task" value="${requestScope.task}" />
        <form action="${pageContext.request.contextPath}/editTask" method="post">
            <input type="hidden" name="taskId" value="${task.taskId}">
            <div class="form-group">
                <label for="title">Tiêu đề:</label>
                <input type="text" id="title" name="title" value="${task.title}" 
                    ${taskStatus == 'COMPLETED' ? 'disabled' : ''} required>
            </div>
            <div class="form-group">
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description" rows="3" 
                    ${taskStatus == 'COMPLETED' ? 'disabled' : ''} required>${task.description}</textarea>
            </div>
            <div class="form-group">
                <label for="categoryId">Danh mục:</label>
                <c:choose>
                    <c:when test="${taskStatus == 'COMPLETED'}">
                        <div class="category-display">
                            <c:forEach var="category" items="${categories}">
                                <c:if test="${category.categoryId == task.categoryId}">
                                    ${category.name}
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <select id="categoryId" name="categoryId" required>
                            <option value="">Chọn danh mục</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.categoryId}"
                                        <c:if test="${category.categoryId == task.categoryId}">selected</c:if>>
                                    ${category.name}
                                </option>
                            </c:forEach>
                        </select>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="form-group">
                <label for="location">Địa điểm:</label>
                <input type="text" id="location" name="location" value="${task.location}" 
                    ${taskStatus == 'COMPLETED' ? 'disabled' : ''} required>
            </div>
            <div class="form-group">
                <label for="scheduledTime">Thời gian dự kiến (yyyy-MM-dd'T'HH:mm):</label>
                <input type="datetime-local" id="scheduledTime" name="scheduledTime" 
                    value="${formattedScheduledTime}" ${taskStatus == 'COMPLETED' ? 'disabled' : ''} required>
            </div>
            <div class="form-group">
                <label for="budget">Ngân sách (VND):</label>
                <input type="number" id="budget" name="budget" step="0.01" value="${task.budget}" 
                    ${taskStatus == 'COMPLETED' ? 'disabled' : ''} required>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary" 
                    ${taskStatus == 'COMPLETED' ? 'disabled class="disabled"' : ''}>Lưu</button>
                <a href="${pageContext.request.contextPath}/loadJobPoster" class="btn btn-danger">Hủy</a>
            </div>
        </form>
    </div>
</body>
</html>