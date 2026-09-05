<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi Tiết Sản Phẩm</title>
</head>
<body>
    <h2>Chi Tiết Sản Phẩm: ${product.productName}</h2>
    <div style="display: flex;">
        <div>
            <img src="<c:url value='/image?fname=${product.images}'/>" width="300"/>
        </div>
        <div style="margin-left: 20px;">
            <h3>Tên: ${product.productName}</h3>
            <h4>Giá: ${product.price} VNĐ</h4>
            <p>Danh mục: ${product.category.categoryname}</p>
            <p>Mô tả: ${product.description}</p>
        </div>
    </div>
    <br/>
    <a href="<c:url value='/product'/>">Quay lại danh sách</a>
</body>
</html>