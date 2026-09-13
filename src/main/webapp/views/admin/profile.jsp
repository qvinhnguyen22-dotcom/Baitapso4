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

                <c:if
                    test="${not empty sessionScope.profileMessage}">

                    <div class="alert alert-success">

                        ${sessionScope.profileMessage}

                    </div>

                    <c:remove
                        var="profileMessage"
                        scope="session"/>

                </c:if>

                <div class="text-center mb-4">

                    <c:choose>

                        <c:when
                            test="${not empty user.images}">

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
                                class="rounded-circle
                                       bg-secondary
                                       text-white
                                       d-flex
                                       align-items-center
                                       justify-content-center
                                       mx-auto"
                                style="
                                    width:140px;
                                    height:140px;
                                    font-size:50px;
                                ">

                                <c:choose>

                                    <c:when
                                        test="${not empty user.fullname}">

                                        ${user.fullname.substring(0,1)}

                                    </c:when>

                                    <c:otherwise>
                                        U
                                    </c:otherwise>

                                </c:choose>

                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>

                <form
                    id="profileForm"
                    action="<c:url value='/profile/update'/>"
                    method="post"
                    enctype="multipart/form-data">

                    <div class="mb-3">

                        <label class="form-label">
                            Username
                        </label>

                        <input
                            type="text"
                            class="form-control"
                            value="${user.username}"
                            readonly>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">
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
                            id="fullname"
                            name="fullname"
                            class="form-control"
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
                            id="phone"
                            name="phone"
                            class="form-control"
                            value="${user.phone}"
                            pattern="[0-9]{10,11}"
                            maxlength="11"
                            placeholder="10 hoặc 11 chữ số">

                        <div class="form-text">
                            Có thể để trống.
                        </div>

                    </div>

                    <div class="mb-4">

                        <label
                            for="images"
                            class="form-label">
                            Ảnh đại diện
                        </label>

                        <input
                            type="file"
                            id="images"
                            name="images"
                            class="form-control"
                            accept=".jpg,.jpeg,.png,.gif,image/jpeg,image/png,image/gif">

                        <div class="form-text">
                            JPG, JPEG, PNG, GIF. Tối đa 5MB.
                        </div>

                    </div>

                    <button
                        type="submit"
                        class="btn btn-primary w-100">

                        Cập nhật Profile

                    </button>

                </form>

            </div>

        </div>

    </div>

</div>

<script>

const profileForm =
    document.getElementById("profileForm");

const imageInput =
    document.getElementById("images");

imageInput.addEventListener(
    "change",
    function () {

        if (this.files.length === 0) {
            return;
        }

        const file =
            this.files[0];

        const allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/gif"
        ];

        if (!allowedTypes.includes(
            file.type
        )) {

            alert(
                "Chỉ được chọn JPG, PNG hoặc GIF."
            );

            this.value = "";

            return;
        }

        if (
            file.size >
            5 * 1024 * 1024
        ) {

            alert(
                "Ảnh không được vượt quá 5MB."
            );

            this.value = "";

        }

    }
);

profileForm.addEventListener(
    "submit",
    function (event) {

        if (!profileForm.checkValidity()) {

            event.preventDefault();

            profileForm.classList.add(
                "was-validated"
            );

        }

    }
);

</script>

</body>

</html>