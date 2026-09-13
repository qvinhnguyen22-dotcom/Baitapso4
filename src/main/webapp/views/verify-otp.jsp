<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Xác thực OTP</title>

</head>

<body>

<div class="row justify-content-center">

    <div class="col-md-5">

        <div class="card">

            <div class="card-body p-4">

                <h2 class="text-center mb-3">
                    Xác thực OTP
                </h2>

                <p class="text-center text-muted">
                    Mã OTP có hiệu lực trong 5 phút.
                </p>

                <c:if test="${not empty error}">

                    <div class="alert alert-danger">
                        ${error}
                    </div>

                </c:if>

                <form
                    action="<c:url value='/verify-otp'/>"
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
                            class="form-control text-center"
                            inputmode="numeric"
                            autocomplete="one-time-code"
                            pattern="[0-9]{6}"
                            minlength="6"
                            maxlength="6"
                            required>

                    </div>

                    <button
                        type="submit"
                        class="btn btn-primary w-100">

                        Xác thực

                    </button>

                </form>

            </div>

        </div>

    </div>

</div>

</body>

</html>