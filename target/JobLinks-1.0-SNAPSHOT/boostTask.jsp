<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Boost Task</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Cập nhật bố cục để footer bám dính */
        html {
            height: 100%;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0; /* Bỏ margin mặc định */
            min-height: 100%;
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 1200px;
            flex: 1 0 auto; /* Nội dung chính mở rộng để đẩy footer xuống */
        }
        /* Table styles */
        .table {
            margin-top: 20px;
            background-color: #e6f3ff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            padding: 12px;
            text-align: left;
            color: #333;
        }
        .table th {
            background-color: #d1e7ff;
        }
        .table tr:nth-child(even) {
            background-color: #f0f8ff;
        }
        .error {
            color: #dc3545;
            font-weight: bold;
        }
        .success {
            color: #28a745;
            font-weight: bold;
        }
        .btn-boost {
            background-color: #6e8efb;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-boost:hover {
            background-color: #5d7ce0;
        }
        .no-js-warning {
            display: none;
            color: #dc3545;
            font-weight: bold;
            margin-top: 10px;
        }
        .no-tasks {
            text-align: center;
            color: #6c757d;
            font-style: italic;
            padding: 20px;
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
            flex-shrink: 0; /* Footer không bị co lại */
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
        /* Modal Styles */
        .modal-content {
            background-color: #e6f3ff;
            border-radius: 8px;
        }
        .modal-header {
            background-color: #d1e7ff;
            border-bottom: 1px solid #b3d7ff;
        }
        .modal-title {
            color: #333;
        }
        .modal-body {
            color: #333;
            font-size: 1rem;
        }
        .modal-body strong {
            color: #1a5f9f;
        }
        .modal-footer {
            border-top: 1px solid #b3d7ff;
        }
        .modal-footer .btn-primary {
            background-color: #6e8efb;
            border: none;
        }
        .modal-footer .btn-primary:hover {
            background-color: #5d7ce0;
        }
        .modal-footer .btn-secondary {
            background-color: #6c757d;
            border: none;
        }
        .modal-footer .btn-secondary:hover {
            background-color: #5a6268;
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

    <div class="container">
        <h1 class="text-center mb-4">Quản Lý Boost Task</h1>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty userTasks}">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tiêu đề</th>
                            <th>Thời gian tạo</th>
                            <th>Thời gian boost</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="task" items="${userTasks}">
                            <tr>
                                <td>${task.taskId}</td>
                                <td><c:out value="${task.title}"/></td>
                                <td><fmt:formatDate value="${task.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty task.boostedAt}">
                                            <fmt:formatDate value="${task.boostedAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <form id="boostForm-${task.taskId}" action="${pageContext.request.contextPath}/boostTask" method="post" onsubmit="return false;">
                                        <input type="hidden" name="taskId" value="${task.taskId}"/>
                                        <input type="hidden" name="action" value="boost"/>
                                        <button type="button" class="btn-boost" data-bs-toggle="modal" data-bs-target="#confirmBoostModal" data-task-id="${task.taskId}" data-task-title="${task.title}">Đẩy lên đầu</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-tasks">
                    <i class="fas fa-info-circle fs-2 mb-3"></i>
                    <p>Chưa có công việc nào để boost.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="modal fade" id="confirmBoostModal" tabindex="-1" aria-labelledby="confirmBoostModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmBoostModalLabel">Xác nhận đẩy task</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn đẩy task <strong id="modalTaskTitle"></strong> (ID: <strong id="modalTaskId"></strong>) lên đầu không? Lệ phí: <strong><fmt:formatNumber value="50000" type="currency" currencyCode="VND"/></strong>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" id="confirmBoostButton">Xác nhận</button>
                    </div>
                </div>
            </div>
        </div>

        <noscript>
            <div class="no-js-warning">JavaScript bị vô hiệu hóa. Vui lòng bật JavaScript để sử dụng chức năng xác nhận đẩy task.</div>
        </noscript>
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

        // Modal JavaScript
        document.getElementById('confirmBoostModal').addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const taskId = button.getAttribute('data-task-id');
            const taskTitle = button.getAttribute('data-task-title');
            document.getElementById('modalTaskId').textContent = taskId;
            document.getElementById('modalTaskTitle').textContent = taskTitle;
            document.getElementById('confirmBoostButton').setAttribute('data-form-id', 'boostForm-' + taskId);
        });

        document.getElementById('confirmBoostButton').addEventListener('click', function () {
            const formId = this.getAttribute('data-form-id');
            const form = document.getElementById(formId);
            if (form) {
                form.submit();
            } else {
                console.error('Form not found: ' + formId);
            }
        });
    </script>
</body>
</html>
