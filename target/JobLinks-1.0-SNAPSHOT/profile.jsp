<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ sơ người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #808080;
            font-family: 'Segoe UI', sans-serif;
        }
        .profile-card {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            margin-top: 80px;
        }
        .profile-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: #343a40;
        }
        .form-label {
            font-weight: 500;
        }
        .section-divider {
            border-top: 1px solid #dee2e6;
            margin: 30px 0;
        }
        .link-custom {
          color: #a0b4ff; 
          font-size: 2em; 
          font-weight: bold;
          text-decoration: none;
          border: 1px solid #a0b4ff; 
          border-radius: 5px; 
          padding: 10px 20px; 
          display: inline-block; 
        }

        .link-custom:hover {
          background-color: #e0e8ff; 
          cursor: pointer; 
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>    
    
<div class="container d-flex justify-content-center mt-5">
    <div class="col-md-8 profile-card">
        <h2 class="profile-title mb-4 text-center">Cập nhật hồ sơ người dùng</h2>

        <c:if test="${not empty message}">
            <div class="alert alert-success text-center">${message}</div>
            <c:remove var="message" scope="session"/>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <c:if test="${not empty user}">
            <!-- Form cập nhật thông tin người dùng -->
            <form action="updateProfile" method="post">
                <input type="hidden" name="action" value="updateProfile">
                <div class="mb-3">
                    <label class="form-label">Họ tên</label>
                    <input type="text" class="form-control" name="fullName" value="${user.fullName}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" value="${user.email}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" name="phone" value="${user.phone}" required>
                </div>


                <div class="mb-3">
                    <label class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" name="address" value="${user.address}">
                </div>

                <div class="mb-3">
                    <label class="form-label">Ngày tạo</label>
                    <input type="text" class="form-control" value="${user.createdAt}" readonly>
                </div>

                <div class="d-flex justify-content-center mt-4">
                    <button type="submit" class="btn btn-success me-3">Lưu thay đổi</button>
                    <a href="home" class="btn btn-outline-primary me-2">Danh sách công việc</a>
                    <a href="notifications" class="btn btn-outline-secondary">Thông báo</a>
                </div>
            </form>

            <!-- Form thay đổi mật khẩu -->
            <div class="section-divider"></div>
            <h3 class="profile-title mb-4 text-center">Thay đổi mật khẩu</h3>
            <form action="updateProfile" method="post">
                <input type="hidden" name="action" value="changePassword">
                <div class="mb-3">
                    <label class="form-label">Mật khẩu cũ</label>
                    <input type="password" class="form-control" name="oldPassword" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Mật khẩu mới</label>
                    <input type="password" class="form-control" name="newPassword" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Xác nhận mật khẩu mới</label>
                    <input type="password" class="form-control" name="confirmPassword" required>
                </div>
                <div class="d-flex justify-content-center mt-4">
                    <button type="submit" class="btn btn-primary">Cập nhật mật khẩu</button>
                </div>
            </form>
        </c:if>

        <c:if test="${empty user}">
            <p class="text-danger text-center">Không tìm thấy thông tin người dùng.</p>
        </c:if>
    </div>
</div>

    <%@include file="footer.jsp" %> 
</body>
</html>
