<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm sản phẩm mới | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value='/assets/css/app.css'/>" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navbar Quản trị Admin -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container-fluid px-lg-4">
            <a class="navbar-brand fw-bold" href="<c:url value='/admin/products'/>">
                <i class="fa-solid fa-gauge-high text-primary me-2"></i>QuangVinh ADMIN
            </a>
            <div class="d-flex align-items-center gap-2">
                <a class="btn btn-outline-light btn-sm" href="<c:url value='/admin/products'/>">
                    <i class="fa-solid fa-box me-1"></i>Sản phẩm
                </a>
                <a class="btn btn-outline-light btn-sm" href="<c:url value='/admin/categories'/>">
                    <i class="fa-solid fa-layer-group me-1"></i>Danh mục
                </a>
                <a class="btn btn-primary btn-sm text-white ms-2" href="<c:url value='/home'/>" target="_blank">
                    <i class="fa-solid fa-arrow-up-right-from-square me-1"></i>Xem cửa hàng
                </a>
            </div>
        </div>
    </nav>

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-9 col-xl-8">
                <div class="card border-0 shadow-sm rounded-3 p-4 p-lg-5">
                    <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
                        <div class="bg-primary-subtle text-primary p-3 rounded-circle">
                            <i class="fa-solid fa-box-open fa-xl"></i>
                        </div>
                        <div>
                            <h2 class="h4 fw-bold mb-1">Thêm Sản Phẩm Mới</h2>
                            <p class="text-secondary small mb-0">Điền thông tin chi tiết để thêm sản phẩm vào hệ thống</p>
                        </div>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form class="needs-validation" novalidate action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data">
                        <div class="row g-3">
                            <!-- Tên sản phẩm -->
                            <div class="col-md-7">
                                <label class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                                <input name="productName" value="${formProductName}" class="form-control" placeholder="Ví dụ: iPhone 15 Pro Max" required>
                                <div class="invalid-feedback">Vui lòng nhập tên sản phẩm.</div>
                            </div>

                            <!-- Danh mục -->
                            <div class="col-md-5">
                                <label class="form-label fw-semibold">Danh mục <span class="text-danger">*</span></label>
                                <select name="categoryId" class="form-select" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach items="${categories}" var="cat">
                                        <option value="${cat.categoryid}">${cat.categoryname}</option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">Vui lòng chọn danh mục cho sản phẩm.</div>
                            </div>

                            <!-- Giá bán -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Giá bán (VNĐ) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input name="price" value="${formPrice}" type="number" min="1" step="any" class="form-control" placeholder="Ví dụ: 29990000" required>
                                    <span class="input-group-text">VNĐ</span>
                                    <div class="invalid-feedback">Giá bán phải lớn hơn 0.</div>
                                </div>
                            </div>

                            <!-- Upload file ảnh -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Upload file ảnh (Tùy chọn)</label>
                                <input name="imageFile" type="file" accept="image/*" class="form-control">
                                <div class="form-text small">Hỗ trợ JPG, PNG, WEBP (Lưu vào C:\upload)</div>
                            </div>

                            <!-- Link URL hình ảnh -->
                            <div class="col-12">
                                <label class="form-label fw-semibold">Hoặc đường dẫn URL hình ảnh</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa-solid fa-link"></i></span>
                                    <input name="images" value="${formImages}" type="text" class="form-control" placeholder="https://images.unsplash.com/photo-...">
                                </div>
                                <div class="form-text small">Nếu upload file ảnh ở trên thì hệ thống sẽ ưu tiên dùng file tải lên.</div>
                            </div>

                            <!-- Mô tả sản phẩm -->
                            <div class="col-12">
                                <label class="form-label fw-semibold">Mô tả sản phẩm</label>
                                <textarea name="description" class="form-control" rows="5" placeholder="Nhập mô tả chi tiết tính năng, thông số kỹ thuật...">${formDescription}</textarea>
                            </div>
                        </div>

                        <div class="d-flex gap-2 mt-4 pt-3 border-top">
                            <button class="btn btn-primary px-4 py-2" type="submit">
                                <i class="fa-solid fa-floppy-disk me-2"></i>Lưu sản phẩm
                            </button>
                            <a class="btn btn-outline-secondary px-4 py-2" href="<c:url value='/admin/products'/>">
                                <i class="fa-solid fa-xmark me-1"></i>Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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
