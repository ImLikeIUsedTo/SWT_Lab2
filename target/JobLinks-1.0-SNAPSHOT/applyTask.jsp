<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ứng Tuyển Công Việc - JobLinks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        /* Bố cục flexbox để footer bám dính */
        html {
            height: 100%;
        }
        body {
            margin: 0;
            min-height: 100%;
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa;
        }
        .apply-container {
            max-width: 800px; /* Tăng từ 600px để hộp to hơn */
            margin: 50px auto;
            padding: 30px; /* Tăng padding để thoáng hơn */
            background: #e6f3ff; /* Nền xanh nhạt, đồng bộ với boosttask.jsp */
            border-radius: 12px; /* Bo góc mềm mại hơn */
            box-shadow: 0 4px 15px rgba(0,0,0,0.15); /* Bóng đậm hơn */
            flex: 1 0 auto;
        }
        h1 {
            font-size: 28px; /* Tăng kích thước tiêu đề */
            margin-bottom: 25px;
            text-align: center;
            color: #333; /* Màu chữ xám đậm */
            font-weight: 600;
        }
        .form-group {
            margin-bottom: 20px; /* Tăng khoảng cách giữa các phần tử */
        }
        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            font-size: 16px; /* Tăng kích thước font nhãn */
            color: #333;
        }
        textarea {
            width: 100%;
            height: 150px; /* Tăng chiều cao textarea */
            padding: 12px;
            border: 1px solid #b3d7ff; /* Viền xanh nhạt */
            border-radius: 6px;
            font-size: 15px; /* Tăng kích thước font */
            resize: vertical; /* Chỉ cho phép kéo dãn chiều cao */
        }
        .btn-submit {
            background: #28a745;
            color: white;
            padding: 12px 30px; /* Tăng kích thước nút */
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.2s ease; /* Hiệu ứng hover */
        }
        .btn-submit:hover {
            background: #218838;
            transform: translateY(-2px); /* Hiệu ứng nâng nhẹ */
        }
        .back-link {
            display: inline-block;
            margin-top: 25px;
            color: #3498db;
            text-decoration: none;
            font-size: 15px; /* Tăng kích thước font */
            font-weight: 500;
        }
        .back-link:hover {
            text-decoration: underline;
            color: #2c80b9; /* Màu hover đậm hơn */
        }
        .alert {
            padding: 15px; /* Tăng padding */
            margin-bottom: 20px;
            border-radius: 6px;
            font-size: 15px; /* Tăng kích thước font */
            border: 1px solid transparent; /* Thêm viền nhẹ */
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
        }
        /* Header Styles */
        .header {
            background: linear-gradient(90deg, #007bff, #00c4ff);
            color: white;
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .header-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }
        .header-logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
        }
        .header-nav {
            display: flex;
            gap: 20px;
        }
        .header-nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: opacity 0.3s ease;
        }
        .header-nav a:hover {
            opacity: 0.8;
        }
        .header-user {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .header-user-greeting {
            font-weight: bold;
        }
        .header-user-balance {
            background-color: rgba(255, 255, 255, 0.2);
            padding: 5px 10px;
            border-radius: 12px;
            font-size: 0.9rem;
        }
        .header-btn {
            padding: 8px 16px;
            border-radius: 20px;
            border: none;
            color: white;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .header-btn-login {
            background-color: #28a745;
        }
        .header-btn-login:hover {
            background-color: #218838;
        }
        .header-btn-register {
            background-color: #ffc107;
            color: #333;
        }
        .header-btn-register:hover {
            background-color: #e0a800;
        }
        .header-btn-logout {
            background-color: #dc3545;
        }
        .header-btn-logout:hover {
            background-color: #c82333;
        }
        /* Footer Styles */
        .footer {
            background: linear-gradient(90deg, #e3f2fd, #bbdefb);
            color: #333;
            padding: 40px 0;
            flex-shrink: 0;
            width: 100%;
        }
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        .footer-section h3 {
            font-size: 1.2rem;
            margin-bottom: 15px;
            color: #007bff;
        }
        .footer-section p, .footer-section li {
            font-size: 0.9rem;
            line-height: 1.6;
        }
        .footer-links {
            list-style: none;
            padding: 0;
        }
        .footer-links a {
            color: #333;
            text-decoration: none;
        }
        .footer-links a:hover {
            color: #007bff;
        }
        .footer-social a {
            color: #333;
            font-size: 1.2rem;
            margin-right: 10px;
            transition: color 0.3s ease;
        }
        .footer-social a:hover {
            color: #007bff;
        }
        .footer-bottom {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #90caf9;
        }
        .back-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border-radius: 50%;
            display: none;
            transition: background-color 0.3s ease;
        }
        .back-to-top:hover {
            background-color: #0056b3;
        }
        .back-to-top.show {
            display: block;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <a href="${pageContext.request.contextPath}/home" class="header-logo">
                JobLinks
            </a>
            <nav class="header-nav">
                <a href="${pageContext.request.contextPath}/home"><i class="fas fa-home"></i> Trang chủ</a>
                <a href="${pageContext.request.contextPath}/tasks"><i class="fas fa-tasks"></i> Danh sách công việc</a>
                <a href="${pageContext.request.contextPath}/acceptedTasks"><i class="fas fa-check"></i> Công việc đã nhận</a>
                <a href="${pageContext.request.contextPath}/DepositServlet"><i class="fas fa-wallet"></i> Nạp tiền</a>
                <a href="${pageContext.request.contextPath}/boostTask"><i class="fas fa-rocket"></i> Quản Lý Boost Task</a>
            </nav>
            <div class="header-user">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="header-user-greeting">Xin chào, <c:out value="${userName}" default="Khách"/></span>
                        <span class="header-user-balance">
                            Số dư: <fmt:formatNumber value="${userBalance}" type="currency" currencyCode="VND"/>
                        </span>
                        <a href="${pageContext.request.contextPath}/logout" class="header-btn header-btn-logout">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp" class="header-btn header-btn-login">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </a>
                        <a href="register.jsp" class="header-btn header-btn-register">
                            <i class="fas fa-user-plus"></i> Đăng ký
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <div class="apply-container">
        <h1>Ứng Tuyển Công Việc</h1>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Đã gửi đơn ứng tuyển thành công
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/applyTask" method="post">
            <input type="hidden" name="task_id" value="${param.task_id}"/>
            <div class="form-group">
                <label for="message">Tin nhắn ứng tuyển:</label>
                <textarea id="message" name="message" required></textarea>
            </div>
            <button type="submit" name="action" value="apply" class="btn-submit">
                <i class="fas fa-check"></i> Gửi ứng tuyển
            </button>
        </form>

        <a href="${pageContext.request.contextPath}/tasks" class="back-link">
            <i class="fas fa-arrow-left"></i> Quay lại danh sách công việc
        </a>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <h3>JobLinks</h3>
                <p>Kết nối công việc, xây dựng tương lai. Tìm kiếm và ứng tuyển công việc dễ dàng với JobLinks.</p>
            </div>
            <div class="footer-section">
                <h3>Liên kết</h3>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/tasks">Công việc</a></li>
                    <li><a href="about.jsp">Về chúng tôi</a></li>
                    <li><a href="help.jsp">Hỗ trợ</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Liên hệ</h3>
                <ul class="footer-links">
                    <li><i class="fas fa-envelope"></i> support@joblinks.vn</li>
                    <li><i class="fas fa-phone"></i> (+84) 987 654 321</li>
                    <li><i class="fas fa-map-marker-alt"></i> Hà Nội, Việt Nam</li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Kết nối với chúng tôi</h3>
                <div class="footer-social">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 JobLinks. All rights reserved.</p>
        </div>
    </footer>

    <!-- Back to Top Button -->
    <a href="#" class="back-to-top" id="backToTop">
        <i class="fas fa-arrow-up"></i>
    </a>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Back to top button
        window.addEventListener('scroll', function() {
            var backToTop = document.getElementById('backToTop');
            if (window.pageYOffset > 300) {
                backToTop.classList.add('show');
            } else {
                backToTop.classList.remove('show');
            }
        });
        document.getElementById('backToTop').addEventListener('click', function(e) {
            e.preventDefault();
            window.scrollTo({top: 0, behavior: 'smooth'});
        });
    </script>
</body>
</html>
