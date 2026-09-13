<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý danh mục | Admin</title>
</head>
<body>
<div class="d-flex flex-wrap gap-3 justify-content-between align-items-center mb-4">
    <div>
        <p class="text-primary fw-semibold mb-1">QUẢN TRỊ</p>
        <h1 class="h3 fw-bold mb-0">Quản lý danh mục</h1>
    </div>
    <a class="btn btn-brand" href="<c:url value='/admin/category/add'/>">
        <i class="fa-solid fa-plus me-2"></i>Thêm danh mục
    </a>
</div>

<c:if test="${not empty success}">
    <div class="alert alert-success">${success}</div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<div class="admin-card p-3 p-lg-4">
    <form class="row g-2 mb-3" method="get" action="<c:url value='/admin/categories'/>">
        <div class="col-md-6">
            <input class="form-control" name="keyword" value="${keyword}" placeholder="Tìm theo tên danh mục...">
        </div>
        <div class="col-auto">
            <button class="btn btn-primary" type="submit"><i class="fa-solid fa-magnifying-glass me-1"></i>Tìm kiếm</button>
        </div>
        <div class="col-auto">
            <a class="btn btn-outline-secondary" href="<c:url value='/admin/categories'/>">Xóa lọc</a>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead>
            <tr>
                <th>Danh mục</th>
                <th>Trạng thái</th>
                <th class="text-end">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listcate}" var="cate">
                <tr>
                    <td>
                        <div class="d-flex align-items-center gap-3">
                            <c:choose>
                                <c:when test="${cate.images != null and (cate.images.startsWith('http://') or cate.images.startsWith('https://'))}">
                                    <img class="table-thumb" src="${cate.images}" alt="${cate.categoryname}">
                                </c:when>
                                <c:otherwise>
                                    <img class="table-thumb" src="<c:url value='/image?fname=${cate.images}'/>" alt="${cate.categoryname}">
                                </c:otherwise>
                            </c:choose>
                            <div>
                                <div class="fw-semibold">${cate.categoryname}</div>
                                <small class="text-secondary">#${cate.categoryid}</small>
                            </div>
                        </div>
                    </td>
                    <td>
                        <span class="badge rounded-pill ${cate.status == 1 ? 'text-bg-success' : 'text-bg-secondary'}">
                            ${cate.status == 1 ? 'Hoạt động' : 'Đang khóa'}
                        </span>
                    </td>
                    <td class="text-end">
                        <a class="btn btn-sm btn-outline-primary" href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>"><i class="fa-solid fa-pen"></i></a>
                        <a class="btn btn-sm btn-outline-danger" href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>"
                           onclick="return confirm('Bạn chắc chắn muốn xóa danh mục này?')"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <c:if test="${empty listcate}">
        <div class="text-center py-5 text-secondary">
            <i class="fa-solid fa-folder-open fa-3x mb-3"></i>
            <p>Không có danh mục phù hợp.</p>
        </div>
    </c:if>

    <c:if test="${totalPages > 1}">
        <nav class="mt-3">
            <ul class="pagination justify-content-end mb-0">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/admin/categories?keyword=${keyword}&page=${i}'/>">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</div>
</body>
</html>
