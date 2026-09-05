<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Quản lý sản phẩm</title></head>
<body>
    <h2>Quản lý sản phẩm</h2>
    <a href="<c:url value='/admin/product/add'/>">Thêm sản phẩm</a>
    <table border="1" cellpadding="8" cellspacing="0">
        <tr><th>ID</th><th>Tên</th><th>Giá</th><th>Danh mục</th><th>Thao tác</th></tr>
        <c:forEach items="${productList}" var="product">
            <tr>
                <td>${product.productId}</td>
                <td>${product.productName}</td>
                <td>${product.price}</td>
                <td>${product.category.categoryname}</td>
                <td>
                    <a href="<c:url value='/product/detail?id=${product.productId}'/>">Xem</a> |
                    <a href="<c:url value='/admin/product/edit?id=${product.productId}'/>">Sửa</a> |
                    <a href="<c:url value='/admin/product/delete?id=${product.productId}'/>"
                       onclick="return confirm('Bạn chắc chắn muốn xóa?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>