<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa Người Dùng | Admin Portal</title>
</head>
<body>
<!-- Breadcrumb & Header -->
<div class="mb-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-1 small text-secondary">
            <li class="breadcrumb-item"><a href="<c:url value='/admin'/>" class="text-decoration-none">Admin</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/admin/users'/>" class="text-decoration-none">Người dùng</a></li>
            <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa #${user.id}</li>
        </ol>
    </nav>
    <h2 class="h4 fw-bold mb-0 text-dark">
        <i class="fa-solid fa-user-pen text-primary me-2"></i>Chỉnh sửa Người Dùng #${user.id}
    </h2>
</div>

<div class="row justify-content-center">
    <div class="col-lg-9">
        <div class="admin-card p-4 p-md-5">
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form action="<c:url value='/admin/user/update'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${user.id}">

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" name="fullname" class="form-control" value="${user.fullname}" 
                               placeholder="Nguyễn Văn A" minlength="2" maxlength="200" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Tên đăng nhập (Username) <span class="text-danger">*</span></label>
                        <input type="text" name="username" class="form-control" value="${user.username}" 
                               placeholder="username123" minlength="3" maxlength="50" pattern="^[A-Za-z0-9_]{3,50}$" required>
                        <div class="form-text">Từ 3-50 ký tự, gồm chữ cái, số và dấu gạch dưới.</div>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Địa chỉ Email <span class="text-danger">*</span></label>
                        <input type="email" name="email" class="form-control" value="${user.email}" 
                               placeholder="email@example.com" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Mật khẩu mới (Tùy chọn)</label>
                        <input type="password" name="password" class="form-control" minlength="6" 
                               placeholder="Để trống nếu không muốn đổi mật khẩu">
                        <div class="form-text">Chỉ nhập khi muốn cập nhật mật khẩu mới cho người dùng.</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Số điện thoại</label>
                    <input type="tel" name="phone" class="form-control" value="${user.phone}" 
                           placeholder="0912345678" pattern="[0-9]{10,11}">
                    <div class="form-text">Gồm 10 hoặc 11 chữ số.</div>
                </div>

                <!-- Avatar Selection -->
                <div class="row g-3 mb-3">
                    <div class="col-md-7">
                        <label class="form-label fw-semibold">Link ảnh đại diện (URL)</label>
                        <input type="url" name="images" id="avatarUrlInput" class="form-control" value="${user.images}" 
                               placeholder="https://images.unsplash.com/photo-...">
                        <div class="form-text">Để nguyên link cũ hoặc nhập link ảnh mới.</div>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label fw-semibold">Hoặc Tải ảnh mới</label>
                        <input type="file" name="images1" id="avatarFileInput" class="form-control" accept=".jpg,.jpeg,.png,.gif,image/*">
                        <div class="form-text">Chọn file nếu muốn thay thế ảnh hiện tại.</div>
                    </div>
                </div>

                <!-- Avatar Preview Box -->
                <div class="mb-4">
                    <label class="form-label fw-semibold text-secondary small">ẢNH ĐẠI DIỆN HIỆN TẠI / XEM TRƯỚC</label>
                    <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3 border">
                        <c:choose>
                            <c:when test="${not empty user.avatar and (user.avatar.startsWith('http://') or user.avatar.startsWith('https://'))}">
                                <img id="avatarPreview" src="${user.avatar}" alt="${user.fullname}" 
                                     class="rounded-circle shadow-sm border" style="width: 80px; height: 80px; object-fit: cover;"
                                     onerror="this.onerror=null;this.src='https://placehold.co/100x100?text=Avatar';">
                            </c:when>
                            <c:when test="${not empty user.avatar}">
                                <img id="avatarPreview" src="<c:url value='/image?fname=${user.avatar}'/>" alt="${user.fullname}" 
                                     class="rounded-circle shadow-sm border" style="width: 80px; height: 80px; object-fit: cover;"
                                     onerror="this.onerror=null;this.src='https://placehold.co/100x100?text=Avatar';">
                            </c:when>
                            <c:otherwise>
                                <img id="avatarPreview" src="https://placehold.co/100x100?text=No+Avatar" alt="Avatar" 
                                     class="rounded-circle shadow-sm border" style="width: 80px; height: 80px; object-fit: cover;">
                            </c:otherwise>
                        </c:choose>
                        <div class="small text-secondary">
                            <div><i class="fa-solid fa-circle-info me-1"></i>Ảnh đại diện hiện tại.</div>
                            <div class="text-muted">Khi bạn chọn file mới hoặc dán link URL mới, ảnh này sẽ tự cập nhật.</div>
                        </div>
                    </div>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Vai trò (Role)</label>
                        <select name="role" class="form-select">
                            <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>Người dùng (USER)</option>
                            <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Quản trị viên (ADMIN)</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Trạng thái kích hoạt</label>
                        <select name="status" class="form-select">
                            <option value="true" ${user.status ? 'selected' : ''}>Đã kích hoạt (Hoạt động)</option>
                            <option value="false" ${!user.status ? 'selected' : ''}>Chưa kích hoạt (Khóa)</option>
                        </select>
                    </div>
                </div>

                <div class="d-flex gap-2 pt-3 border-top">
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fa-solid fa-check me-1.5"></i>Cập nhật người dùng
                    </button>
                    <a href="<c:url value='/admin/users'/>" class="btn btn-outline-secondary px-4">
                        <i class="fa-solid fa-xmark me-1.5"></i>Hủy bỏ
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    const urlInput = document.getElementById('avatarUrlInput');
    const fileInput = document.getElementById('avatarFileInput');
    const preview = document.getElementById('avatarPreview');

    urlInput.addEventListener('input', function() {
        if (this.value.trim().length > 0) {
            preview.src = this.value.trim();
        }
    });

    fileInput.addEventListener('change', function() {
        if (this.files && this.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
            };
            reader.readAsDataURL(this.files[0]);
        }
    });

    preview.onerror = function() {
        this.src = 'https://placehold.co/100x100?text=Lỗi+ảnh';
    };
</script>
</body>
</html>
