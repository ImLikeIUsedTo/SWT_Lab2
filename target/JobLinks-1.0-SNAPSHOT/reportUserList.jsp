<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Danh sách báo cáo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f9f9f9; font-family: Arial, sans-serif; }
        .report-wrapper1 {
            max-width: 1200px;
            margin: 140px auto 60px;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .table {
            border-radius: 15px; /* Bo tròn góc bảng */
            overflow: hidden; /* Đảm bảo các góc bo tròn áp dụng cho toàn bộ bảng */
        }
        .table th, .table td { vertical-align: middle; }
        .table th {
            background-color: #43945B; /* Màu nền hàng đầu */
            color: white; /* Màu chữ trắng để tương phản */
        }
        .pagination { margin-top: 20px; }
        .warning-box {
            background-color: #fff3cd; 
            color: #856404; 
            border: 1px solid #ffeeba; 
            padding: 15px; 
            margin: 20px 0; 
            border-radius: 8px;
            text-align: center; 
            font-weight: bold; 
            display: flex; 
            align-items: center; 
            justify-content: center;
        }
        .warning-box i {
            margin-right: 10px; 
            font-size: 1.3em; 
            color: #d39e00; 
        }
        @media (max-width: 768px) {
            .report-wrapper1 { margin: 100px 10px 20px; padding: 15px; }
            .table { font-size: 0.9em; }
            .table th, .table td { padding: 6px; }
        }
    </style>
</head>
<body>
<%@ include file="header-layout.jsp" %>

<div class="report-wrapper1">
    <h2 class="mb-4 text-center">
        <i class="fas fa-flag"></i> Danh sách người bạn đã báo cáo
    </h2>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center"><c:out value="${errorMessage}" /></div>
    </c:if>
        
    <c:if test="${empty sessionScope.user}">
        <div class="warning-box">
            <i class="fas fa-exclamation-triangle"></i> Bạn phải đăng nhập mới xem tiếp được nội dung. 
        </div>
    </c:if> 
    <c:if test="${not empty sessionScope.user}"> 
        <table class="table table-bordered table-hover">
            <thead class="table-light">
                <tr>
                    <th>STT</th>
                    <th>Người bị báo cáo</th>
                    <th>Nội dung</th>
                    <th>Task liên quan</th>
                    <th>Thời gian</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty reportList}">
                        <c:forEach var="r" items="${reportList}" varStatus="loop">
                            <tr>
                                <td><c:out value="${loop.count}" /></td>
                                <td><c:out value="${r.reportedName}" /></td>
                                <td><c:out value="${r.message}" /></td>
                                <td><c:out value="${r.taskId != null ? r.taskId : 'Không có'}" escapeXml="true" /></td>
                                <td><c:out value="${r.reportTime}" /></td>
                                <td>
                                    <span class="badge bg-${r.status == 'resolved' ? 'success' : 'warning'} text-capitalize">
                                        <c:out value="${r.status}" />
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${not empty sessionScope.user && empty reportList}">
                            <tr>
                                <td colspan="8" class="text-center">
                                    <div class="warning-box">
                                        <i class="fas fa-exclamation-triangle"></i> Bạn chưa gửi báo cáo nào.
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </c:if>   
    
    <c:if test="${not empty reports}">
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <c:set var="totalPages" value="${(totalReports + pageSize - 1) / pageSize}" />
                <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}" />
                <c:set var="endPage" value="${startPage + 4 > totalPages ? totalPages : startPage + 4}" />
                <c:set var="startPage" value="${endPage - 4 < 1 ? 1 : startPage}" />

                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="reportUserList?page=${currentPage - 1}&userId=${userId}">Trước</a>
                    </li>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="reportUserList?page=${i}&userId=${userId}">${i}</a>
                    </li>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="reportUserList?page=${currentPage + 1}&userId=${userId}">Sau</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </c:if>
</div>

<%@ include file="footer.jsp" %>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Thêm JavaScript để redirect nếu không có dữ liệu -->
<script>
    window.onload = function() {
        if (${empty reportList} && ${not empty sessionScope.user}) {
            window.location.href = "/JobLinks/ReportUserListServlet";
        }
    };
</script>
</body>
</html>