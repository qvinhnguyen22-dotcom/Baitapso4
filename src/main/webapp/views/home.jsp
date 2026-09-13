<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ | QuangVinh Store</title>
</head>
<body>
    <!-- Banner Hero -->
    <section class="hero py-5 bg-dark text-white mb-5" style="background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);">
        <div class="container py-4">
            <div class="row align-items-center">
                <div class="col-lg-7">
                    <span class="badge bg-primary text-white mb-3 px-3 py-2 text-uppercase letter-spacing-1">Bộ sưu tập 2026</span>
                    <h1 class="display-4 fw-bold mb-3">Công nghệ đỉnh cao, phong cách dẫn đầu</h1>
                    <p class="lead text-light opacity-75 mb-4">Khám phá các sản phẩm công nghệ cao cấp nhất với chất lượng đảm bảo và mức giá ưu đãi.</p>
                    <a href="<c:url value='/product'/>" class="btn btn-primary btn-lg px-4 shadow">
                        Khám phá tất cả sản phẩm <i class="fa-solid fa-arrow-right ms-2"></i>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- 10 Sản phẩm mới nhất -->
    <section class="container py-3">
        <div class="d-flex flex-wrap justify-content-between align-items-end mb-4 border-bottom pb-3">
            <div>
                <span class="text-primary fw-bold text-uppercase small"><i class="fa-solid fa-bolt me-1"></i>Sản phẩm mới</span>
                <h2 class="fw-bold mb-0 text-dark">Top 10 Sản Phẩm Mới Nhất</h2>
            </div>
            <a href="<c:url value='/product'/>" class="btn btn-outline-primary btn-sm mt-2 mt-sm-0">
                Xem tất cả sản phẩm <i class="fa-solid fa-angle-right ms-1"></i>
            </a>
        </div>

        <div class="row g-4">
            <c:forEach items="${top10Products}" var="p">
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="card h-100 shadow-sm border-0 product-card overflow-hidden">
                        <!-- Click vào ảnh để mở chi tiết sản phẩm -->
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-decoration-none d-block overflow-hidden position-relative bg-light" style="height: 220px;">
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
                            <!-- Click vào tiêu đề để mở chi tiết sản phẩm -->
                            <h5 class="card-title h6 fw-bold mb-2">
                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark text-decoration-none text-truncate d-block" title="${p.productName}">
                                    ${p.productName}
                                </a>
                            </h5>

                            <div class="mt-auto pt-2">
                                <div class="text-danger fw-bold fs-6 mb-3">
                                    <fmt:formatNumber value="${p.price}" pattern="#,##0" /> VNĐ
                                </div>
                                <!-- Nút Xem chi tiết -->
                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-primary btn-sm w-100">
                                    <i class="fa-solid fa-eye me-1"></i>Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty top10Products}">
            <div class="text-center py-5 text-muted">
                <i class="fa-solid fa-box-open fa-3x mb-3 text-secondary"></i>
                <h5>Hiện tại chưa có sản phẩm nào trong hệ thống.</h5>
                <p>Vui lòng quay lại sau hoặc truy cập trang quản trị để thêm sản phẩm mới.</p>
            </div>
        </c:if>
    </section>
</body>
</html>
