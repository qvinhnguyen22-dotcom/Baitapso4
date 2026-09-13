<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Danh mục Mới | Admin Portal</title>
</head>
<body>
<!-- Breadcrumb & Header -->
<div class="mb-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-1 small text-secondary">
            <li class="breadcrumb-item"><a href="<c:url value='/admin'/>" class="text-decoration-none">Admin</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/admin/categories'/>" class="text-decoration-none">Danh mục</a></li>
            <li class="breadcrumb-item active" aria-current="page">Thêm mới</li>
        </ol>
    </nav>
    <h2 class="h4 fw-bold mb-0 text-dark">
        <i class="fa-solid fa-folder-plus text-primary me-2"></i>Thêm Danh mục Mới
    </h2>
</div>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="admin-card p-4 p-md-5">
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                    <input type="text" name="categoryname" class="form-control" value="${cate.categoryname}" 
                           placeholder="Ví dụ: Thiết bị thông minh, Đồ gia dụng..." minlength="2" maxlength="255" required>
                    <div class="form-text">Tên danh mục từ 2 đến 255 ký tự, không được trùng lặp.</div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-7">
                        <label class="form-label fw-semibold">Link ảnh trực tiếp (URL)</label>
                        <input type="url" name="images" id="imageUrlInput" class="form-control" value="${cate.images}" 
                               placeholder="https://images.unsplash.com/photo-...">
                        <div class="form-text">Dán link ảnh từ Internet hoặc tải file bên dưới.</div>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label fw-semibold">Hoặc Tải ảnh từ máy</label>
                        <input type="file" name="images1" id="imageFileInput" class="form-control" accept=".jpg,.jpeg,.png,.gif,image/*">
                        <div class="form-text">Chấp nhận định dạng JPG, PNG, GIF.</div>
                    </div>
                </div>

                <!-- Live Image Preview Box -->
                <div class="mb-4">
                    <label class="form-label fw-semibold text-secondary small">XEM TRƯỚC HÌNH ẢNH</label>
                    <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3 border">
                        <img id="imagePreview" src="https://placehold.co/120x120?text=Preview" alt="Xem trước" 
                             class="rounded-3 shadow-sm border" style="width: 100px; height: 100px; object-fit: cover;">
                        <div class="small text-secondary">
                            <div><i class="fa-solid fa-circle-info me-1"></i>Ảnh hiển thị khi tạo mới thành công.</div>
                            <div class="text-muted">Ưu tiên sử dụng file tải lên nếu có cả hai.</div>
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Trạng thái hoạt động</label>
                    <select name="status" class="form-select" required>
                        <option value="1" ${cate.status == 1 ? 'selected' : ''}>Hoạt động</option>
                        <option value="0" ${cate.status == 0 ? 'selected' : ''}>Khóa (Ẩn khỏi trang người dùng)</option>
                    </select>
                </div>

                <div class="d-flex gap-2 pt-3 border-top">
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fa-solid fa-floppy-disk me-1.5"></i>Lưu danh mục
                    </button>
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary px-4">
                        <i class="fa-solid fa-xmark me-1.5"></i>Hủy bỏ
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    const urlInput = document.getElementById('imageUrlInput');
    const fileInput = document.getElementById('imageFileInput');
    const preview = document.getElementById('imagePreview');

    if (urlInput && urlInput.value) {
        preview.src = urlInput.value;
    }

    urlInput.addEventListener('input', function() {
        if (this.value.trim().length > 0) {
            preview.src = this.value.trim();
        } else {
            preview.src = 'https://placehold.co/120x120?text=Preview';
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
        this.src = 'https://placehold.co/120x120?text=Lỗi+ảnh';
    };
</script>
</body>
</html>
