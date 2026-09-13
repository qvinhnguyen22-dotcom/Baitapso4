<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm | QuangVinh Store</title>
</head>
<body>
    <div class="container py-4">
        <!-- Tiêu đề trang và Breadcrumb -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1 small">
                        <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Sản phẩm</li>
                    </ol>
                </nav>
                <h1 class="h3 fw-bold text-dark mb-0">Tất Cả Sản Phẩm</h1>
            </div>
            <div class="text-muted small mt-2 mt-sm-0">
                Hiển thị trang <strong>${currentPage}</strong> / <strong>${endPage}</strong> (Tổng cộng <strong>${totalProducts}</strong> sản phẩm)
            </div>
        </div>

        <c:if test="${param.error == 'not-found'}">
            <div class="alert alert-warning alert-dismissible fade show mb-4" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2"></i>Không tìm thấy thông tin sản phẩm yêu cầu.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Lưới 6 sản phẩm mỗi trang -->
        <div class="row g-4">
            <c:forEach items="${productList}" var="p">
                <div class="col-12 col-sm-6 col-md-4">
                    <div class="card h-100 shadow-sm border-0 product-card overflow-hidden">
                        <!-- Click chuột vào ảnh để xem chi tiết sản phẩm -->
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-decoration-none d-block overflow-hidden position-relative bg-light" style="height: 240px;">
                            <c:choose>
                                <c:when test="${not empty p.images and (p.images.startsWith('http://') or p.images.startsWith('https://'))}">
                                    <img src="${p.images}" alt="${p.productName}" class="w-100 h-100 object-fit-cover transition-transform">
                                </c:when>
                                <c:when test="${not empty p.images}">
                                    <img src="<c:url value='/image?fname=${p.images}'/>" alt="${p.productName}" class="w-100 h-100 object-fit-cover transition-transform">
                                </c:when>
                                <c:otherwise>
                                    <div class="w-100 h-100 d-flex align-items-center justify-content-center text-muted">
                                        <i class="fa-solid fa-image fa-3x"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${not empty p.category}">
                                <span class="badge bg-secondary position-absolute top-0 start-0 m-2 opacity-90">
                                    ${p.category.categoryname}
                                </span>
                            </c:if>
                        </a>

                        <div class="card-body d-flex flex-column p-3">
                            <!-- Click chuột vào tên sản phẩm để xem chi tiết -->
                            <h5 class="card-title h6 fw-bold mb-2">
                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark text-decoration-none text-truncate d-block" title="${p.productName}">
                                    ${p.productName}
                                </a>
                            </h5>

                            <div class="mt-auto pt-2">
                                <div class="text-danger fw-bold fs-5 mb-3">
                                    <fmt:formatNumber value="${p.price}" pattern="#,##0" /> VNĐ
                                </div>
                                <!-- Nút Xem chi tiết -->
                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-primary btn-sm w-100">
                                    <i class="fa-solid fa-circle-info me-1"></i>Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty productList}">
            <div class="card text-center p-5 border-0 shadow-sm my-4">
                <i class="fa-solid fa-box-open fa-4x text-secondary mb-3"></i>
                <h4 class="text-muted">Không có sản phẩm nào</h4>
                <p class="text-secondary">Chưa có sản phẩm nào được hiển thị ở trang này.</p>
                <a href="<c:url value='/home'/>" class="btn btn-primary btn-sm mx-auto">Về trang chủ</a>
            </div>
        </c:if>

        <!-- Phân trang 6 sản phẩm / trang -->
        <c:if test="${endPage > 1}">
            <nav class="mt-5" aria-label="Phân trang danh sách sản phẩm">
                <ul class="pagination justify-content-center">
                    <!-- Nút Trang trước -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="<c:url value='/product?page=${currentPage - 1}'/>" aria-label="Trang trước">
                            <span aria-hidden="true">&laquo; Trang trước</span>
                        </a>
                    </li>

                    <!-- Các nút số trang -->
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="<c:url value='/product?page=${i}'/>">${i}</a>
                        </li>
                    </c:forEach>

                    <!-- Nút Trang sau -->
                    <li class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                        <a class="page-link" href="<c:url value='/product?page=${currentPage + 1}'/>" aria-label="Trang sau">
                            <span aria-hidden="true">Trang sau &raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
</body>
</html>
