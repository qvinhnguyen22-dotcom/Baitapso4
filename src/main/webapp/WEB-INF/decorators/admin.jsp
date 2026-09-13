<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sitemesh" uri="http://www.sitemesh.org/sitemesh3" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><sitemesh:write property="title" default="Admin | QuangVinh"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value='/assets/css/app.css'/>" rel="stylesheet">
    <style>
        .admin-shell { min-height: 100vh; }
        .admin-sidebar { width: 260px; background: #111827; }
        .admin-sidebar .nav-link { color: #cbd5e1; border-radius: .6rem; }
        .admin-sidebar .nav-link.active,
        .admin-sidebar .nav-link:hover { background: #4f46e5; color: #fff; }
        .admin-content { background: #f6f8fc; }
    </style>
    <sitemesh:write property="head"/>
</head>
<body class="admin-shell">
<div class="d-flex">
    <aside class="admin-sidebar min-vh-100 p-3 d-none d-lg-flex flex-column">
        <a class="navbar-brand text-white fw-bold mb-4 d-flex align-items-center gap-2" href="<c:url value='/admin'/>">
            <i class="fa-solid fa-gauge-high"></i> QuangVinh Admin
        </a>
        <nav class="nav flex-column gap-1">
            <a class="nav-link" href="<c:url value='/admin'/>"><i class="fa-solid fa-house me-2"></i>Dashboard</a>
            <a class="nav-link" href="<c:url value='/admin/categories'/>"><i class="fa-solid fa-layer-group me-2"></i>Danh mục</a>
            <a class="nav-link" href="<c:url value='/admin/users'/>"><i class="fa-solid fa-users me-2"></i>Người dùng</a>
            <a class="nav-link" href="<c:url value='/admin/products'/>"><i class="fa-solid fa-box me-2"></i>Sản phẩm</a>
        </nav>
        <div class="mt-auto pt-4">
            <a class="nav-link" href="<c:url value='/home'/>"><i class="fa-solid fa-store me-2"></i>Về cửa hàng</a>
            <a class="nav-link text-danger" href="<c:url value='/logout'/>"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a>
        </div>
    </aside>
    <div class="flex-grow-1 admin-content min-vh-100">
        <nav class="navbar navbar-expand-lg bg-white border-bottom sticky-top">
            <div class="container-fluid px-4">
                <button class="btn btn-outline-secondary d-lg-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#adminMenu">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <span class="ms-2 fw-semibold">Xin chào, ${sessionScope.currentUser.fullname}</span>
                <a class="btn btn-sm btn-outline-primary ms-auto" href="<c:url value='/profile'/>">Hồ sơ</a>
            </div>
        </nav>
        <div class="offcanvas offcanvas-start bg-dark text-white d-lg-none" id="adminMenu">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title">Admin</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body">
                <a class="d-block text-white py-2" href="<c:url value='/admin'/>">Dashboard</a>
                <a class="d-block text-white py-2" href="<c:url value='/admin/categories'/>">Danh mục</a>
                <a class="d-block text-white py-2" href="<c:url value='/admin/users'/>">Người dùng</a>
                <a class="d-block text-white py-2" href="<c:url value='/admin/products'/>">Sản phẩm</a>
            </div>
        </div>
        <main class="container-fluid px-4 py-4">
            <sitemesh:write property="body"/>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
