<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Sửa sản phẩm</title></head>
<body>
    <h2>Sửa sản phẩm</h2>
    <c:if test="${not empty error}"><p style="color:red">${error}</p></c:if>
    <form action="<c:url value='/admin/product/update'/>" method="post">
        <input type="hidden" name="id" value="${product.productId}">
        <label>Tên sản phẩm: <input name="productName" value="${product.productName}" required></label><br>
        <label>Giá: <input type="number" name="price" value="${product.price}" min="0" step="0.01" required></label><br>
        <label>Hình ảnh: <input name="images" value="${product.images}"></label><br>
        <label>Mô tả: <textarea name="description">${product.description}</textarea></label><br>
        <label>Danh mục:
            <select name="categoryId" required>
                <c:forEach items="${categories}" var="category">
                    <option value="${category.categoryid}"
                        ${category.categoryid == product.category.categoryid ? 'selected' : ''}>
                        ${category.categoryname}
                    </option>
                </c:forEach>
            </select>
        </label><br>
        <button type="submit">Cập nhật</button>
    </form>
    <a href="<c:url value='/admin/products'/>">Quay lại</a>
</body>
</html>