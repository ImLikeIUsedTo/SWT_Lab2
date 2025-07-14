<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
        <style>
            /* Thêm các style tạm thời để demo */
            .hero {
                background: linear-gradient(135deg, #3498db, #2c3e50);
                color: white;
                padding: 80px 0;
            }
            .task-item, .worker-item, .review-item {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 20px;
                margin-bottom: 20px;
                transition: transform 0.3s;
            }
            .task-item:hover, .worker-item:hover, .review-item:hover {
                transform: translateY(-5px);
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <header class="header">
                    <div class="container">
                        <div class="header-content">
                            <a href="${pageContext.request.contextPath}/home" class="logo">
                                <img src="${pageContext.request.contextPath}/img/joblink.png" alt="JobLinks" class="logo-img">
                            </a>
                            <div class="menu">
                                <span class="greeting">Xin chào, ${sessionScope.user.fullName}</span>
                                <nav class="nav">
                                    <a href="${pageContext.request.contextPath}/home" class="nav-link active">
                                        <i class="fas fa-home"></i> Trang chủ
                                    </a>
                                    <a href="${pageContext.request.contextPath}/profile" class="nav-link">
                                        <i class="fas fa-user"></i> Hồ sơ
                                    </a>
                                    <a href="${pageContext.request.contextPath}/sendMessage" class="nav-link">
                                        <i class="fas fa-envelope"></i> Nhắn tin
                                    </a>
                                    <a href="${pageContext.request.contextPath}/notifications" class="nav-link">
                                        <i class="fas fa-bell"></i> Thông báo
                                    </a>
                                </nav>
                                <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">
                                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                </a>
                            </div>
                        </div>
                    </div>
                </header>
            </c:when>
            <c:otherwise>
                <header class="header">
                    <div class="container">
                        <div class="header-content">
                            <a href="${pageContext.request.contextPath}/home" class="logo">
                                <img src="${pageContext.request.contextPath}/img/joblink.png" alt="JobLinks" class="logo-img">
                            </a>
                            <div class="menu">
                                <nav class="nav">
                                    <a href="${pageContext.request.contextPath}/home" class="nav-link active">
                                        <i class="fas fa-home"></i> Trang Chủ
                                    </a>
                                    <a href="${pageContext.request.contextPath}/tasks" class="nav-link">
                                        <i class="fas fa-tasks"></i> Danh sách công việc
                                    </a>
                                    <a href="help.jsp" class="nav-link">
                                        <i class="fas fa-question-circle"></i> Trợ Giúp
                                    </a>
                                </nav>
                                <div class="header-actions">
                                    <a href="login.jsp" class="btn btn-login">
                                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                                    </a>
                                    <a href="register.jsp" class="btn btn-primary">
                                        <i class="fas fa-user-plus"></i> Đăng ký
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </header>
            </c:otherwise>
        </c:choose>
    </body>
</html>
