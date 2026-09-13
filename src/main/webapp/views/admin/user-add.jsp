<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm người dùng | Admin</title>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="admin-card p-4">
            <h2 class="h4 mb-4">Thêm người dùng</h2>
            <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
            <form action="<c:url value='/admin/user/insert'/>" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label">Họ tên</label>
                    <input type="text" name="fullname" class="form-control" value="${user.fullname}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" value="${user.email}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" value="${user.username}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Mật khẩu</label>
                    <input type="password" name="password" class="form-control" minlength="6" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Số điện thoại</label>
                    <input type="text" name="phone" class="form-control" value="${user.phone}">
                </div>
                <div class="mb-3">
                    <label class="form-label">Link ảnh</label>
                    <input type="url" name="images" class="form-control" placeholder="https://example.com/avatar.jpg">
                </div>
                <div class="mb-3">
                    <label class="form-label">Upload ảnh</label>
                    <input type="file" name="images1" class="form-control" accept=".jpg,.jpeg,.png,.gif">
                </div>
                <div class="mb-3">
                    <label class="form-label">Vai trò</label>
                    <select name="role" class="form-select">
                        <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>USER</option>
                        <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                    </select>
                </div>
                <div class="mb-4">
                    <label class="form-label">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="true" ${user.status ? 'selected' : ''}>Đã kích hoạt</option>
                        <option value="false" ${!user.status ? 'selected' : ''}>Chưa kích hoạt</option>
                    </select>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Lưu</button>
                    <a href="<c:url value='/admin/users'/>" class="btn btn-secondary">Quay lại</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
