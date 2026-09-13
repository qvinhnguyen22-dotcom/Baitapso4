<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sản phẩm | Admin</title>
</head>
<body>
<div class="d-flex flex-wrap gap-3 justify-content-between align-items-center mb-4">
    <div>
        <span class="text-primary fw-bold text-uppercase small">QUẢN TRỊ KHO HÀNG</span>
        <h1 class="h3 fw-bold mb-0">Danh sách sản phẩm</h1>
    </div>
    <a class="btn btn-primary shadow-sm" href="<c:url value='/admin/product/add'/>">
        <i class="fa-solid fa-plus me-2"></i>Thêm sản phẩm mới
    </a>
</div>

<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<div class="admin-card overflow-hidden">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Danh mục</th>
                <th>Giá bán</th>
                <th class="text-end">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${productList}" var="product">
                <tr>
                    <td>
                        <div class="fw-semibold">${product.productName}</div>
                        <small class="text-secondary">#${product.productId}</small>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty product.category}">${product.category.categoryname}</c:when>
                            <c:otherwise>Chưa phân loại</c:otherwise>
                        </c:choose>
                    </td>
                    <td><fmt:formatNumber value="${product.price}" pattern="#,##0"/> VNĐ</td>
                    <td class="text-end">
                        <a class="btn btn-sm btn-outline-primary" href="<c:url value='/admin/product/edit?id=${product.productId}'/>"><i class="fa-solid fa-pen"></i></a>
                        <a class="btn btn-sm btn-outline-danger" href="<c:url value='/admin/product/delete?id=${product.productId}'/>"
                           onclick="return confirm('Xóa sản phẩm này?')"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <c:if test="${empty productList}">
        <div class="text-center py-5 text-secondary">Chưa có sản phẩm nào.</div>
    </c:if>
    <c:if test="${totalPages > 1}">
        <nav class="p-3">
            <ul class="pagination justify-content-end mb-0">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/admin/products?page=${i}'/>">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</div>
</body>
</html>
