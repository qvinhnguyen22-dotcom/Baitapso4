<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Đăng nhập</title>

</head>

<body>

<div class="row justify-content-center">

    <div class="col-md-5 col-lg-4">

        <div class="card">

            <div class="card-body p-4">

                <h2 class="text-center mb-4">
                    Đăng nhập
                </h2>

                <c:if test="${not empty error}">

                    <div class="alert alert-danger">
                        ${error}
                    </div>

                </c:if>

                <c:if test="${not empty message}">

                    <div class="alert alert-success">
                        ${message}
                    </div>

                </c:if>

                <form
                    action="<c:url value='/login'/>"
                    method="post"
                    novalidate>

                    <div class="mb-3">

                        <label
                            for="username"
                            class="form-label">
                            Username
                        </label>

                        <input
                            type="text"
                            id="username"
                            name="username"
                            class="form-control"
                            minlength="3"
                            maxlength="50"
                            pattern="[A-Za-z0-9_]{3,50}"
                            required>

                        <div class="invalid-feedback">
                            Username từ 3-50 ký tự.
                        </div>

                    </div>

                    <div class="mb-3">

                        <label
                            for="password"
                            class="form-label">
                            Mật khẩu
                        </label>

                        <input
                            type="password"
                            id="password"
                            name="password"
                            class="form-control"
                            minlength="6"
                            maxlength="200"
                            required>

                        <div class="invalid-feedback">
                            Mật khẩu tối thiểu 6 ký tự.
                        </div>

                    </div>

                    <button
                        type="submit"
                        class="btn btn-primary w-100">

                        Đăng nhập

                    </button>

                </form>

                <div class="text-center mt-3">

                    <a href="<c:url value='/register'/>">
                        Đăng ký tài khoản
                    </a>

                    <span class="mx-2">|</span>

                    <a href="<c:url value='/forgot-password'/>">
                        Quên mật khẩu?
                    </a>

                </div>

            </div>

        </div>

    </div>

</div>

<script>

(function () {

    const form =
        document.querySelector("form");

    form.addEventListener(
        "submit",
        function (event) {

            if (!form.checkValidity()) {

                event.preventDefault();
                event.stopPropagation();

            }

            form.classList.add("was-validated");

        }
    );

})();

</script>

</body>

</html>