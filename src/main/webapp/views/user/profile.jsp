<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân | QuangVinh Store</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb small">
                <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Hồ sơ cá nhân</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-9">
                <!-- Card Hồ sơ cá nhân -->
                <div class="card border-0 shadow-sm rounded-4 p-4 p-lg-5 bg-white">
                    <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
                        <div class="rounded-circle bg-primary-subtle text-primary p-3 d-flex align-items-center justify-content-center" style="width: 56px; height: 56px;">
                            <i class="fa-solid fa-id-card fa-xl"></i>
                        </div>
                        <div>
                            <h1 class="h4 fw-bold mb-1">Thông Tin Hồ Sơ Cá Nhân</h1>
                            <p class="text-secondary small mb-0">Quản lý và cập nhật thông tin tài khoản của bạn trên hệ thống</p>
                        </div>
                    </div>

                    <!-- Thông báo trạng thái -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i>${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form class="needs-validation" novalidate action="<c:url value='/user/profile'/>" method="post" enctype="multipart/form-data">
                        <div class="row g-4 align-items-start">
                            <!-- Cột bên trái: Ảnh đại diện & Upload file -->
                            <div class="col-md-4 text-center border-end-md pb-4 pb-md-0">
                                <div class="position-relative d-inline-block mb-3">
                                    <c:choose>
                                        <c:when test="${not empty user.images and (user.images.startsWith('http://') or user.images.startsWith('https://'))}">
                                            <img id="avatarPreview" class="rounded-circle shadow border p-1 object-fit-cover" style="width: 170px; height: 170px;" src="${user.images}" alt="Ảnh đại diện">
                                        </c:when>
                                        <c:when test="${not empty user.images and user.images.startsWith('/')}">
                                            <img id="avatarPreview" class="rounded-circle shadow border p-1 object-fit-cover" style="width: 170px; height: 170px;" src="<c:url value='${user.images}'/>" alt="Ảnh đại diện">
                                        </c:when>
                                        <c:when test="${not empty user.images}">
                                            <img id="avatarPreview" class="rounded-circle shadow border p-1 object-fit-cover" style="width: 170px; height: 170px;" src="<c:url value='/image?fname=${user.images}'/>" alt="Ảnh đại diện">
                                        </c:when>
                                        <c:when test="${not empty user.avatar}">
                                            <img id="avatarPreview" class="rounded-circle shadow border p-1 object-fit-cover" style="width: 170px; height: 170px;" src="<c:url value='/image?fname=${user.avatar}'/>" alt="Ảnh đại diện">
                                        </c:when>
                                        <c:otherwise>
                                            <div id="defaultAvatarIcon" class="rounded-circle bg-primary-subtle text-primary d-inline-flex align-items-center justify-content-center shadow border" style="width: 170px; height: 170px;">
                                                <i class="fa-solid fa-user fa-5x"></i>
                                            </div>
                                            <img id="avatarPreview" class="rounded-circle shadow border p-1 object-fit-cover d-none" style="width: 170px; height: 170px;" src="#" alt="Ảnh xem trước">
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="mb-3 px-2">
                                    <label class="form-label fw-semibold small d-block mb-2 text-dark">
                                        <i class="fa-solid fa-camera me-1 text-primary"></i>Chọn ảnh đại diện mới
                                    </label>
                                    <input id="avatarInput" class="form-control form-control-sm" name="images" type="file" accept="image/jpeg,image/png,image/webp,image/gif">
                                    <div class="form-text text-muted small mt-2">
                                        Hỗ trợ JPG, PNG, WEBP hoặc GIF.<br>Dung lượng tối đa: <strong>5MB</strong>.
                                    </div>
                                    <div id="fileError" class="text-danger small mt-1 d-none"></div>
                                </div>
                            </div>

                            <!-- Cột bên phải: Các trường thông tin cá nhân -->
                            <div class="col-md-8 ps-md-4">
                                <div class="row g-3">
                                    <!-- Email (Readonly) -->
                                    <div class="col-12">
                                        <label class="form-label fw-semibold small text-secondary">
                                            Địa chỉ Email <span class="badge bg-secondary-subtle text-secondary ms-1">Không thể thay đổi</span>
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light"><i class="fa-solid fa-lock text-muted"></i></span>
                                            <input class="form-control bg-light" value="${user.email}" readonly tabindex="-1">
                                        </div>
                                    </div>

                                    <!-- Username (Readonly) -->
                                    <div class="col-12">
                                        <label class="form-label fw-semibold small text-secondary">
                                            Tên đăng nhập <span class="badge bg-secondary-subtle text-secondary ms-1">Không thể thay đổi</span>
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light"><i class="fa-solid fa-user-lock text-muted"></i></span>
                                            <input class="form-control bg-light" value="${user.username}" readonly tabindex="-1">
                                        </div>
                                    </div>

                                    <!-- Họ và tên (Editable) -->
                                    <div class="col-12">
                                        <label class="form-label fw-semibold small" for="fullname">
                                            Họ và tên <span class="text-danger">*</span>
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white"><i class="fa-regular fa-user text-primary"></i></span>
                                            <input id="fullname" name="fullname" value="${empty formFullname ? user.fullname : formFullname}" class="form-control" minlength="2" maxlength="100" required placeholder="Nhập họ và tên">
                                            <div class="invalid-feedback">Họ và tên không được để trống (từ 2 đến 100 ký tự).</div>
                                        </div>
                                    </div>

                                    <!-- Số điện thoại (Editable) -->
                                    <div class="col-12">
                                        <label class="form-label fw-semibold small" for="phone">
                                            Số điện thoại <span class="text-danger">*</span>
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white"><i class="fa-solid fa-phone text-primary"></i></span>
                                            <input id="phone" name="phone" value="${empty formPhone ? user.phone : formPhone}" type="tel" pattern="0[0-9]{9}" maxlength="10" inputmode="numeric" class="form-control" required placeholder="0912345678">
                                            <div class="invalid-feedback">Số điện thoại phải gồm đúng 10 chữ số và bắt đầu bằng số 0.</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4 pt-3 border-top d-flex gap-2">
                                    <button class="btn btn-primary px-4 py-2 fw-semibold shadow-sm" type="submit">
                                        <i class="fa-solid fa-floppy-disk me-2"></i>Lưu thay đổi hồ sơ
                                    </button>
                                    <a class="btn btn-outline-secondary px-3 py-2" href="<c:url value='/home'/>">
                                        <i class="fa-solid fa-arrow-left me-1"></i>Về trang chủ
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript xử lý Xem trước ảnh trực tiếp và Validation -->
    <script>
        // 1. Xem trước ảnh (Live Image Preview) khi người dùng chọn file
        const avatarInput = document.getElementById('avatarInput');
        const avatarPreview = document.getElementById('avatarPreview');
        const defaultAvatarIcon = document.getElementById('defaultAvatarIcon');
        const fileError = document.getElementById('fileError');

        if (avatarInput) {
            avatarInput.addEventListener('change', function (e) {
                fileError.classList.add('d-none');
                fileError.textContent = '';
                const file = e.target.files[0];
                if (!file) return;

                // Kiểm tra kích thước file (tối đa 5MB)
                const maxSizeBytes = 5 * 1024 * 1024;
                if (file.size > maxSizeBytes) {
                    fileError.textContent = 'Dung lượng ảnh vượt quá 5MB. Vui lòng chọn ảnh khác.';
                    fileError.classList.remove('d-none');
                    avatarInput.value = '';
                    return;
                }

                // Kiểm tra định dạng file
                const validTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
                if (!validTypes.includes(file.type)) {
                    fileError.textContent = 'Chỉ chấp nhận file định dạng JPG, PNG, WEBP hoặc GIF.';
                    fileError.classList.remove('d-none');
                    avatarInput.value = '';
                    return;
                }

                // Hiển thị ảnh bằng FileReader
                const reader = new FileReader();
                reader.onload = function (event) {
                    avatarPreview.src = event.target.result;
                    avatarPreview.classList.remove('d-none');
                    if (defaultAvatarIcon) {
                        defaultAvatarIcon.classList.add('d-none');
                    }
                };
                reader.readAsDataURL(file);
            });
        }

        // 2. Bootstrap form validation
        document.querySelectorAll('.needs-validation').forEach(f => {
            f.addEventListener('submit', e => {
                if (!f.checkValidity()) {
                    e.preventDefault();
                    e.stopPropagation();
                }
                f.classList.add('was-validated');
            });
        });
    </script>
</body>
</html>
