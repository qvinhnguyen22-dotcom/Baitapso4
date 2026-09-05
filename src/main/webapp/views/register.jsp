<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Đăng ký</title></head>
<body>
    <h2>Đăng ký tài khoản</h2>
    <c:if test="${not empty error}"><p style="color:red">${error}</p></c:if>
    <form action="<c:url value='/register'/>" method="post">
        <label>Họ tên: <input name="fullname" required></label><br>
        <label>Email: <input type="email" name="email" required></label><br>
        <label>Tên đăng nhập: <input name="username" required></label><br>
        <label>Mật khẩu: <input type="password" name="password" required></label><br>
        <label>Nhập lại mật khẩu: <input type="password" name="confirmPassword" required></label><br>
        <button type="submit">Đăng ký</button>
    </form>
    <a href="<c:url value='/login'/>">Đã có tài khoản? Đăng nhập</a>
</body>
</html>