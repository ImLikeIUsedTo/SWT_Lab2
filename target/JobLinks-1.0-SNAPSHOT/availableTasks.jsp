<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${pageTitle}</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            margin-top: 20px;
        }
        .search-bar {
            background-color: #ffffff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .table-responsive {
            margin-top: 20px;
        }
        .table {
            border-radius: 10px;
            overflow: hidden;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .btn-primary {
            background-color: #6e8efb;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #5d7ce0;
        }
        .btn-secondary {
            background-color: #6c757d;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
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
        .back {
            padding: 10px 20px;
            background: #483C4F;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        .back:hover {
            background: #5a4d66; /* Thay đổi màu hover để tạo hiệu ứng */
        }
        .nav {
            margin-bottom: 20px;
        }
        .user-greeting {
            margin-right: 15px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Nút quay lại -->
    <button onclick="window.history.back()" class="back">
        <i class="fas fa-arrow-left"></i>← Quay lại
    </button>
    <!-- Navigation động -->
    <div class="nav">
        <!-- Hiển thị lời chào người dùng, kiểm tra userName để tránh lỗi -->
        <span class="user-greeting">Xin chào, <%= (request.getAttribute("userName") != null ? request.getAttribute("userName") : "Khách") %></span>
        <c:choose>
            <c:when test="${requestScope.currentPage == 'available'}">
                <a href="${pageContext.request.contextPath}/tasks?action=applied" class="link-custom">My Applications</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/tasks" class="link-custom">Available Tasks</a>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Tiêu đề trang -->
    <h1>${requestScope.pageTitle}</h1>

    <!-- Thông báo lỗi/thành công -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
        <c:remove var="error" scope="request"/>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
        <c:remove var="success" scope="request"/>
    </c:if>

    <!-- Thanh tìm kiếm -->
    <c:if test="${currentPage == 'available'}">
        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/tasks?action=list" method="get" class="row g-3">
                <input type="hidden" name="action" value="list"/>
                <div class="col-md-4">
                    <label for="searchKeyword" class="form-label">Từ khóa</label>
                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${searchKeyword}" placeholder="Nhập từ khóa...">
                </div>
                <div class="col-md-3">
                    <label for="location" class="form-label">Vị trí</label>
                    <input type="text" class="form-control" id="location" name="location" value="${location}" placeholder="Nhập vị trí...">
                </div>
                <div class="col-md-2">
                    <label for="budget" class="form-label">Ngân sách tối đa</label>
                    <input type="number" class="form-control" id="budget" name="budget" value="${budget}" min="0" placeholder="VD: 500">
                </div>
                <div class="col-md-2">
                    <label for="categoryId" class="form-label">Danh mục</label>
                    <select class="form-select" id="categoryId" name="categoryId">
                        <option value="">Tất cả</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}" ${categoryId == category.categoryId ? 'selected' : ''}>
                                ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-1 align-self-end">
                    <button type="submit" class="btn btn-primary w-100 mb-2">Tìm kiếm</button>
                    <button type="button" class="btn btn-secondary w-100" onclick="resetForm()">Reset</button>
                </div>
            </form>
        </div>
        <a href="${pageContext.request.contextPath}/boostTask" class="link-custom">Quản Lý Boost Task</a>
    </c:if>

    <!-- Bảng công việc -->
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Tiêu đề</th>
                    <th>Vị trí</th>
                    <th>Ngân sách</th>
                    <th>Thời gian tạo</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="task" items="${tasks}">
                    <tr>
                        <td>${task.title}</td>
                        <td>${task.location}</td>
                        <td>${task.budget} VND</td>
                        <td>${task.createdAt}</td>
                        <td>${task.status}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/tasks?action=details&taskId=${task.taskId}" class="btn btn-primary btn-sm">Xem chi tiết</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <c:if test="${empty tasks}">
        <p class="text-center mt-3">Không có công việc nào khả dụng.</p>
    </c:if>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function resetForm() {
        document.getElementById("searchKeyword").value = "";
        document.getElementById("location").value = "";
        document.getElementById("budget").value = "";
        document.getElementById("categoryId").value = "";
        document.querySelector("form").submit();
    }
</script>
</body>
</html>
