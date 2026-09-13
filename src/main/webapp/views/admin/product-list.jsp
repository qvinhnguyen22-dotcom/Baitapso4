<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý sản phẩm | Admin</title>
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

    <!-- Nội dung quản trị -->
    <main class="container-fluid px-lg-4 py-4">
        <div class="d-flex flex-wrap gap-3 justify-content-between align-items-center mb-4">
            <div>
                <span class="text-primary fw-bold text-uppercase small">QUẢN TRỊ KHO HÀNG</span>
                <h1 class="h3 fw-bold mb-0">Danh Sách Sản Phẩm</h1>
            </div>
            <a class="btn btn-primary shadow-sm" href="<c:url value='/admin/product/add'/>">
                <i class="fa-solid fa-plus me-2"></i>Thêm sản phẩm mới
            </a>
        </div>

        <c:if test="${param.error == 'delete-failed'}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i>Xóa sản phẩm thất bại. Vui lòng thử lại!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${param.error == 'not-found'}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2"></i>Không tìm thấy sản phẩm yêu cầu.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th style="width: 80px;" class="text-center">ID</th>
                                <th>Sản phẩm</th>
                                <th>Danh mục</th>
                                <th>Giá bán</th>
                                <th style="width: 250px;">Mô tả</th>
                                <th class="text-center" style="width: 160px;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${productList}" var="product">
                                <tr>
                                    <td class="text-center fw-bold text-secondary">#${product.productId}</td>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <c:choose>
                                                <c:when test="${not empty product.images and (product.images.startsWith('http://') or product.images.startsWith('https://'))}">
                                                    <img class="rounded border object-fit-cover" style="width: 50px; height: 50px;" src="${product.images}" alt="${product.productName}">
                                                </c:when>
                                                <c:when test="${not empty product.images}">
                                                    <img class="rounded border object-fit-cover" style="width: 50px; height: 50px;" src="<c:url value='/image?fname=${product.images}'/>" alt="${product.productName}">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="rounded border bg-light d-flex align-items-center justify-content-center text-muted" style="width: 50px; height: 50px;">
                                                        <i class="fa-solid fa-image"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div>
                                                <div class="fw-bold text-dark">${product.productName}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty product.category}">
                                                <span class="badge bg-primary-subtle text-primary border border-primary-subtle">
                                                    ${product.category.categoryname}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary-subtle text-secondary">Chưa phân loại</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="fw-bold text-danger">
                                        <fmt:formatNumber value="${product.price}" pattern="#,##0" /> VNĐ
                                    </td>
                                    <td>
                                        <div class="text-muted small text-truncate" style="max-width: 250px;" title="${product.description}">
                                            ${product.description}
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group btn-group-sm" role="group">
                                            <a class="btn btn-outline-secondary" href="<c:url value='/product/detail?id=${product.productId}'/>" target="_blank" title="Xem chi tiết">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>
                                            <a class="btn btn-outline-primary" href="<c:url value='/admin/product/edit?id=${product.productId}'/>" title="Sửa sản phẩm">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                            <a class="btn btn-outline-danger" href="<c:url value='/admin/product/delete?id=${product.productId}'/>" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm: ${product.productName}?');" title="Xóa">
                                                <i class="fa-solid fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${empty productList}">
                    <div class="text-center py-5 text-secondary">
                        <i class="fa-solid fa-box-open fa-3x mb-3 text-muted"></i>
                        <h5>Chưa có sản phẩm nào trong cơ sở dữ liệu.</h5>
                        <p class="small text-muted">Bấm nút "Thêm sản phẩm mới" ở trên để bắt đầu thêm sản phẩm.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
