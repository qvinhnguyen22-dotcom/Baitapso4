<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sitemesh" uri="http://www.sitemesh.org/sitemesh3" %>
<c:set var="reqUri" value="${requestScope['jakarta.servlet.forward.request_uri'] != null ? requestScope['jakarta.servlet.forward.request_uri'] : pageContext.request.requestURI}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><sitemesh:write property="title" default="Admin | QuangVinh"/></title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value='/assets/css/app.css'/>" rel="stylesheet">
    <style>
        .admin-shell { min-height: 100vh; background-color: #f1f5f9; font-family: 'Inter', system-ui, -apple-system, sans-serif; }
        .admin-sidebar { width: 270px; background: #0f172a; border-right: 1px solid rgba(255,255,255,0.05); }
        .admin-sidebar .brand-title { font-size: 1.15rem; font-weight: 700; color: #fff; letter-spacing: -0.02em; }
        .admin-sidebar .nav-label { font-size: 0.72rem; text-transform: uppercase; font-weight: 700; color: #64748b; margin: 1rem 0 0.5rem 0.75rem; letter-spacing: 0.06em; }
        .admin-sidebar .nav-link { color: #94a3b8; font-weight: 500; font-size: 0.92rem; padding: 0.7rem 0.9rem; border-radius: 0.6rem; transition: all 0.2s ease; display: flex; align-items: center; }
        .admin-sidebar .nav-link:hover { color: #ffffff; background: rgba(255,255,255,0.06); }
        .admin-sidebar .nav-link.active { color: #ffffff; background: #4f46e5; font-weight: 600; box-shadow: 0 4px 12px rgba(79, 70, 229, 0.35); }
        .admin-sidebar .nav-link i { font-size: 1.05rem; width: 24px; }
        .admin-content { background: #f8fafc; }
        .admin-topbar { height: 68px; background: #ffffff; border-bottom: 1px solid #e2e8f0; }
        .user-avatar-topbar { width: 38px; height: 38px; border-radius: 50%; object-fit: cover; border: 2px solid #e2e8f0; }
        .admin-card { background: #ffffff; border-radius: 0.85rem; border: 1px solid #e2e8f0; box-shadow: 0 1px 3px rgba(0,0,0,0.03); }
    </style>
    <sitemesh:write property="head"/>
</head>
<body class="admin-shell">
<div class="d-flex">
    <!-- Desktop Sidebar -->
    <aside class="admin-sidebar min-vh-100 p-3 d-none d-lg-flex flex-column position-sticky top-0" style="height: 100vh; overflow-y: auto;">
        <a class="brand-title mb-4 px-2 d-flex align-items-center gap-2 text-decoration-none" href="<c:url value='/admin'/>">
            <span class="d-inline-flex align-items-center justify-content-center bg-primary text-white rounded-3 p-2 shadow-sm" style="width: 38px; height: 38px;">
                <i class="fa-solid fa-shield-halved"></i>
            </span>
            <span>Admin Portal</span>
        </a>

        <div class="nav-label">TỔNG QUAN</div>
        <nav class="nav flex-column gap-1">
            <a class="nav-link ${reqUri == '/admin' or reqUri == '/admin/' ? 'active' : ''}" href="<c:url value='/admin'/>">
                <i class="fa-solid fa-chart-pie me-2"></i>Dashboard
            </a>
        </nav>

        <div class="nav-label">QUẢN TRỊ NỘI DUNG</div>
        <nav class="nav flex-column gap-1">
            <a class="nav-link ${reqUri.contains('/admin/categor') ? 'active' : ''}" href="<c:url value='/admin/categories'/>">
                <i class="fa-solid fa-layer-group me-2"></i>Quản lý Danh mục
            </a>
            <a class="nav-link ${reqUri.contains('/admin/user') ? 'active' : ''}" href="<c:url value='/admin/users'/>">
                <i class="fa-solid fa-users me-2"></i>Quản lý Người dùng
            </a>
            <a class="nav-link ${reqUri.contains('/admin/product') ? 'active' : ''}" href="<c:url value='/admin/products'/>">
                <i class="fa-solid fa-boxes-stacked me-2"></i>Quản lý Sản phẩm
            </a>
        </nav>

        <div class="mt-auto pt-4 border-top border-secondary border-opacity-25">
            <a class="nav-link text-slate-300" href="<c:url value='/home'/>">
                <i class="fa-solid fa-shop me-2"></i>Xem Website
            </a>
            <a class="nav-link text-danger" href="<c:url value='/logout'/>">
                <i class="fa-solid fa-arrow-right-from-bracket me-2"></i>Đăng xuất
            </a>
        </div>
    </aside>

    <!-- Main Content Area -->
    <div class="flex-grow-1 admin-content min-vh-100 d-flex flex-column" style="min-width: 0;">
        <!-- Top Navbar -->
        <nav class="navbar admin-topbar sticky-top px-3 px-lg-4">
            <div class="container-fluid px-0">
                <button class="btn btn-sm btn-outline-secondary d-lg-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#adminMenu">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="d-none d-md-flex align-items-center gap-2">
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle fw-semibold px-2.5 py-1.5">
                        <i class="fa-solid fa-crown me-1"></i>Hệ thống Quản trị
                    </span>
                </div>
                <div class="ms-auto d-flex align-items-center gap-3">
                    <div class="d-flex align-items-center gap-2">
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser.avatar and (sessionScope.currentUser.avatar.startsWith('http://') or sessionScope.currentUser.avatar.startsWith('https://'))}">
                                <img src="${sessionScope.currentUser.avatar}" alt="Avatar" class="user-avatar-topbar">
                            </c:when>
                            <c:when test="${not empty sessionScope.currentUser.avatar}">
                                <img src="<c:url value='/image?fname=${sessionScope.currentUser.avatar}'/>" alt="Avatar" class="user-avatar-topbar">
                            </c:when>
                            <c:otherwise>
                                <span class="user-avatar-topbar bg-light text-primary d-inline-flex align-items-center justify-content-center fw-bold">
                                    <i class="fa-solid fa-user-tie"></i>
                                </span>
                            </c:otherwise>
                        </c:choose>
                        <div class="d-none d-sm-block text-start">
                            <div class="fw-bold text-dark text-truncate" style="max-width: 160px; font-size: 0.9rem;">
                                ${sessionScope.currentUser.fullname}
                            </div>
                            <small class="text-secondary" style="font-size: 0.75rem;">
                                <span class="badge bg-danger py-0.5 px-1.5">${sessionScope.currentUser.role}</span>
                            </small>
                        </div>
                    </div>
                    <a class="btn btn-sm btn-outline-primary" href="<c:url value='/profile'/>" title="Hồ sơ cá nhân">
                        <i class="fa-solid fa-user-gear me-1"></i>Hồ sơ
                    </a>
                </div>
            </div>
        </nav>

        <!-- Offcanvas Mobile Sidebar -->
        <div class="offcanvas offcanvas-start bg-dark text-white d-lg-none" id="adminMenu">
            <div class="offcanvas-header border-bottom border-secondary border-opacity-25">
                <h5 class="offcanvas-title fw-bold text-white d-flex align-items-center gap-2">
                    <i class="fa-solid fa-shield-halved text-primary"></i> Admin Portal
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body p-3">
                <nav class="nav flex-column gap-1">
                    <a class="nav-link text-white py-2.5 px-3 rounded-2 ${reqUri == '/admin' or reqUri == '/admin/' ? 'bg-primary' : ''}" href="<c:url value='/admin'/>">
                        <i class="fa-solid fa-chart-pie me-2"></i>Dashboard
                    </a>
                    <a class="nav-link text-white py-2.5 px-3 rounded-2 ${reqUri.contains('/admin/categor') ? 'bg-primary' : ''}" href="<c:url value='/admin/categories'/>">
                        <i class="fa-solid fa-layer-group me-2"></i>Quản lý Danh mục
                    </a>
                    <a class="nav-link text-white py-2.5 px-3 rounded-2 ${reqUri.contains('/admin/user') ? 'bg-primary' : ''}" href="<c:url value='/admin/users'/>">
                        <i class="fa-solid fa-users me-2"></i>Quản lý Người dùng
                    </a>
                    <a class="nav-link text-white py-2.5 px-3 rounded-2 ${reqUri.contains('/admin/product') ? 'bg-primary' : ''}" href="<c:url value='/admin/products'/>">
                        <i class="fa-solid fa-boxes-stacked me-2"></i>Quản lý Sản phẩm
                    </a>
                    <hr class="border-secondary my-3">
                    <a class="nav-link text-white py-2" href="<c:url value='/home'/>">
                        <i class="fa-solid fa-shop me-2"></i>Xem Website
                    </a>
                    <a class="nav-link text-danger py-2" href="<c:url value='/logout'/>">
                        <i class="fa-solid fa-arrow-right-from-bracket me-2"></i>Đăng xuất
                    </a>
                </nav>
            </div>
        </div>

        <!-- Body Content -->
        <main class="container-fluid px-3 px-lg-4 py-4 flex-grow-1">
            <sitemesh:write property="body"/>
        </main>

        <!-- Footer -->
        <footer class="py-3 px-4 bg-white border-top text-center text-secondary small">
            &copy; 2026 QuangVinh Admin Portal &bull; Spring Boot & JPA &bull; Sitemesh 3
        </footer>
    </div>
</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
