<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ - Top 10 Sản Phẩm Mới</title>
</head>
<body>
    <h2>Top 10 Sản Phẩm Mới Nhất</h2>
    <div style="display: flex; flex-wrap: wrap;">
        <c:forEach items="${top10Products}" var="p">
            <div style="border:1px solid #ccc; margin:10px; padding:10px; width:180px;">
                <a href="<c:url value='/product/detail?id=${p.productId}'/>">
                    <img src="<c:url value='/image?fname=${p.images}'/>" width="100%" height="150"/>
                    <h4>${p.productName}</h4>
                </a>
                <p>Giá: ${p.price} VNĐ</p>
            </div>
        </c:forEach>
    </div>
    <br/>
    <a href="<c:url value='/product'/>">Xem tất cả sản phẩm (Có phân trang)</a>
    <p>
        <a href="<c:url value='/login'/>">Đăng nhập</a> |
        <a href="<c:url value='/register'/>">Đăng ký</a>
    </p>
</body>
</html>