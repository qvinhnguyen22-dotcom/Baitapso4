<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Danh Mục</title>
    <style>
        table { border-collapse: collapse; width: 100%; margin-top: 10px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>Quản Lý Danh Mục</h2>
    <a href="<c:url value='/admin/category/add'/>">Thêm danh mục mới</a>
    <br/><br/>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên Danh Mục</th>
            <th>Hình Ảnh</th>
            <th>Trạng Thái</th>
            <th>Thao Tác</th>
        </tr>
        <c:forEach items="${listcate}" var="cate">
            <tr>
                <td>${cate.categoryid}</td>
                <td>${cate.categoryname}</td>
                <td>
                    <c:if test="${cate.images != null}">
                        <img src="<c:url value='/image?fname=${cate.images}'/>" width="80" height="80"/>
                    </c:if>
                </td>
                <td>${cate.status == 1 ? "Hoạt động" : "Khóa"}</td>
                <td>
                    <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>">Sửa</a> | 
                    <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" onclick="return confirm('Bạn chắc chắn muốn xóa?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>