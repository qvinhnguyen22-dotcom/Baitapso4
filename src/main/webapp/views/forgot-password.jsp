<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Quên mật khẩu</title></head>
<body>
    <h2>Quên mật khẩu</h2>
    <c:if test="${not empty error}"><p style="color:red">${error}</p></c:if>
    <form action="<c:url value='/forgot-password'/>" method="post">
        <label>Email: <input type="email" name="email" required></label>
        <button type="submit">Gửi OTP</button>
    </form>
    <a href="<c:url value='/login'/>">Quay lại đăng nhập</a>
</body>
</html>