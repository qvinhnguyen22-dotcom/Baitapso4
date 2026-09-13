<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật sản phẩm | Admin</title>
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
                        <div class="bg-warning-subtle text-warning-emphasis p-3 rounded-circle">
                            <i class="fa-solid fa-pen-to-square fa-xl"></i>
                        </div>
                        <div>
                            <h2 class="h4 fw-bold mb-1">Cập Nhật Sản Phẩm #${product.productId}</h2>
                            <p class="text-secondary small mb-0">Chỉnh sửa thông tin chi tiết của sản phẩm</p>
                        </div>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form class="needs-validation" novalidate action="<c:url value='/admin/product/update'/>" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${product.productId}">

                        <div class="row g-3">
                            <!-- Tên sản phẩm -->
                            <div class="col-md-7">
                                <label class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                                <input name="productName" value="${empty formProductName ? product.productName : formProductName}" class="form-control" required>
                                <div class="invalid-feedback">Tên sản phẩm không được để trống.</div>
                            </div>

                            <!-- Danh mục -->
                            <div class="col-md-5">
                                <label class="form-label fw-semibold">Danh mục <span class="text-danger">*</span></label>
                                <select name="categoryId" class="form-select" required>
                                    <c:forEach items="${categories}" var="cat">
                                        <option value="${cat.categoryid}" ${cat.categoryid == product.category.categoryid ? 'selected' : ''}>
                                            ${cat.categoryname}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">Vui lòng chọn danh mục.</div>
                            </div>

                            <!-- Giá bán -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Giá bán (VNĐ) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input name="price" value="${empty formPrice ? product.price : formPrice}" type="number" min="1" step="any" class="form-control" required>
                                    <span class="input-group-text">VNĐ</span>
                                    <div class="invalid-feedback">Giá bán phải lớn hơn 0.</div>
                                </div>
                            </div>

                            <!-- Ảnh hiện tại & Upload file ảnh mới -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Thay đổi file ảnh mới</label>
                                <input name="imageFile" type="file" accept="image/*" class="form-control">
                                <div class="form-text small">Để trống nếu muốn giữ nguyên ảnh hiện tại</div>
                            </div>

                            <!-- Link URL hình ảnh -->
                            <div class="col-12">
                                <label class="form-label fw-semibold">Hoặc cập nhật đường dẫn URL ảnh</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa-solid fa-link"></i></span>
                                    <input name="images" value="${empty formImages ? product.images : formImages}" type="text" class="form-control">
                                </div>
                            </div>

                            <!-- Xem trước ảnh hiện tại -->
                            <c:if test="${not empty product.images}">
                                <div class="col-12">
                                    <div class="p-3 bg-light rounded d-flex align-items-center gap-3">
                                        <c:choose>
                                            <c:when test="${product.images.startsWith('http://') or product.images.startsWith('https://')}">
                                                <img src="${product.images}" alt="${product.productName}" class="rounded border object-fit-cover" style="width: 80px; height: 80px;">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="<c:url value='/image?fname=${product.images}'/>" alt="${product.productName}" class="rounded border object-fit-cover" style="width: 80px; height: 80px;">
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <div class="small fw-semibold text-secondary">Ảnh hiện tại:</div>
                                            <code class="small text-break">${product.images}</code>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Mô tả -->
                            <div class="col-12">
                                <label class="form-label fw-semibold">Mô tả sản phẩm</label>
                                <textarea name="description" class="form-control" rows="5">${empty formDescription ? product.description : formDescription}</textarea>
                            </div>
                        </div>

                        <div class="d-flex gap-2 mt-4 pt-3 border-top">
                            <button class="btn btn-primary px-4 py-2" type="submit">
                                <i class="fa-solid fa-floppy-disk me-2"></i>Lưu thay đổi
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
