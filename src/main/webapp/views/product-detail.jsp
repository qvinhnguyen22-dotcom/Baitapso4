<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.productName} | QuangVinh Store</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb điều hướng -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb small">
                <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/product'/>" class="text-decoration-none">Sản phẩm</a></li>
                <c:if test="${not empty product.category}">
                    <li class="breadcrumb-item text-muted">${product.category.categoryname}</li>
                </c:if>
                <li class="breadcrumb-item active text-truncate" style="max-width: 300px;" aria-current="page">${product.productName}</li>
            </ol>
        </nav>

        <!-- Thẻ chi tiết sản phẩm -->
        <div class="card border-0 shadow-sm p-4 p-lg-5">
            <div class="row g-5 align-items-center">
                <!-- Cột hình ảnh sản phẩm lớn -->
                <div class="col-lg-5 text-center">
                    <div class="bg-light p-3 rounded-3 overflow-hidden shadow-sm" style="max-height: 460px;">
                        <c:choose>
                            <c:when test="${not empty product.images and (product.images.startsWith('http://') or product.images.startsWith('https://'))}">
                                <img class="img-fluid rounded object-fit-contain" style="max-height: 420px; width: 100%;" src="${product.images}" alt="${product.productName}">
                            </c:when>
                            <c:when test="${not empty product.images}">
                                <img class="img-fluid rounded object-fit-contain" style="max-height: 420px; width: 100%;" src="<c:url value='/image?fname=${product.images}'/>" alt="${product.productName}">
                            </c:when>
                            <c:otherwise>
                                <div class="py-5 text-muted">
                                    <i class="fa-solid fa-image fa-5x mb-3 text-secondary"></i>
                                    <p>Chưa có hình ảnh sản phẩm</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Cột thông tin sản phẩm -->
                <div class="col-lg-7">
                    <c:choose>
                        <c:when test="${not empty product.category}">
                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 mb-3">
                                <i class="fa-solid fa-tag me-1"></i>${product.category.categoryname}
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary-subtle text-secondary px-3 py-2 mb-3">
                                <i class="fa-solid fa-tag me-1"></i>Chưa phân loại
                            </span>
                        </c:otherwise>
                    </c:choose>

                    <h1 class="h2 fw-bold text-dark mb-3">${product.productName}</h1>

                    <div class="price text-danger fs-2 fw-bold mb-4">
                        <fmt:formatNumber value="${product.price}" pattern="#,##0" /> VNĐ
                    </div>

                    <div class="border-top border-bottom py-3 mb-4">
                        <h6 class="text-uppercase fw-bold text-secondary small mb-2">Mô tả chi tiết sản phẩm:</h6>
                        <div class="text-secondary lh-lg" style="white-space: pre-line;">
                            <c:choose>
                                <c:when test="${not empty product.description}">
                                    ${product.description}
                                </c:when>
                                <c:otherwise>
                                    <em class="text-muted">Chưa có thông tin mô tả chi tiết cho sản phẩm này.</em>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Nút thao tác -->
                    <div class="d-flex flex-wrap gap-3">
                        <button class="btn btn-primary btn-lg px-4" type="button">
                            <i class="fa-solid fa-cart-shopping me-2"></i>Thêm vào giỏ hàng
                        </button>
                        <button class="btn btn-dark btn-lg px-4" type="button">
                            <i class="fa-solid fa-bolt me-2"></i>Mua ngay
                        </button>
                        <a href="<c:url value='/product'/>" class="btn btn-outline-secondary btn-lg px-3">
                            <i class="fa-solid fa-arrow-left me-1"></i>Quay lại danh sách
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
