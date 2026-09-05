<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục</title>
</head>
<body>
    <h2>Thêm Danh Mục Mới</h2>
    <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
        <label>Tên danh mục:</label><br/>
        <input type="text" name="categoryname" required/><br/><br/>
        
        <label>Link Ảnh (Link URL):</label><br/>
        <input type="text" name="images"/><br/><br/>
        
        <label>Hoặc Upload Ảnh từ máy:</label><br/>
        <input type="file" name="images1"/><br/><br/>
        
        <label>Trạng thái:</label><br/>
        <select name="status">
            <option value="1">Hoạt động</option>
            <option value="0">Khóa</option>
        </select><br/><br/>
        
        <button type="submit">Lưu</button>
    </form>
</body>
</html>