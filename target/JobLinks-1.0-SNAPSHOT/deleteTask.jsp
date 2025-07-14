<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận xóa công việc</title>
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
        p {
            margin-bottom: 10px;
        }
        button {
            padding: 10px 15px;
            margin-right: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .delete-btn {
            background-color: #dc3545;
            color: white;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
        .cancel-btn {
            background-color: #28a745;
            color: white;
        }
        .cancel-btn:hover {
            background-color: #218838;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Xác nhận xóa công việc</h2>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <c:set var="task" value="${requestScope.task}" />
        <p><strong>Tiêu đề:</strong> ${task.title}</p>
        <p><strong>Mô tả:</strong> ${task.description}</p>
        <p><strong>Địa điểm:</strong> ${task.location}</p>
        <p><strong>Thời gian:</strong> ${task.scheduledTime}</p>
        <p><strong>Ngân sách:</strong> ${task.budget} VND</p>
        <p><strong>Trạng thái:</strong> 
            <c:choose>
                <c:when test="${task.status == 'pending'}">Chờ xử lý</c:when>
                <c:when test="${task.status == 'assigned'}">Đã giao</c:when>
                <c:when test="${task.status == 'completed'}">Hoàn thành</c:when>
                <c:otherwise>Không xác định</c:otherwise>
            </c:choose>
        </p>
        <p>Bạn có chắc chắn muốn xóa công việc này không?</p>
        <form action="${pageContext.request.contextPath}/deleteTask" method="post">
            <input type="hidden" name="taskId" value="${task.taskId}" />
            <button type="submit" class="delete-btn">Xác nhận xóa</button>
            <button type="button" class="cancel-btn" onclick="window.location.href='${pageContext.request.contextPath}/loadJobPoster'">Hủy</button>
        </form>
    </div>
</body>
</html>