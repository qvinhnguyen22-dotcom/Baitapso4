<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard | Admin</title>
</head>
<body>
<div class="mb-4">
    <p class="text-primary fw-semibold mb-1">QUẢN TRỊ</p>
    <h1 class="h3 fw-bold mb-0">Bảng điều khiển</h1>
</div>
<div class="row g-4">
    <div class="col-md-6 col-xl-4">
        <a class="text-decoration-none" href="<c:url value='/admin/categories'/>">
            <div class="admin-card p-4">
                <div class="text-secondary">Danh mục</div>
                <div class="display-6 fw-bold text-dark">${categoryCount}</div>
            </div>
        </a>
    </div>
    <div class="col-md-6 col-xl-4">
        <a class="text-decoration-none" href="<c:url value='/admin/users'/>">
            <div class="admin-card p-4">
                <div class="text-secondary">Người dùng</div>
                <div class="display-6 fw-bold text-dark">${userCount}</div>
            </div>
        </a>
    </div>
</div>
</body>
</html>
