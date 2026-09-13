<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Sửa sản phẩm</title>

</head>

<body>

<div class="row justify-content-center">

    <div class="col-md-8">

        <div class="card">

            <div class="card-body p-4">

                <h2 class="mb-4">
                    Sửa sản phẩm
                </h2>

                <c:if test="${not empty error}">

                    <div class="alert alert-danger">
                        ${error}
                    </div>

                </c:if>

                <form
                    action="<c:url value='/admin/product/update'/>"
                    method="post">

                    <input
                        type="hidden"
                        name="id"
                        value="${product.productId}">

                    <div class="mb-3">

                        <label
                            for="productName"
                            class="form-label">
                            Tên sản phẩm
                        </label>

                        <input
                            type="text"
                            id="productName"
                            name="productName"
                            class="form-control"
                            value="${product.productName}"
                            minlength="2"
                            maxlength="200"
                            required>

                    </div>

                    <div class="mb-3">

                        <label
                            for="price"
                            class="form-label">
                            Giá
                        </label>

                        <input
                            type="number"
                            id="price"
                            name="price"
                            class="form-control"
                            value="${product.price}"
                            min="0"
                            step="0.01"
                            required>

                    </div>

                    <div class="mb-3">

                        <label
                            for="images"
                            class="form-label">
                            Link hình ảnh
                        </label>

                        <input
                            type="url"
                            id="images"
                            name="images"
                            class="form-control"
                            value="${product.images}"
                            placeholder="https://example.com/image.jpg">

                    </div>

                    <div class="mb-3">

                        <label
                            for="description"
                            class="form-label">
                            Mô tả
                        </label>

                        <textarea
                            id="description"
                            name="description"
                            class="form-control"
                            rows="5"
                            maxlength="2000">${product.description}</textarea>

                    </div>

                    <div class="mb-4">

                        <label
                            for="categoryId"
                            class="form-label">
                            Danh mục
                        </label>

                        <select
                            id="categoryId"
                            name="categoryId"
                            class="form-select"
                            required>

                            <option value="">
                                -- Chọn danh mục --
                            </option>

                            <c:forEach
                                items="${categories}"
                                var="category">

                                <option
                                    value="${category.categoryid}"
                                    ${category.categoryid == product.category.categoryid ? 'selected' : ''}>

                                    ${category.categoryname}

                                </option>

                            </c:forEach>

                        </select>

                    </div>

                    <div class="d-flex gap-2">

                        <button
                            type="submit"
                            class="btn btn-primary">

                            Cập nhật

                        </button>

                        <a
                            href="<c:url value='/admin/products'/>"
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