<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html>

<head>

    <title>Profile</title>

</head>

<body>

<div class="row justify-content-center">

    <div class="col-md-8 col-lg-6">

        <div class="card">

            <div class="card-body p-4">

                <h2 class="text-center mb-4">
                    User Profile
                </h2>

                <c:if test="${not empty error}">

                    <div class="alert alert-danger">
                        ${error}
                    </div>

                </c:if>

                <c:if test="${not empty sessionScope.profileMessage}">

                    <div class="alert alert-success">

                        ${sessionScope.profileMessage}

                    </div>

                    <c:remove
                        var="profileMessage"
                        scope="session"/>

                </c:if>

                <div class="text-center mb-4">

                    <c:choose>

                        <c:when test="${not empty user.images}">

                            <img
                                src="<c:url value='/image?fname=${user.images}'/>"
                                class="rounded-circle"
                                style="
                                    width:140px;
                                    height:140px;
                                    object-fit:cover;
                                ">

                        </c:when>

                        <c:otherwise>

                            <div
                                class="rounded-circle bg-secondary
                                       text-white d-flex
                                       align-items-center
                                       justify-content-center mx-auto"
                                style="
                                    width:140px;
                                    height:140px;
                                    font-size:50px;
                                ">

                                ${user.fullname.substring(0,1)}

                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>

                <form
                    action="<c:url value='/profile/update'/>"
                    method="post"
                    enctype="multipart/form-data">

                    <div class="mb-3">

                        <label
                            class="form-label">
                            Username
                        </label>

                        <input
                            type="text"
                            class="form-control"
                            value="${user.username}"
                            readonly>

                    </div>

                    <div class="mb-3">

                        <label
                            class="form-label">
                            Email
                        </label>

                        <input
                            type="email"
                            class="form-control"
                            value="${user.email}"
                            readonly>

                    </div>

                    <div class="mb-3">

                        <label
                            for="fullname"
                            class="form-label">
                            Họ và tên
                        </label>

                        <input
                            type="text"
                            class="form-control"
                            id="fullname"
                            name="fullname"
                            value="${user.fullname}"
                            minlength="2"
                            maxlength="200"
                            required>

                    </div>

                    <div class="mb-3">

                        <label
                            for="phone"
                            class="form-label">
                            Số điện thoại
                        </label>

                        <input
                            type="tel"
                            class="form-control"
                            id="phone"
                            name="phone"
                            value="${user.phone}"
                            pattern="[0-9]{10,11}"
                            maxlength="11"
                            placeholder="Nhập 10 hoặc 11 số">

                    </div>

                    <div class="mb-3">

                        <label
                            for="images"
                            class="form-label">
                            Ảnh đại diện
                        </label>

                        <input
                            type="file"
                            class="form-control"
                            id="images"
                            name="images"
                            accept=".jpg,.jpeg,.png,.gif">

                        <div class="form-text">
                            JPG, JPEG, PNG, GIF. Tối đa 5MB.
                        </div>

                    </div>

                    <div class="d-grid">

                        <button
                            type="submit"
                            class="btn btn-primary">

                            Cập nhật Profile

                        </button>

                    </div>

                </form>

            </div>

        </div>

    </div>

</div>

</body>

</html>