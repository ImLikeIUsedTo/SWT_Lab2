<%-- 
    Document   : footer
    Created on : Jun 14, 2025, 10:48:11 PM
    Author     : lylua
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
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
