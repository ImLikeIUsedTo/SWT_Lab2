<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Đã Hoàn Thành</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --danger-color: #e74a3b;
            --warning-color: #f6c23e;
            --light-color: #f8f9fc;
            --dark-color: #5a5c69;
            --info-color: #36b9cc;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fc;
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header styles */
        .header {
            background-color: white;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(44, 62, 80, 0.15);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .logo-img {
            height: 40px;
        }

        .menu {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .greeting {
            font-weight: 500;
            color: #2c3e50;
            margin-right: 20px;
        }

        .nav {
            display: flex;
            gap: 15px;
        }

        .nav-link {
            color: #2c3e50;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: color 0.3s;
        }

        .nav-link.active, .nav-link:hover {
            color: #3498db;
        }

        .header-actions, .dropdown {
            margin-left: auto;
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-toggle {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.5rem;
            color: #2c3e50;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            border-radius: 0.35rem;
            min-width: 200px;
            z-index: 1000;
        }

        .dropdown-menu.show {
            display: block;
        }

        .dropdown-item {
            display: block;
            padding: 0.5rem 1rem;
            color: #2c3e50;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .dropdown-item:hover {
            background-color: #ecf0f1;
            color: #3498db;
        }

        /* Main content styles */
        .main-content {
            flex: 1;
            padding: 2rem 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            font-size: 1.75rem;
            color: var(--dark-color);
            font-weight: 700;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .breadcrumb a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .breadcrumb-separator {
            color: var(--dark-color);
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
            font-size: 0.9rem;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: #2e59d9;
            transform: translateY(-1px);
        }

        .btn-danger {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-danger:hover {
            background-color: #be2617;
        }

        .btn-secondary {
            background-color: var(--secondary-color);
            color: white;
        }

        .btn-secondary:hover {
            background-color: #17a673;
        }

        .btn-info {
            background-color: var(--info-color);
            color: white;
        }

        .btn-info:hover {
            background-color: #2c9faf;
        }

        .card {
            background-color: white;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 30px;
            overflow: hidden;
        }

        .card-header {
            padding: 1rem 1.35rem;
            background-color: #f8f9fc;
            border-bottom: 1px solid #e3e6f0;
            font-weight: 700;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-body {
            padding: 1.35rem;
        }

        .task-item {
            padding: 1.5rem 0;
            border-bottom: 1px solid #e3e6f0;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .task-item:last-child {
            border-bottom: none;
        }

        .task-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .task-info {
            flex: 1;
            min-width: 300px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .task-title {
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
        }

        .task-description {
            color: var(--dark-color);
            margin-bottom: 1rem;
            line-height: 1.5;
        }

        .task-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 10px;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: var(--dark-color);
            font-size: 0.9rem;
            padding: 0.25rem 0.5rem;
            background-color: #f8f9fc;
            border-radius: 0.25rem;
        }

        .meta-item i {
            color: var(--primary-color);
        }

        .task-status {
            padding: 0.35rem 0.75rem;
            border-radius: 0.25rem;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background-color: var(--warning-color);
            color: white;
        }

        .status-active {
            background-color: var(--secondary-color);
            color: white;
        }

        .status-completed {
            background-color: var(--info-color);
            color: white;
        }

        .status-cancelled {
            background-color: var(--danger-color);
            color: white;
        }

        .task-actions {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .alert {
            padding: 1rem;
            border-radius: 0.35rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            color: var(--dark-color);
        }

        .empty-state i {
            font-size: 4rem;
            color: #dddfeb;
            margin-bottom: 1.5rem;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--dark-color);
        }

        .empty-state p {
            font-size: 1rem;
            color: #858796;
        }

        /* Applications section */
        .applications-section {
            margin-top: 1.5rem;
            border-top: 1px solid #e3e6f0;
            padding-top: 1.5rem;
        }

        .applications-header {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
            color: var(--dark-color);
            font-weight: 600;
        }

        .application-item {
            background-color: #f8f9fc;
            border-radius: 0.35rem;
            padding: 1rem;
            margin-bottom: 1rem;
            border-left: 4px solid var(--primary-color);
        }

        .application-item:last-child {
            margin-bottom: 0;
        }

        .application-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .worker-name {
            font-weight: 600;
            color: var(--dark-color);
        }

        .application-message {
            margin: 0.5rem 0;
            color: var(--dark-color);
            font-style: italic;
        }

        .application-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
            font-size: 0.85rem;
        }

        /* Footer styles */
        .footer {
            background-color: #2c3e50;
            color: white;
            padding: 2rem 0 1rem;
            margin-top: auto;
        }

        .footer .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            box-shadow: none;
            background-color: transparent;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .footer-col h3 {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            color: white;
        }

        .footer-links, .footer-contact {
            list-style: none;
            padding: 0;
        }

        .footer-links li, .footer-contact li {
            margin-bottom: 0.5rem;
        }

        .footer-links a {
            color: #bdc3c7;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: #3498db;
        }

        .social-links a {
            color: #bdc3c7;
            margin: 0 10px;
            font-size: 1.2rem;
            transition: color 0.3s;
        }

        .social-links a:hover {
            color: #3498db;
        }

        .footer-bottom {
            border-top: 1px solid #34495e;
            padding-top: 1rem;
            text-align: center;
            color: #bdc3c7;
        }

        .footer-legal a {
            color: #bdc3c7;
            margin: 0 10px;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-legal a:hover {
            color: #3498db;
        }

        .back-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: var(--primary-color);
            color: white;
            padding: 12px 15px;
            border-radius: 50%;
            text-decoration: none;
            display: none;
            transition: all 0.3s;
            z-index: 1000;
        }

        .back-to-top.show {
            display: block;
        }

        .back-to-top:hover {
            background-color: #2e59d9;
            transform: translateY(-2px);
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .task-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .task-actions {
                width: 100%;
                justify-content: flex-start;
            }

            .task-meta {
                flex-direction: column;
                gap: 10px;
            }

            .application-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .footer-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <%@include file="jobPosterHeader.jsp" %>

    <div class="main-content">
        <div class="container">
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/home">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <span class="breadcrumb-separator">/</span>
                <span>Task Đã Hoàn Thành</span>
            </div>

            <div class="page-header">
                <div>
                    <h1 class="page-title">
                        <i class="fas fa-check-circle"></i> Task Đã Hoàn Thành
                    </h1>
                </div>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Danh sách task đã hoàn thành -->
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-list-check"></i>
                    <span>Danh sách Task Đã Hoàn Thành</span>
                    <c:if test="${not empty completedTasks}">
                        <span style="margin-left: auto; background-color: var(--info-color); color: white; padding: 0.25rem 0.5rem; border-radius: 0.25rem; font-size: 0.8rem;">
                            ${fn:length(completedTasks)} task
                        </span>
                    </c:if>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty completedTasks}">
                            <div class="empty-state">
                                <i class="fas fa-check-circle"></i>
                                <h3>Chưa có task nào hoàn thành</h3>
                                <p>Bạn chưa hoàn thành bất kỳ công việc nào. Hãy tạo và hoàn thành các task để xem chúng ở đây.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="task" items="${completedTasks}" varStatus="status">
                                <div class="task-item" id="task-${task.taskId}">
                                    <div class="task-header">
                                        <div class="task-info">
                                            <h3 class="task-title">
                                                <i class="fas fa-briefcase"></i> ${task.title}
                                            </h3>
                                            <div class="task-description">${task.description}</div>
                                            
                                            <div class="task-meta">
                                                <div class="meta-item">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                    <span>${task.location}</span>
                                                </div>
                                                <div class="meta-item">
                                                    <i class="fas fa-clock"></i>
                                                    <span>${task.scheduledTime}</span>
                                                </div>
                                                <div class="meta-item">
                                                    <i class="fas fa-money-bill-wave"></i>
                                                    <span>${task.budget} VND</span>
                                                </div>
                                                <span class="task-status status-${task.status.toLowerCase()}">
                                                    <i class="fas fa-check"></i> ${task.status}
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <div class="task-actions">
                                            <a href="${pageContext.request.contextPath}/viewTaskDetail?taskId=${task.taskId}" 
                                               class="btn btn-info">
                                                <i class="fas fa-eye"></i> Xem Chi Tiết
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Danh sách ứng tuyển -->
                                    <c:if test="${not empty applications[task.taskId]}">
                                        <div class="applications-section">
                                            <div class="applications-header">
                                                <i class="fas fa-users"></i>
                                                <span>Danh sách ứng tuyển (${fn:length(applications[task.taskId])})</span>
                                            </div>
                                            
                                            <c:forEach var="app" items="${applications[task.taskId]}">
                                                <div class="application-item">
                                                    <div class="application-header">
                                                        <div class="worker-name">
                                                            <i class="fas fa-user"></i> ${app.workerName}
                                                        </div>
                                                        <span class="task-status status-${app.status.toLowerCase()}">
                                                            ${app.status}
                                                        </span>
                                                    </div>
                                                    
                                                    <c:if test="${not empty app.message}">
                                                        <div class="application-message">
                                                            <i class="fas fa-quote-left"></i> "${app.message}"
                                                        </div>
                                                    </c:if>
                                                    
                                                    <div class="application-meta">
                                                        <div class="meta-item">
                                                            <i class="fas fa-calendar-alt"></i>
                                                            <span>Ứng tuyển lúc: ${app.appliedAt}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <%@include file="jobPosterFooter.jsp" %>

    <!-- Back to top button -->
    <a href="#" class="back-to-top" id="backToTop">
        <i class="fas fa-chevron-up"></i>
    </a>

    <script>
        // Dropdown functionality - Wait for all includes to load
        window.addEventListener('load', function() {
            // Try to find dropdown elements multiple times in case they load late
            let attempts = 0;
            const maxAttempts = 10;
            
            function initDropdown() {
                const dropdownButton = document.getElementById('dropdownMenuButton');
                const dropdownMenu = document.getElementById('dropdownMenu');
                
                if (dropdownButton && dropdownMenu) {
                    // Remove any existing event listeners to prevent duplicates
                    dropdownButton.removeEventListener('click', toggleDropdown);
                    dropdownButton.addEventListener('click', toggleDropdown);

                    document.removeEventListener('click', closeDropdownOnClickOutside);
                    document.addEventListener('click', closeDropdownOnClickOutside);
                    
                    console.log('Dropdown initialized successfully');
                    return true;
                } else {
                    attempts++;
                    if (attempts < maxAttempts) {
                        setTimeout(initDropdown, 100);
                    } else {
                        console.log('Dropdown elements not found after', maxAttempts, 'attempts');
                    }
                    return false;
                }
            }
            
            function toggleDropdown(event) {
                event.preventDefault();
                event.stopPropagation();
                const dropdownMenu = document.getElementById('dropdownMenu');
                if (dropdownMenu) {
                    dropdownMenu.classList.toggle('show');
                }
            }
            
            function closeDropdownOnClickOutside(event) {
                const dropdown = document.querySelector('.dropdown');
                const dropdownMenu = document.getElementById('dropdownMenu');
                if (dropdown && dropdownMenu && !dropdown.contains(event.target)) {
                    dropdownMenu.classList.remove('show');
                }
            }
            
            // Start trying to initialize dropdown
            initDropdown();

            // Back to top functionality
            const backToTop = document.getElementById('backToTop');
            if (backToTop) {
                window.addEventListener('scroll', function() {
                    if (window.pageYOffset > 300) {
                        backToTop.classList.add('show');
                    } else {
                        backToTop.classList.remove('show');
                    }
                });

                backToTop.addEventListener('click', function(e) {
                    e.preventDefault();
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                });
            }
        });
        
        // Alternative approach - try to initialize when DOM changes
        if (window.MutationObserver) {
            const observer = new MutationObserver(function(mutations) {
                mutations.forEach(function(mutation) {
                    if (mutation.type === 'childList') {
                        const dropdownButton = document.getElementById('dropdownMenuButton');
                        if (dropdownButton && !dropdownButton.hasAttribute('data-initialized')) {
                            dropdownButton.setAttribute('data-initialized', 'true');
                            dropdownButton.addEventListener('click', function(event) {
                                event.preventDefault();
                                event.stopPropagation();
                                const dropdownMenu = document.getElementById('dropdownMenu');
                                if (dropdownMenu) {
                                    dropdownMenu.classList.toggle('show');
                                }
                            });
                        }
                    }
                });
            });

            observer.observe(document.body, {
                childList: true,
                subtree: true
            });
        }

        // Smooth animations for task items
        document.addEventListener('DOMContentLoaded', function() {
            const taskItems = document.querySelectorAll('.task-item');
            taskItems.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    item.style.transition = 'all 0.5s ease';
                    item.style.opacity = '1';
                    item.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>