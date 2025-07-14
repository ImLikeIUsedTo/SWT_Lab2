<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - JobLinks</title>
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
    <!-- Header -->
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

    <!-- Hero Banner -->
    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <div class="hero-text">
                    <h1 class="hero-title">Tìm kiếm việc làm & Đăng tin tuyển dụng</h1>
                    <p class="hero-subtitle">Kết nối nhà tuyển dụng và người tìm việc một cách nhanh chóng và hiệu quả</p>
                    <div class="hero-actions">
                        <c:if test="${sessionScope.user.role == 'worker' || sessionScope.user.role == 'both'}">
                            <a href="${pageContext.request.contextPath}/tasks" class="btn btn-primary btn-large">
                                <i class="fas fa-search"></i> Tìm việc ngay
                            </a>
                            <a href="${pageContext.request.contextPath}/loadJobPoster" class="btn btn-outline btn-large">
                                <i class="fas fa-bullhorn"></i> Đăng tuyển dụng
                            </a>
                        </c:if>
                    </div>
                </div>
                <div class="hero-image">
                    <img src="https://images.unsplash.com/photo-1521791136064-7986c2920216?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" alt="People working">
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">1,200+</div>
                    <div class="stat-label">Công việc đang tuyển</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Nhà tuyển dụng</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">3,000+</div>
                    <div class="stat-label">Ứng viên</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">95%</div>
                    <div class="stat-label">Hài lòng với dịch vụ</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <!-- Recommended Tasks -->
            <section class="section">
                <div class="section-header">
                    <h2><i class="fas fa-bullhorn"></i> Công việc đề xuất</h2>
                    <a href="${pageContext.request.contextPath}/tasks" class="btn btn-link">Xem tất cả</a>
                </div>

                <!-- Search and Filter -->
                <div class="search-filter card">
                    <form action="${pageContext.request.contextPath}/home" method="get" class="filter-form">
                        <div class="form-group">
                            <input type="text" name="search" placeholder="Tìm kiếm công việc..." value="${param.search}" class="form-control">
                        </div>
                        <div class="form-group">
                            <input type="text" name="location" placeholder="Địa điểm..." value="${param.location}" class="form-control">
                        </div>
                        <div class="form-group">
                            <input type="number" name="budget" placeholder="Ngân sách (VND)..." value="${param.budget}" min="0" class="form-control">
                        </div>
                        <div class="form-group">
                            <select name="categoryId" class="form-control">
                                <option value="">Tất cả danh mục</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.categoryId}" <c:if test="${param.categoryId == category.categoryId}">selected</c:if>>
                                        ${category.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-filter"></i> Lọc
                        </button>
                    </form>
                </div>

                <c:choose>
                    <c:when test="${empty recommendedTasks}">
                        <div class="empty-state">
                            <i class="fas fa-briefcase"></i>
                            <p>Hiện không có công việc nào phù hợp</p>
                            <a href="${pageContext.request.contextPath}/tasks" class="btn btn-primary">Khám phá công việc</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="tasks-grid">
                            <c:forEach var="task" items="${recommendedTasks}" end="5">
                                <div class="task-card">
                                    <div class="task-header">
                                        <h3 class="task-title">${task.title}</h3>
                                        <span class="task-budget">${task.budget} VND</span>
                                    </div>
                                    <div class="task-meta">
                                        <span class="task-location"><i class="fas fa-map-marker-alt"></i> ${task.location}</span>
                                        <span class="task-category"><i class="fas fa-tag"></i> ${task.categoryName}</span>
                                    </div>
                                    <p class="task-description">${task.description}</p>
                                    <div class="task-footer">
                                        
                                            <a href="${pageContext.request.contextPath}/tasks?action=details&taskId=${task.taskId}" class="btn btn-primary">
                                                <i class="fas fa-eye"></i> Xem chi tiết
                                            </a>
                                            
                                        
                                        <span class="task-posted"><i class="far fa-clock"></i> 
                                            <c:choose>
                                                <c:when test="${not empty task.createdAt}">
                                                    ${task.createdAt}
                                                </c:when>
                                                <c:otherwise>
                                                    Ngày đăng không khả dụng
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Top Workers -->
            <section class="section">
                <div class="section-header">
                    <h2><i class="fas fa-star"></i> Người làm có kinh nghiệm</h2>
                </div>
                <div class="experienced-grid">
                    <div class="person-card">
                        <img src="img/worker1.png" alt="worker" class="worker-img">
                        <h3>Elon Musk</h3>
                        <p>Kinh nghiệm: 15 năm</p>
                        <p>Chuyên ngành: Lập trình Java</p>
                    </div>
                    <div class="person-card">
                        <img src="img/worker2.png" alt="worker" class="worker-img">
                        <h3>Tôi năm nay</h3>
                        <p>Kinh nghiệm: 70 năm</p>
                        <p>Chuyên ngành: Thiết kế Web</p>
                    </div>
                    <div class="person-card">
                        <img src="img/worker3.png" alt="worker" class="worker-img">
                        <h3>Officer Meow</h3>
                        <p>Kinh nghiệm: 7 năm</p>
                        <p>Chuyên ngành: Quản lý dự án</p>
                    </div>
                </div>
            </section>

            <!-- Recent Reviews -->
            <section class="section">
                <div class="section-header">
                    <h2><i class="fas fa-comment-alt"></i> Đánh giá gần đây</h2>
                </div>
                <div class="reviews-grid">
                    <!-- Đánh giá 1 -->
                    <div class="review-card">
                        <div class="review-header">
                            <div class="reviewer">
                                <img src="https://ui-avatars.com/api/?name=Nguyen+Van+A&background=random" alt="Nguyễn Văn A">
                                <span class="reviewer-name">Nguyễn Văn A</span>
                            </div>
                            <div class="review-rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                            </div>
                        </div>
                        <div class="review-content">
                            <p class="review-comment">"Người làm rất chuyên nghiệp, hoàn thành công việc đúng hẹn và chất lượng tốt. Tôi rất hài lòng!"</p>
                            <div class="review-task">
                                <i class="fas fa-briefcase"></i> Thiết kế website bán hàng
                            </div>
                        </div>
                        <div class="review-date">
                            <i class="far fa-clock"></i> 1 ngày trước
                        </div>
                    </div>
                    <!-- Đánh giá 2 -->
                    <div class="review-card">
                        <div class="review-header">
                            <div class="reviewer">
                                <img src="https://ui-avatars.com/api/?name=Tran+Thi+B&background=random" alt="Trần Thị B">
                                <span class="reviewer-name">Trần Thị B</span>
                            </div>
                            <div class="review-rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>
                        <div class="review-content">
                            <p class="review-comment">"Tuyệt vời! Hoàn thành vượt mong đợi. Sẽ tiếp tục hợp tác trong các dự án tới."</p>
                            <div class="review-task">
                                <i class="fas fa-briefcase"></i> Lập trình ứng dụng di động
                            </div>
                        </div>
                        <div class="review-date">
                            <i class="far fa-clock"></i> 3 ngày trước
                        </div>
                    </div>
                    <!-- Đánh giá 3 -->
                    <div class="review-card">
                        <div class="review-header">
                            <div class="reviewer">
                                <img src="https://ui-avatars.com/api/?name=Le+Van+C&background=random" alt="Lê Văn C">
                                <span class="reviewer-name">Lê Văn C</span>
                            </div>
                            <div class="review-rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="far fa-star"></i>
                            </div>
                        </div>
                        <div class="review-content">
                            <p class="review-comment">"Chất lượng công việc tốt, nhưng cần cải thiện về mặt thời gian giao hàng."</p>
                            <div class="review-task">
                                <i class="fas fa-briefcase"></i> Dịch vụ sửa chữa máy tính
                            </div>
                        </div>
                        <div class="review-date">
                            <i class="far fa-clock"></i> 5 ngày trước
                        </div>
                    </div>
                </div>
            </section>

            <!-- Call to Action -->
            <section class="cta-section">
                <div class="cta-content">
                    <h2>Sẵn sàng bắt đầu?</h2>
                    <p>Tham gia ngay để khám phá hàng ngàn cơ hội việc làm hoặc tìm kiếm ứng viên tiềm năng</p>
                    <div class="cta-actions">
                        <c:if test="${empty sessionScope.user}">
                            <a href="register.jsp" class="btn btn-primary btn-large">
                                <i class="fas fa-user-plus"></i> Đăng ký ngay
                            </a>
                            <a href="login.jsp" class="btn btn-outline btn-large">
                                <i class="fas fa-sign-in-alt"></i> Đăng nhập
                            </a>
                        </c:if>
                        <c:if test="${not empty sessionScope.user}">
                           
                                <a href="${pageContext.request.contextPath}/tasks" class="btn btn-primary btn-large">
                                    <i class="fas fa-search"></i> Tìm việc ngay
                                </a>
                           
                            
                                <a href="${pageContext.request.contextPath}/loadJobPoster" class="btn btn-outline btn-large">
                                    <i class="fas fa-bullhorn"></i> Đăng tuyển dụng
                                </a>
                            
                        </c:if>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <h3 class="footer-title">Về JobLinks</h3>
                    <p>JobLinks là nền tảng kết nối nhà tuyển dụng và người tìm việc uy tín hàng đầu Việt Nam.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                <div class="footer-col">
                    <h3 class="footer-title">Liên kết nhanh</h3>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/tasks">Công việc</a></li>
                        <li><a href="#">Nhà tuyển dụng</a></li>
                        <li><a href="#">Ứng viên</a></li>
                        <li><a href="help.jsp">Trợ giúp</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3 class="footer-title">Thông tin liên hệ</h3>
                    <ul class="footer-contact">
                        <li><i class="fas fa-map-marker-alt"></i> VIETNAM</li>
                        <li><i class="fas fa-phone"></i> 0 1234 5678</li>
                        <li><i class="fas fa-envelope"></i> info@joblinks.vn</li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3 class="footer-title">Đăng ký nhận bản tin</h3>
                    <form class="newsletter-form">
                        <input type="email" placeholder="Email của bạn" class="form-control">
                        <button type="submit" class="btn btn-primary">Đăng ký</button>
                    </form>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 JobLinks. Bảo lưu mọi quyền.</p>
                <div class="footer-legal">
                    <a href="#">Điều khoản sử dụng</a>
                    <a href="#">Chính sách bảo mật</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Back to Top Button -->
    <a href="#" class="back-to-top" id="backToTop">
        <i class="fas fa-arrow-up"></i>
    </a>

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