```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nạp Tiền - JobLinks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        html {
            height: 100%;
        }
        body {
            margin: 0;
            min-height: 100%;
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .main-content {
            flex: 1 0 auto;
            padding: 20px 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }
        .nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #dee2e6;
            width: 100%;
        }
        .nav-item {
            flex: 1;
            text-align: center;
            min-width: 0;
        }
        .back {
            padding: 10px 20px;
            background: #483C4F;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        .back:hover {
            background: #5a4d66;
        }
        .user-greeting {
            font-weight: bold;
        }
        .user-balance {
            font-weight: bold;
            color: #28a745;
        }
        .link-custom {
            color: #6e8efb;
            text-decoration: none;
            font-weight: 500;
        }
        .link-custom:hover {
            color: #5d7ce0;
            text-decoration: underline;
        }
        .deposit-form {
            max-width: 500px;
            margin: 0 auto 30px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .payment-history {
            max-width: 800px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .form-label {
            font-weight: bold;
        }
        .btn-primary {
            background-color: #6e8efb;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #5d7ce0;
        }
        .alert {
            margin-top: 10px;
        }
        .no-js-warning {
            display: none;
            color: red;
            font-weight: bold;
            margin-top: 10px;
        }
        .table-responsive {
            margin-top: 20px;
        }
        .badge-success {
            background-color: #28a745;
        }
        .badge-warning {
            background-color: #ffc107;
        }
        .badge-danger {
            background-color: #dc3545;
        }
        .payment-type-deposit {
            color: #28a745;
            font-weight: bold;
        }
        .payment-type-withdraw {
            color: #dc3545;
            font-weight: bold;
        }
        .payment-type-refund {
            color: #17a2b8;
            font-weight: bold;
        }
        .no-history {
            text-align: center;
            color: #6c757d;
            font-style: italic;
            padding: 20px;
        }
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
        .payment-method {
            margin-bottom: 15px;
        }
        .payment-method label {
            margin-left: 10px;
            font-size: 1rem;
        }
        .qr-image {
            max-width: 200px;
            height: auto;
            display: block;
            margin: 10px auto;
        }
    </style>
</head>
<body>
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
                        <span class="header-user-greeting">Xin chào, <c:out value="${sessionScope.email}" default="Khách"/></span>
                        <c:if test="${not empty sessionScope.user.balance}">
                            <span class="header-user-balance">
                                Số dư: <fmt:formatNumber value="${sessionScope.user.balance}" type="currency" currencyCode="VND"/>
                            </span>
                        </c:if>
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

    <div class="main-content">
        <div class="container">
            <div class="nav">
                <div class="nav-item">
                    <button onclick="window.location.href='${pageContext.request.contextPath}/home'" class="back">
                        <i class="fas fa-home"></i> Trở về trang chính
                    </button>
                </div>
                <div class="nav-item">
                    <span class="user-greeting">Xin chào, <c:out value="${sessionScope.email}" default="Khách"/></span>
                </div>
                <div class="nav-item">
                    <c:if test="${not empty sessionScope.user.balance}">
                        <span class="user-balance">
                            Số dư: <fmt:formatNumber value="${sessionScope.user.balance}" type="currency" currencyCode="VND"/>
                        </span>
                    </c:if>
                </div>
                <div class="nav-item">
                    <c:choose>
                        <c:when test="${requestScope.currentPage == 'available'}">
                            <a href="${pageContext.request.contextPath}/tasks?action=applied" class="link-custom">My Applications</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/tasks" class="link-custom">Available Tasks</a>
                        </c:otherwise>
                    </c:choose>
                    <a href="${pageContext.request.contextPath}/DepositServlet" class="link-custom">Nạp Tiền</a>
                </div>
            </div>

            <h1 class="text-center mb-4">Nạp Tiền</h1>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <div class="deposit-form">
                <form id="depositForm" action="${pageContext.request.contextPath}/DepositServlet" method="post" onsubmit="return false;">
                    <div class="mb-3">
                        <label for="amount" class="form-label">Số tiền muốn nạp (VND)</label>
                        <input type="number" class="form-control" id="amount" name="amount" min="10000" step="10000" required placeholder="Nhập số tiền (tối thiểu 10,000 VND)">
                    </div>
                    <div class="mb-3 payment-method">
                        <label class="form-label">Phương thức thanh toán</label><br>
                        <input type="radio" id="vietcombank" name="paymentMethod" value="vietcombank" required>
                        <label for="vietcombank">Vietcombank</label><br>
                        <input type="radio" id="momo" name="paymentMethod" value="momo">
                        <label for="momo">Momo</label><br>
                        <input type="radio" id="zalopay" name="paymentMethod" value="zalopay">
                        <label for="zalopay">ZaloPay</label>
                    </div>
                    <img id="previewQrCode" src="" alt="QR Code Preview" class="qr-image" style="display: none;">
                    <noscript>
                        <div class="no-js-warning">JavaScript bị vô hiệu hóa. Vui lòng bật JavaScript để sử dụng chức năng xác nhận nạp tiền.</div>
                    </noscript>
                    <button type="button" class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#confirmDepositModal">Nạp tiền</button>
                </form>
            </div>

            <div class="payment-history">
                <h3 class="mb-3"><i class="fas fa-history"></i> Lịch sử giao dịch</h3>
                <c:choose>
                    <c:when test="${not empty paymentHistory}">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Ngày giao dịch</th>
                                        <th>Loại giao dịch</th>
                                        <th>Số tiền</th>
                                        <th>Mô tả</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="payment" items="${paymentHistory}">
                                        <tr>
                                            <td>
                                                <fmt:formatDate value="${payment.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${payment.paymentType == 'DEPOSIT'}">
                                                        <span class="payment-type-deposit">Nạp tiền</span>
                                                    </c:when>
                                                    <c:when test="${payment.paymentType == 'WITHDRAW'}">
                                                        <span class="payment-type-withdraw">Trừ tiền</span>
                                                    </c:when>
                                                    <c:when test="${payment.paymentType == 'REFUND'}">
                                                        <span class="payment-type-refund">Hoàn tiền</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span>${payment.paymentType}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${payment.paymentType == 'DEPOSIT' || payment.paymentType == 'REFUND'}">
                                                        <span class="text-success fw-bold">
                                                            +<fmt:formatNumber value="${payment.amount}" type="currency" currencyCode="VND"/>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-danger fw-bold">
                                                            -<fmt:formatNumber value="${payment.amount}" type="currency" currencyCode="VND"/>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${payment.description}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${payment.status == 'SUCCESS'}">
                                                        <span class="badge badge-success">
                                                            <i class="fas fa-check-circle"></i> Thành công
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${payment.status == 'PENDING'}">
                                                        <span class="badge badge-warning">
                                                            <i class="fas fa-clock"></i> Đang xử lý
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${payment.status == 'FAILED'}">
                                                        <span class="badge badge-danger">
                                                            <i class="fas fa-times-circle"></i> Thất bại
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-secondary">${payment.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-history">
                            <i class="fas fa-info-circle fs-2 mb-3"></i>
                            <p>Chưa có lịch sử giao dịch nào.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="modal fade" id="confirmDepositModal" tabindex="-1" aria-labelledby="confirmDepositModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmDepositModalLabel">Xác nhận nạp tiền</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Bạn có chắc chắn muốn nạp <span id="confirmAmount">0</span> VND vào tài khoản của mình?</p>
                            <p>Phương thức thanh toán: <span id="confirmMethod">Chưa chọn</span></p>
                            <img id="qrCodeImage" src="" alt="QR Code" class="qr-image" style="display: none;">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="button" class="btn btn-primary" onclick="submitDepositForm()">Xác nhận</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

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

    <a href="#" class="back-to-top" id="backToTop">
        <i class="fas fa-arrow-up"></i>
    </a>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const qrCodes = {
            vietcombank: 'https://inkythuatso.com/uploads/images/2021/09/logo-vietcombank-inkythuatso-10-10-41-18.jpg',
            momo: 'https://cdn.sforum.vn/sforum/wp-content/uploads/2021/07/momo-upload-api-200728110550-637315311504981461-1.jpg',
            zalopay: 'https://tse1.mm.bing.net/th/id/OIP.dW6idDNy-FvvM2yYWz_chAHaEK?r=0&cb=thvnextc1&rs=1&pid=ImgDetMain&o=7&rm=3'
        };

        // Update QR code preview when a payment method is selected
        document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const previewQrCode = document.getElementById('previewQrCode');
                if (this.checked) {
                    previewQrCode.src = qrCodes[this.value] || '';
                    previewQrCode.style.display = qrCodes[this.value] ? 'block' : 'none';
                }
            });
        });

        // Update modal content when shown
        document.getElementById('confirmDepositModal').addEventListener('show.bs.modal', function (event) {
            const amountInput = document.getElementById('amount');
            const amount = parseFloat(amountInput.value);
            if (!amount || isNaN(amount) || amount < 10000) {
                alert('Vui lòng nhập số tiền hợp lệ (tối thiểu 10,000 VND).');
                event.preventDefault();
                return;
            }
            document.getElementById('confirmAmount').textContent = new Intl.NumberFormat('vi-VN').format(amount);

            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
            const qrCodeImage = document.getElementById('qrCodeImage');
            if (paymentMethod) {
                const method = paymentMethod.value;
                document.getElementById('confirmMethod').textContent = method.charAt(0).toUpperCase() + method.slice(1);
                qrCodeImage.src = qrCodes[method] || '';
                qrCodeImage.style.display = qrCodes[method] ? 'block' : 'none';
            } else {
                document.getElementById('confirmMethod').textContent = 'Chưa chọn';
                qrCodeImage.style.display = 'none';
            }
        });

        function submitDepositForm() {
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
            if (!paymentMethod) {
                alert('Vui lòng chọn phương thức thanh toán.');
                return;
            }
            document.getElementById('depositForm').submit();
        }

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