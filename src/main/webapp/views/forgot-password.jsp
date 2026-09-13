<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Quên mật khẩu</title>

</head>

<body>

<div class="row justify-content-center">

    <div class="col-md-5">

        <div class="card">

            <div class="card-body p-4">

                <h2 class="text-center mb-3">
                    Quên mật khẩu
                </h2>

                <p class="text-muted text-center">
                    Nhập email để nhận mã OTP.
                </p>

                <c:if test="${not empty error}">

                    <div class="alert alert-danger">
                        ${error}
                    </div>

                </c:if>

                <form
                    action="<c:url value='/forgot-password'/>"
                    method="post">

                    <div class="mb-3">

                        <label
                            for="email"
                            class="form-label">
                            Email
                        </label>

                        <input
                            type="email"
                            id="email"
                            name="email"
                            class="form-control"
                            maxlength="100"
                            required>

                    </div>

                    <button
                        type="submit"
                        class="btn btn-primary w-100">

                        Gửi OTP

                    </button>

                </form>

                <div class="text-center mt-3">

                    <a href="<c:url value='/login'/>">
                        Quay lại đăng nhập
                    </a>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>