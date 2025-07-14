<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết công việc</title>
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

        .detail-value {
            padding: 0.5rem;
            border: 1px solid #e3e6f0;
            border-radius: 0.25rem;
            font-size: 1rem;
            background-color: #f8f9fc;
            color: #333;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Chi tiết công việc</h1>
        </div>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <c:set var="task" value="${requestScope.task}" />
        <div class="form-group">
            <label>Tiêu đề:</label>
            <div class="detail-value">${task.title}</div>
        </div>
        <div class="form-group">
            <label>Mô tả:</label>
            <div class="detail-value">${task.description}</div>
        </div>
        <div class="form-group">
            <label>Danh mục:</label>
            <div class="detail-value">${categoryName}</div>
        </div>
        <div class="form-group">
            <label>Địa điểm:</label>
            <div class="detail-value">${task.location}</div>
        </div>
        <div class="form-group">
            <label>Thời gian dự kiến:</label>
            <div class="detail-value">${task.scheduledTime}</div>
        </div>
        <div class="form-group">
            <label>Ngân sách (VND):</label>
            <div class="detail-value">${task.budget}</div>
        </div>
        <div class="form-group">
            <label>Trạng thái:</label>
            <div class="detail-value">${task.status}</div>
        </div>
        <div class="form-group">
            <a href="${pageContext.request.contextPath}/completedTasks" class="btn btn-danger">Quay lại</a>
        </div>
    </div>
</body>
</html>