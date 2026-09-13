<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Danh mục | Admin Portal</title>
</head>
<body>
<!-- Page Header -->
<div class="d-flex flex-wrap gap-3 justify-content-between align-items-center mb-4">
    <div>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-1 small text-secondary">
                <li class="breadcrumb-item"><a href="<c:url value='/admin'/>" class="text-decoration-none">Admin</a></li>
                <li class="breadcrumb-item active" aria-current="page">Danh mục</li>
            </ol>
        </nav>
        <h2 class="h4 fw-bold mb-0 text-dark">
            <i class="fa-solid fa-layer-group text-primary me-2"></i>Quản lý Danh mục
        </h2>
    </div>
    <a class="btn btn-primary shadow-sm" href="<c:url value='/admin/category/add'/>">
        <i class="fa-solid fa-plus me-1.5"></i> Thêm danh mục mới
    </a>
</div>

<!-- Flash Alerts -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i>${success}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
        <i class="fa-solid fa-triangle-exclamation me-2"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<!-- Content Card -->
<div class="admin-card p-3 p-lg-4">
    <!-- Search Toolbar -->
    <form class="row g-2 mb-4 align-items-center" method="get" action="<c:url value='/admin/categories'/>">
        <div class="col-md-5 col-lg-4">
            <div class="input-group">
                <span class="input-group-text bg-white border-end-0 text-secondary">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </span>
                <input class="form-control border-start-0 ps-0" type="text" name="keyword" value="${keyword}" placeholder="Tìm theo tên danh mục...">
            </div>
        </div>
        <div class="col-auto">
            <button class="btn btn-primary" type="submit">
                <i class="fa-solid fa-magnifying-glass me-1"></i>Tìm kiếm
            </button>
        </div>
        <c:if test="${not empty keyword}">
            <div class="col-auto">
                <a class="btn btn-outline-secondary" href="<c:url value='/admin/categories'/>">
                    <i class="fa-solid fa-rotate-left me-1"></i>Xóa lọc
                </a>
            </div>
        </c:if>
        <div class="col text-md-end text-secondary small">
            Tổng cộng: <strong class="text-dark">${totalItems}</strong> danh mục
        </div>
    </form>

    <!-- Table -->
    <div class="table-responsive rounded-3 border">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
            <tr>
                <th style="width: 80px;" class="text-center">ID</th>
                <th style="width: 100px;">Hình ảnh</th>
                <th>Tên danh mục</th>
                <th style="width: 150px;" class="text-center">Trạng thái</th>
                <th style="width: 160px;" class="text-end pe-3">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listcate}" var="cate">
                <tr>
                    <td class="text-center fw-semibold text-secondary">#${cate.categoryid}</td>
                    <td>
                        <c:choose>
                            <c:when test="${cate.images != null and (cate.images.startsWith('http://') or cate.images.startsWith('https://'))}">
                                <img class="table-thumb" src="${cate.images}" alt="${cate.categoryname}"
                                     onerror="this.onerror=null;this.src='https://placehold.co/100x100?text=No+Img';">
                            </c:when>
                            <c:when test="${not empty cate.images}">
                                <img class="table-thumb" src="<c:url value='/image?fname=${cate.images}'/>" alt="${cate.categoryname}"
                                     onerror="this.onerror=null;this.src='https://placehold.co/100x100?text=No+Img';">
                            </c:when>
                            <c:otherwise>
                                <div class="table-thumb d-flex align-items-center justify-content-center text-secondary bg-light">
                                    <i class="fa-solid fa-image fa-lg"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <span class="fw-semibold text-dark">${cate.categoryname}</span>
                    </td>
                    <td class="text-center">
                        <c:choose>
                            <c:when test="${cate.status == 1}">
                                <span class="badge bg-success-subtle text-success border border-success-subtle px-2.5 py-1.5 rounded-pill">
                                    <i class="fa-solid fa-circle-check me-1"></i>Hoạt động
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2.5 py-1.5 rounded-pill">
                                    <i class="fa-solid fa-circle-xmark me-1"></i>Đang khóa
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="text-end pe-3">
                        <div class="btn-group btn-group-sm" role="group">
                            <a class="btn btn-outline-primary" href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" title="Chỉnh sửa">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </a>
                            <a class="btn btn-outline-danger" href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>"
                               title="Xóa danh mục"
                               onclick="return confirm('Bạn chắc chắn muốn xóa danh mục [${cate.categoryname}]? Toàn bộ sản phẩm liên kết sẽ được gỡ danh mục.');">
                                <i class="fa-solid fa-trash"></i>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Empty State -->
    <c:if test="${empty listcate}">
        <div class="text-center py-5 text-secondary">
            <div class="mb-3">
                <i class="fa-solid fa-folder-open fa-3x text-muted opacity-50"></i>
            </div>
            <h5 class="fw-semibold text-dark">Không tìm thấy danh mục nào</h5>
            <p class="small mb-3">Thử tìm kiếm với từ khóa khác hoặc thêm danh mục mới.</p>
            <a href="<c:url value='/admin/category/add'/>" class="btn btn-sm btn-primary">
                <i class="fa-solid fa-plus me-1"></i>Thêm danh mục mới
            </a>
        </div>
    </c:if>

    <!-- Pagination -->
    <c:if test="${totalPages > 1}">
        <div class="d-flex flex-wrap justify-content-between align-items-center mt-4 pt-2 border-top">
            <div class="text-secondary small mb-2 mb-md-0">
                Trang <strong class="text-dark">${currentPage}</strong> / <strong class="text-dark">${totalPages}</strong>
            </div>
            <nav aria-label="Page navigation">
                <ul class="pagination pagination-sm mb-0">
                    <!-- First & Prev -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="<c:url value='/admin/categories?keyword=${keyword}&page=1'/>" aria-label="First">
                            <i class="fa-solid fa-angles-left"></i>
                        </a>
                    </li>
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="<c:url value='/admin/categories?keyword=${keyword}&page=${currentPage - 1}'/>" aria-label="Previous">
                            <i class="fa-solid fa-angle-left"></i>
                        </a>
                    </li>

                    <!-- Page Numbers -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:if test="${i >= currentPage - 2 and i <= currentPage + 2}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="<c:url value='/admin/categories?keyword=${keyword}&page=${i}'/>">${i}</a>
                            </li>
                        </c:if>
                    </c:forEach>

                    <!-- Next & Last -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="<c:url value='/admin/categories?keyword=${keyword}&page=${currentPage + 1}'/>" aria-label="Next">
                            <i class="fa-solid fa-angle-right"></i>
                        </a>
                    </li>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="<c:url value='/admin/categories?keyword=${keyword}&page=${totalPages}'/>" aria-label="Last">
                            <i class="fa-solid fa-angles-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:if>
</div>
</body>
</html>
