<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Xác thực OTP</title></head>
<body>
    <h2>Xác thực email</h2>
    <p>Mã OTP có hiệu lực trong 5 phút.</p>
    <c:if test="${not empty error}"><p style="color:red">${error}</p></c:if>
    <form action="<c:url value='/verify-otp'/>" method="post">
        <label>Mã OTP: <input name="otp" inputmode="numeric" pattern="[0-9]{6}" required></label>
        <button type="submit">Xác thực</button>
    </form>
</body>
</html>