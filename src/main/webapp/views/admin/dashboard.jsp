<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Quản Trị | Admin Portal</title>
</head>
<body>
<div class="mb-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-1 small text-secondary">
            <li class="breadcrumb-item"><a href="<c:url value='/admin'/>" class="text-decoration-none">Admin</a></li>
            <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
        </ol>
    </nav>
    <h2 class="h4 fw-bold mb-0 text-dark">
        <i class="fa-solid fa-gauge-high text-primary me-2"></i>Tổng Quan Hệ Thống
    </h2>
</div>

<div class="row g-4 mb-4">
    <!-- Category Stat Card -->
    <div class="col-sm-6 col-xl-4">
        <div class="admin-card p-4 h-100 position-relative overflow-hidden">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary fw-semibold small text-uppercase mb-1">Quản lý Danh mục</div>
                    <div class="display-6 fw-bold text-dark">${categoryCount}</div>
                </div>
                <div class="rounded-3 p-3 bg-primary-subtle text-primary fs-3">
                    <i class="fa-solid fa-layer-group"></i>
                </div>
            </div>
            <hr class="my-3 text-secondary opacity-25">
            <div class="d-flex justify-content-between align-items-center">
                <a href="<c:url value='/admin/categories'/>" class="text-decoration-none small fw-semibold text-primary">
                    Xem danh sách <i class="fa-solid fa-arrow-right ms-1"></i>
                </a>
                <a href="<c:url value='/admin/category/add'/>" class="btn btn-sm btn-outline-primary py-0.5 px-2">
                    <i class="fa-solid fa-plus me-1"></i>Thêm
                </a>
            </div>
        </div>
    </div>

    <!-- User Stat Card -->
    <div class="col-sm-6 col-xl-4">
        <div class="admin-card p-4 h-100 position-relative overflow-hidden">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary fw-semibold small text-uppercase mb-1">Quản lý Người dùng</div>
                    <div class="display-6 fw-bold text-dark">${userCount}</div>
                </div>
                <div class="rounded-3 p-3 bg-success-subtle text-success fs-3">
                    <i class="fa-solid fa-users"></i>
                </div>
            </div>
            <hr class="my-3 text-secondary opacity-25">
            <div class="d-flex justify-content-between align-items-center">
                <a href="<c:url value='/admin/users'/>" class="text-decoration-none small fw-semibold text-success">
                    Xem danh sách <i class="fa-solid fa-arrow-right ms-1"></i>
                </a>
                <a href="<c:url value='/admin/user/add'/>" class="btn btn-sm btn-outline-success py-0.5 px-2">
                    <i class="fa-solid fa-user-plus me-1"></i>Thêm
                </a>
            </div>
        </div>
    </div>

    <!-- Quick Shortcuts Card -->
    <div class="col-sm-12 col-xl-4">
        <div class="admin-card p-4 h-100">
            <div class="text-secondary fw-semibold small text-uppercase mb-3">Thao tác nhanh</div>
            <div class="d-grid gap-2">
                <a href="<c:url value='/admin/category/add'/>" class="btn btn-outline-primary text-start">
                    <i class="fa-solid fa-folder-plus me-2"></i>Thêm danh mục mới
                </a>
                <a href="<c:url value='/admin/user/add'/>" class="btn btn-outline-success text-start">
                    <i class="fa-solid fa-user-plus me-2"></i>Thêm người dùng mới
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
