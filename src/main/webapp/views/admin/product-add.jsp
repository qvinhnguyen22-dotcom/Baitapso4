<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Thêm sản phẩm</title></head>
<body>
    <h2>Thêm sản phẩm</h2>
    <c:if test="${not empty error}"><p style="color:red">${error}</p></c:if>
    <form action="<c:url value='/admin/product/insert'/>" method="post">
        <label>Tên sản phẩm: <input name="productName" required></label><br>
        <label>Giá: <input type="number" name="price" min="0" step="0.01" required></label><br>
        <label>Hình ảnh: <input name="images"></label><br>
        <label>Mô tả: <textarea name="description"></textarea></label><br>
        <label>Danh mục:
            <select name="categoryId" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach items="${categories}" var="category">
                    <option value="${category.categoryid}">${category.categoryname}</option>
                </c:forEach>
            </select>
        </label><br>
        <button type="submit">Lưu</button>
    </form>
    <a href="<c:url value='/admin/products'/>">Quay lại</a>
</body>
</html>