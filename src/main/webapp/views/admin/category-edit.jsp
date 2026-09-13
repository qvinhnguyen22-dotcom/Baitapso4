<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa danh mục | Admin</title>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="admin-card p-4">
            <h2 class="h4 mb-4">Sửa danh mục</h2>
            <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
            <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="categoryid" value="${cate.categoryid}">
                <div class="mb-3">
                    <label class="form-label">Tên danh mục</label>
                    <input type="text" name="categoryname" class="form-control" value="${cate.categoryname}" minlength="2" maxlength="255" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Link ảnh</label>
                    <input type="url" name="images" class="form-control" value="${cate.images}" placeholder="https://example.com/image.jpg">
                </div>
                <div class="mb-3">
                    <label class="form-label">Upload ảnh mới</label>
                    <input type="file" name="images1" class="form-control" accept=".jpg,.jpeg,.png,.gif,image/jpeg,image/png,image/gif">
                </div>
                <div class="mb-4">
                    <label class="form-label">Trạng thái</label>
                    <select name="status" class="form-select" required>
                        <option value="1" ${cate.status == 1 ? 'selected' : ''}>Hoạt động</option>
                        <option value="0" ${cate.status == 0 ? 'selected' : ''}>Khóa</option>
                    </select>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary">Quay lại</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
