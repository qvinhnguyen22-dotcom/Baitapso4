<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Đăng ký tài khoản</title>

    <style>

        .register-card {
            max-width: 1050px;
            margin: 20px auto;
            overflow: hidden;
        }

        .register-image {
            min-height: 620px;
            background:
                linear-gradient(
                    to top,
                    rgba(10,11,20,.95),
                    rgba(10,11,20,.2)
                ),
                url("https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=1000&q=85")
                center / cover;
        }

        .register-slogan {
            color: white;
            font-size: 42px;
            font-weight: 700;
        }

        .register-form {
            padding: 45px;
        }

        @media (max-width: 768px) {

            .register-image {
                min-height: 250px;
            }

            .register-slogan {
                font-size: 30px;
            }

            .register-form {
                padding: 25px;
            }

        }

    </style>

</head>

<body>

<div class="card register-card">

    <div class="row g-0">

        <div class="col-md-5">

            <div
                class="register-image
                       d-flex align-items-end p-4">

                <div>

                    <div class="h4 text-white mb-3">
                        AMU
                    </div>

                    <div class="register-slogan">
                        Capturing Moments,
                        Creating Memories
                    </div>

                </div>

            </div>

        </div>

        <div class="col-md-7">

            <div class="register-form">

                <h2>
                    Đăng ký tài khoản
                </h2>

                <p class="text-muted mb-4">
                    Tạo tài khoản để bắt đầu hành trình của bạn.
                </p>

                <c:if test="${not empty error}">

                    <div class="alert alert-danger">
                        ${error}
                    </div>

                </c:if>

                <form
                    action="<c:url value='/register'/>"
                    method="post"
                    novalidate>

                    <div class="mb-3">

                        <label
                            for="fullname"
                            class="form-label">
                            Họ và tên
                        </label>

                        <input
                            id="fullname"
                            name="fullname"
                            type="text"
                            class="form-control"
                            minlength="2"
                            maxlength="200"
                            required>

                        <div class="invalid-feedback">
                            Họ tên phải từ 2 đến 200 ký tự.
                        </div>

                    </div>

                    <div class="mb-3">

                        <label
                            for="username"
                            class="form-label">
                            Username
                        </label>

                        <input
                            id="username"
                            name="username"
                            type="text"
                            class="form-control"
                            minlength="3"
                            maxlength="50"
                            pattern="[A-Za-z0-9_]{3,50}"
                            required>

                        <div class="invalid-feedback">
                            Username chỉ gồm chữ, số và dấu _.
                        </div>

                    </div>

                    <div class="mb-3">

                        <label
                            for="email"
                            class="form-label">
                            Email
                        </label>

                        <input
                            id="email"
                            name="email"
                            type="email"
                            maxlength="100"
                            class="form-control"
                            required>

                        <div class="invalid-feedback">
                            Email không hợp lệ.
                        </div>

                    </div>

                    <div class="mb-3">

                        <label
                            for="password"
                            class="form-label">
                            Mật khẩu
                        </label>

                        <input
                            id="password"
                            name="password"
                            type="password"
                            minlength="6"
                            maxlength="200"
                            class="form-control"
                            required>

                        <div class="invalid-feedback">
                            Mật khẩu tối thiểu 6 ký tự.
                        </div>

                    </div>

                    <div class="mb-3">

                        <label
                            for="confirmPassword"
                            class="form-label">
                            Nhập lại mật khẩu
                        </label>

                        <input
                            id="confirmPassword"
                            name="confirmPassword"
                            type="password"
                            minlength="6"
                            maxlength="200"
                            class="form-control"
                            required>

                        <div
                            id="passwordError"
                            class="invalid-feedback">

                            Mật khẩu xác nhận không khớp.

                        </div>

                    </div>

                    <div class="form-check mb-4">

                        <input
                            id="terms"
                            type="checkbox"
                            class="form-check-input"
                            required>

                        <label
                            for="terms"
                            class="form-check-label">

                            Tôi đồng ý với
                            <a href="#">
                                điều khoản sử dụng
                            </a>.

                        </label>

                    </div>

                    <button
                        type="submit"
                        class="btn btn-primary w-100">

                        Đăng ký

                    </button>

                </form>

                <p class="text-center mt-4">

                    Đã có tài khoản?

                    <a href="<c:url value='/login'/>">
                        Đăng nhập
                    </a>

                </p>

            </div>

        </div>

    </div>

</div>

<script>

const form =
    document.querySelector("form");

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
            event.stopPropagation();

        }

        form.classList.add("was-validated");

    }
);

confirmPassword.addEventListener(
    "input",
    function () {

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

    }
);

</script>

</body>

</html>