<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa Danh mục | Admin Portal</title>
</head>
<body>
<!-- Breadcrumb & Header -->
<div class="mb-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-1 small text-secondary">
            <li class="breadcrumb-item"><a href="<c:url value='/admin'/>" class="text-decoration-none">Admin</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/admin/categories'/>" class="text-decoration-none">Danh mục</a></li>
            <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa #${cate.categoryid}</li>
        </ol>
    </nav>
    <h2 class="h4 fw-bold mb-0 text-dark">
        <i class="fa-solid fa-pen-to-square text-primary me-2"></i>Chỉnh sửa Danh mục #${cate.categoryid}
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

            <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="categoryid" value="${cate.categoryid}">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                    <input type="text" name="categoryname" class="form-control" value="${cate.categoryname}" 
                           minlength="2" maxlength="255" required>
                    <div class="form-text">Tên danh mục từ 2 đến 255 ký tự.</div>
                </div>

                <!-- Current Image & Replace -->
                <div class="row g-3 mb-3">
                    <div class="col-md-7">
                        <label class="form-label fw-semibold">Link ảnh trực tiếp (URL)</label>
                        <input type="url" name="images" id="imageUrlInput" class="form-control" value="${cate.images}" 
                               placeholder="https://images.unsplash.com/photo-...">
                        <div class="form-text">Để nguyên link cũ hoặc nhập link ảnh mới.</div>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label fw-semibold">Hoặc Tải ảnh mới thay thế</label>
                        <input type="file" name="images1" id="imageFileInput" class="form-control" accept=".jpg,.jpeg,.png,.gif,image/*">
                        <div class="form-text">Chọn file nếu muốn thay thế ảnh hiện tại.</div>
                    </div>
                </div>

                <!-- Image Preview Box -->
                <div class="mb-4">
                    <label class="form-label fw-semibold text-secondary small">HÌNH ẢNH HIỆN TẠI / XEM TRƯỚC</label>
                    <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3 border">
                        <c:choose>
                            <c:when test="${cate.images != null and (cate.images.startsWith('http://') or cate.images.startsWith('https://'))}">
                                <img id="imagePreview" src="${cate.images}" alt="${cate.categoryname}" 
                                     class="rounded-3 shadow-sm border" style="width: 100px; height: 100px; object-fit: cover;"
                                     onerror="this.onerror=null;this.src='https://placehold.co/120x120?text=No+Image';">
                            </c:when>
                            <c:when test="${not empty cate.images}">
                                <img id="imagePreview" src="<c:url value='/image?fname=${cate.images}'/>" alt="${cate.categoryname}" 
                                     class="rounded-3 shadow-sm border" style="width: 100px; height: 100px; object-fit: cover;"
                                     onerror="this.onerror=null;this.src='https://placehold.co/120x120?text=No+Image';">
                            </c:when>
                            <c:otherwise>
                                <img id="imagePreview" src="https://placehold.co/120x120?text=Chưa+có+ảnh" alt="Xem trước" 
                                     class="rounded-3 shadow-sm border" style="width: 100px; height: 100px; object-fit: cover;">
                            </c:otherwise>
                        </c:choose>
                        <div class="small text-secondary">
                            <div><i class="fa-solid fa-circle-info me-1"></i>Hình ảnh hiện tại của danh mục.</div>
                            <div class="text-muted">Khi bạn chọn file mới hoặc dán URL mới, khung này sẽ tự cập nhật.</div>
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
                        <i class="fa-solid fa-check me-1.5"></i>Cập nhật danh mục
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
        this.src = 'https://placehold.co/120x120?text=Lỗi+ảnh';
    };
</script>
</body>
</html>
