<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xem Hồ Sơ Ứng Viên</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f8f9fc;
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            background-color: white;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-info {
            margin-bottom: 15px;
        }
        .profile-info label {
            font-weight: 600;
            color: #5a5c69;
            margin-right: 10px;
        }
        .profile-info span {
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
        .btn-primary {
            background-color: #4e73df;
            color: white;
        }
        .btn-primary:hover {
            background-color: #2e59d9;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-header">
            <h2><i class="fas fa-user"></i> Thông Tin Ứng Viên</h2>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <div class="profile-info">
            <label>Họ và tên:</label>
            <span>${workerName}</span>
        </div>
        <div class="profile-info">
            <label>Email:</label>
            <span>${workerEmail}</span>
        </div>
        <div class="profile-info">
            <label>Số điện thoại:</label>
            <span>${workerPhone}</span>
        </div>
        <div class="profile-info">
            <label>Địa chỉ:</label>
            <span>${workerAddress}</span>
        </div>

        <a href="${pageContext.request.contextPath}/loadJobPoster" class="btn btn-primary">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>
    </div>
</body>
</html>