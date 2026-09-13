<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Đặt lại mật khẩu</title>

</head>

<body>

<div class="row justify-content-center">

    <div class="col-md-5">

        <div class="card">

            <div class="card-body p-4">

                <h2 class="text-center mb-4">
                    Đặt lại mật khẩu
                </h2>

                <c:if test="${not empty error}">

                    <div class="alert alert-danger">
                        ${error}
                    </div>

                </c:if>

                <form
                    id="resetForm"
                    action="<c:url value='/reset-password'/>"
                    method="post">

                    <div class="mb-3">

                        <label
                            for="otp"
                            class="form-label">
                            Mã OTP
                        </label>

                        <input
                            type="text"
                            id="otp"
                            name="otp"
                            class="form-control"
                            inputmode="numeric"
                            pattern="[0-9]{6}"
                            minlength="6"
                            maxlength="6"
                            required>

                    </div>

                    <div class="mb-3">

                        <label
                            for="password"
                            class="form-label">
                            Mật khẩu mới
                        </label>

                        <input
                            type="password"
                            id="password"
                            name="password"
                            class="form-control"
                            minlength="6"
                            maxlength="200"
                            required>

                    </div>

                    <div class="mb-3">

                        <label
                            for="confirmPassword"
                            class="form-label">
                            Nhập lại mật khẩu
                        </label>

                        <input
                            type="password"
                            id="confirmPassword"
                            name="confirmPassword"
                            class="form-control"
                            minlength="6"
                            maxlength="200"
                            required>

                    </div>

                    <button
                        type="submit"
                        class="btn btn-primary w-100">

                        Cập nhật mật khẩu

                    </button>

                </form>

            </div>

        </div>

    </div>

</div>

<script>

const form =
    document.getElementById("resetForm");

const password =
    document.getElementById("password");

const confirmPassword =
    document.getElementById("confirmPassword");

form.addEventListener(
    "submit",
    function (event) {

        if (
            password.value !==
            confirmPassword.value
        ) {

            confirmPassword.setCustomValidity(
                "Mật khẩu không khớp."
            );

        } else {

            confirmPassword.setCustomValidity("");

        }

        if (!form.checkValidity()) {

            event.preventDefault();

        }

    }
);

</script>

</body>

</html>