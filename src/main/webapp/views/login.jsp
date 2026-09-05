<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Đăng nhập</title></head>
<body>
    <h2>Đăng nhập</h2>
    <c:if test="${not empty error}"><p style="color:red">${error}</p></c:if>
    <c:if test="${not empty message}"><p style="color:green">${message}</p></c:if>
    <form action="<c:url value='/login'/>" method="post">
        <label>Tên đăng nhập: <input name="username" required></label><br>
        <label>Mật khẩu: <input type="password" name="password" required></label><br>
        <button type="submit">Đăng nhập</button>
    </form>
    <a href="<c:url value='/register'/>">Đăng ký</a> |
    <a href="<c:url value='/forgot-password'/>">Quên mật khẩu?</a>
</body>
</html>