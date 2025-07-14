<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Boost Task</title>
</head>
<body>
    <h1>Boost Task</h1>
    <c:if test="${not empty error}">
        <p style="color:red">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p style="color:green">${success}</p>
    </c:if>
        
        <a href="${pageContext.request.contextPath}/tasks">Available Tasks</a>
        <a href="${pageContext.request.contextPath}/home">Quay lại trang chủ</a>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Tiêu đề</th>
            <th>Thời gian tạo</th>
            <th>Thời gian boost</th>
            <th>Hành động</th>
        </tr>
        <c:forEach var="task" items="${userTasks}">
            <tr>
                <td>${task.taskId}</td>
                <td>${task.title}</td>
                <td>${task.createdAt}</td>
                <td>${task.boostedAt}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/boostTask" method="post">
                        <input type="hidden" name="taskId" value="${task.taskId}"/>
                        <input type="hidden" name="action" value="boost"/>
                        <input type="submit" value="Đẩy lên đầu"/>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>