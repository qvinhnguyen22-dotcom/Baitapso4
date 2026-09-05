<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Danh Mục</title>
</head>
<body>
    <h2>Cập Nhật Danh Mục</h2>
    <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="categoryid" value="${cate.categoryid}"/>
        
        <label>Tên danh mục:</label><br/>
        <input type="text" name="categoryname" value="${cate.categoryname}" required/><br/><br/>
        
        <label>Link Ảnh (Link URL):</label><br/>
        <input type="text" name="images" value="${cate.images}"/><br/><br/>
        
        <label>Thay đổi ảnh (Upload file):</label><br/>
        <input type="file" name="images1"/><br/><br/>
        
        <label>Trạng thái:</label><br/>
        <select name="status">
            <option value="1" ${cate.status == 1 ? 'selected' : ''}>Hoạt động</option>
            <option value="0" ${cate.status == 0 ? 'selected' : ''}>Khóa</option>
        </select><br/><br/>
        
        <button type="submit">Cập nhật</button>
    </form>
</body>
</html>