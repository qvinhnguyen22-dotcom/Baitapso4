<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý người dùng | Admin</title>
</head>
<body>
<div class="d-flex flex-wrap gap-3 justify-content-between align-items-center mb-4">
    <div>
        <p class="text-primary fw-semibold mb-1">QUẢN TRỊ</p>
        <h1 class="h3 fw-bold mb-0">Quản lý người dùng</h1>
    </div>
    <a class="btn btn-brand" href="<c:url value='/admin/user/add'/>">
        <i class="fa-solid fa-user-plus me-2"></i>Thêm người dùng
    </a>
</div>

<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<div class="admin-card p-3 p-lg-4">
    <form class="row g-2 mb-3" method="get" action="<c:url value='/admin/users'/>">
        <div class="col-md-6">
            <input class="form-control" name="keyword" value="${keyword}" placeholder="Tìm theo username, email hoặc họ tên...">
        </div>
        <div class="col-auto">
            <button class="btn btn-primary" type="submit"><i class="fa-solid fa-magnifying-glass me-1"></i>Tìm kiếm</button>
        </div>
        <div class="col-auto">
            <a class="btn btn-outline-secondary" href="<c:url value='/admin/users'/>">Xóa lọc</a>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead>
            <tr>
                <th>Người dùng</th>
                <th>Email</th>
                <th>Vai trò</th>
                <th>Trạng thái</th>
                <th class="text-end">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${users}" var="item">
                <tr>
                    <td>
                        <div class="fw-semibold">${item.fullname}</div>
                        <small class="text-secondary">@${item.username}</small>
                    </td>
                    <td>${item.email}</td>
                    <td>
                        <span class="badge ${item.role == 'ADMIN' ? 'text-bg-danger' : 'text-bg-primary'}">${item.role}</span>
                    </td>
                    <td>
                        <span class="badge rounded-pill ${item.status ? 'text-bg-success' : 'text-bg-secondary'}">
                            ${item.status ? 'Đã kích hoạt' : 'Chưa kích hoạt'}
                        </span>
                    </td>
                    <td class="text-end">
                        <a class="btn btn-sm btn-outline-primary" href="<c:url value='/admin/user/edit?id=${item.id}'/>"><i class="fa-solid fa-pen"></i></a>
                        <a class="btn btn-sm btn-outline-danger" href="<c:url value='/admin/user/delete?id=${item.id}'/>"
                           onclick="return confirm('Xóa người dùng này?')"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <c:if test="${empty users}">
        <div class="text-center py-5 text-secondary">Chưa có người dùng phù hợp.</div>
    </c:if>

    <c:if test="${totalPages > 1}">
        <nav class="mt-3">
            <ul class="pagination justify-content-end mb-0">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/admin/users?keyword=${keyword}&page=${i}'/>">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</div>
</body>
</html>
