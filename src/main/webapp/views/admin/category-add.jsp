<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Thêm danh mục</title>

</head>

<body>

<div class="row justify-content-center">

    <div class="col-md-8">

        <div class="card">

            <div class="card-body p-4">

                <h2 class="mb-4">
                    Thêm danh mục mới
                </h2>

                <c:if test="${not empty error}">

                    <div class="alert alert-danger">
                        ${error}
                    </div>

                </c:if>

                <form
                    action="<c:url value='/admin/category/insert'/>"
                    method="post"
                    enctype="multipart/form-data">

                    <div class="mb-3">

                        <label
                            class="form-label">
                            Tên danh mục
                        </label>

                        <input
                            type="text"
                            name="categoryname"
                            class="form-control"
                            minlength="2"
                            maxlength="255"
                            required>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">
                            Link ảnh
                        </label>

                        <input
                            type="url"
                            name="images"
                            class="form-control"
                            placeholder="https://example.com/image.jpg">

                        <div class="form-text">
                            Có thể dùng link ảnh hoặc upload file.
                        </div>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">
                            Upload ảnh
                        </label>

                        <input
                            type="file"
                            name="images1"
                            class="form-control"
                            accept=".jpg,.jpeg,.png,.gif,image/jpeg,image/png,image/gif">

                        <div class="form-text">
                            JPG, JPEG, PNG, GIF - tối đa 5MB.
                        </div>

                    </div>

                    <div class="mb-4">

                        <label
                            class="form-label">
                            Trạng thái
                        </label>

                        <select
                            name="status"
                            class="form-select"
                            required>

                            <option value="1">
                                Hoạt động
                            </option>

                            <option value="0">
                                Khóa
                            </option>

                        </select>

                    </div>

                    <div class="d-flex gap-2">

                        <button
                            type="submit"
                            class="btn btn-primary">

                            Lưu

                        </button>

                        <a
                            href="<c:url value='/admin/categories'/>"
                            class="btn btn-secondary">

                            Quay lại

                        </a>

                    </div>

                </form>

            </div>

        </div>

    </div>

</div>

</body>

</html>