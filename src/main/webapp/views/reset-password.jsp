<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Đặt lại mật khẩu</title></head>
<body>
    <h2>Đặt lại mật khẩu</h2>
    <c:if test="${not empty error}"><p style="color:red">${error}</p></c:if>
    <form action="<c:url value='/reset-password'/>" method="post">
        <label>Mã OTP: <input name="otp" inputmode="numeric" pattern="[0-9]{6}" required></label><br>
        <label>Mật khẩu mới: <input type="password" name="password" required></label><br>
        <label>Nhập lại mật khẩu: <input type="password" name="confirmPassword" required></label><br>
        <button type="submit">Cập nhật mật khẩu</button>
    </form>
</body>
</html>