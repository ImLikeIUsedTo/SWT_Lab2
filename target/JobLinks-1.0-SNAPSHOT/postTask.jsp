<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng công việc mới</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            max-width: 500px;
            margin: 0 auto;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, select, textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        .back-btn {
            background-color: #28a745;
            margin-right: 10px;
        }
        .back-btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Đăng công việc mới</h2>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/postTask" method="post">
            <label for="title">Tiêu đề:</label>
            <input type="text" id="title" name="title" required>
            
            <label for="description">Mô tả:</label>
            <textarea id="description" name="description" required></textarea>
            
            <label for="categoryId">Danh mục:</label>
            <select id="categoryId" name="categoryId" required>
                <option value="">Chọn danh mục</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.categoryId}">${category.name}</option>
                </c:forEach>
            </select>
            
            <label for="location">Địa điểm:</label>
            <input type="text" id="location" name="location" required>
            
            <label for="scheduledTime">Thời gian dự kiến (yyyy-MM-dd'T'HH:mm):</label>
            <input type="datetime-local" id="scheduledTime" name="scheduledTime" required>
            
            <label for="budget">Ngân sách (VND):</label>
            <input type="number" id="budget" name="budget" step="0.01" required>
            
            <button type="submit">Đăng công việc</button>
            <button type="button" class="back-btn" onclick="window.location.href='${pageContext.request.contextPath}/loadJobPoster'">Trở lại</button>
        </form>
    </div>
</body>
</html>
