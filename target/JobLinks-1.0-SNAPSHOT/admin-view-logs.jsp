<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Nhật ký hệ thống - Admin</title>
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">
    <style>
        body {
            font-size: 1.1rem;
        }
        .h1, .h2, .h3, .h4, .h5, .h6,
        h1, h2, h3, h4, h5, h6 {
            font-size: 1.25em;
        }
        .sidebar .nav-item .nav-link {
            font-size: 1.1rem;
        }
        .card .card-body .text-xs {
            font-size: 1rem !important;
        }
        .card .h5 {
            font-size: 1.4rem;
        }
        .navbar .nav-link,
        .navbar .dropdown-toggle {
            font-size: 1.1rem;
        }
        .form-control {
            font-size: 1.1rem;
        }
        .btn {
            font-size: 1.1rem;
        }
    </style>
</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <jsp:include page="admin_include/admin-sidebar.jsp" />

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column" style="margin-left: 240px;">

        <!-- Main Content -->
        <div id="content">

            <!-- Header -->
            <jsp:include page="admin_include/admin-header.jsp" />

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800"><i class="fas fa-history"></i> Nhật ký hệ thống</h1>
                </div>

                <!-- Logs Table -->
                <div class="card shadow mb-4">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-sm" width="100%" cellspacing="0">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>#</th>
                                        <th>Email</th> <!-- ✅ Đổi từ "Người dùng" -->
                                        <th>Hành động</th>
                                        <th>Đối tượng</th>
                                        <th>Mô tả</th>
                                        <th>Thời gian</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="log" items="${logs}">
                                        <tr>
                                            <td>${log.logId}</td>
                                            <td>${log.email}</td> <!-- ✅ Đổi từ username -->
                                            <td>${log.action}</td>
                                            <td>${log.target}</td>
                                            <td>${log.description}</td>
                                            <td>${log.timestamp}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div> <!-- /.container-fluid -->

        </div> <!-- End of Main Content -->

    </div> <!-- End of Content Wrapper -->

</div> <!-- End of Page Wrapper -->

<!-- Scripts -->
<script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>

</body>
</html>
