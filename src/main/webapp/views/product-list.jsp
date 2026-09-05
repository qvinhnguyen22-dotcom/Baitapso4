<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Sản Phẩm</title>
</head>
<body>
    <h2>Tất Cả Sản Phẩm (Phân trang 6sp/trang)</h2>
    <div style="display: flex; flex-wrap: wrap;">
        <c:forEach items="${productList}" var="p">
            <div style="border:1px solid #ccc; margin:10px; padding:10px; width:200px;">
                <a href="<c:url value='/product/detail?id=${p.productId}'/>">
                    <img src="<c:url value='/image?fname=${p.images}'/>" width="100%" height="160"/>
                    <h4>${p.productName}</h4>
                </a>
                <p>Giá: ${p.price} VNĐ</p>
            </div>
        </c:forEach>
    </div>

    <div style="margin-top: 20px;">
        <c:forEach begin="1" end="${endPage}" var="i">
            <a href="<c:url value='/product?page=${i}'/>" 
               style="padding: 5px 10px; border: 1px solid #ccc; text-decoration: none; ${i == currentPage ? 'background-color: blue; color: white;' : ''}">
               ${i}
            </a>
        </c:forEach>
    </div>
</body>
</html>