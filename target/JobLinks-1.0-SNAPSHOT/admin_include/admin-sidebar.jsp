<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">JobLinks Admin</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item">
        <a class="nav-link" href="admin-dashboard.jsp">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
    </li>

    <!-- Nav Item - View User List -->
    <li class="nav-item">
        <a class="nav-link" href="AdminManageUserServlet">
            <i class="fas fa-users"></i>
            <span>View User List</span>
        </a>
    </li>

    <!-- Nav Item - View User Tasks -->
    <li class="nav-item">
        <a class="nav-link" href="AdminManageTaskServlet">
            <i class="fas fa-tasks"></i>
            <span>View User Tasks</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

</ul>
<!-- End of Sidebar -->
