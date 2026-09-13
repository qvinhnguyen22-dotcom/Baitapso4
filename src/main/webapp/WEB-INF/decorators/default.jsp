<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="sitemesh"
           uri="http://www.sitemesh.org/sitemesh3"%>

<%@ taglib prefix="c"
           uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>
        <sitemesh:write property="title"/>
    </title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <style>

        body {
            background-color: #f5f7fb;
            min-height: 100vh;
        }

        .navbar-brand {
            font-weight: 700;
        }

        .main-container {
            min-height: calc(100vh - 120px);
            padding-top: 30px;
            padding-bottom: 40px;
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
        }

        footer {
            background: #212529;
            color: white;
            padding: 20px 0;
            margin-top: 30px;
        }

        .profile-avatar {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 50%;
        }

    </style>

    <sitemesh:write property="head"/>

</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">

    <div class="container">

        <a class="navbar-brand"
           href="<c:url value='/home'/>">
            JPA CRUD
        </a>

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse"
             id="navbarNav">

            <ul class="navbar-nav me-auto">

                <li class="nav-item">
                    <a class="nav-link"
                       href="<c:url value='/home'/>">
                        Home
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="<c:url value='/product'/>">
                        Products
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="<c:url value='/admin/categories'/>">
                        Categories
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="<c:url value='/admin/products'/>">
                        Admin Products
                    </a>
                </li>

            </ul>

            <ul class="navbar-nav">

                <c:choose>

                    <c:when test="${not empty sessionScope.currentUser}">

                        <li class="nav-item">

                            <a class="nav-link"
                               href="<c:url value='/profile'/>">

                                <c:choose>

                                    <c:when test="${not empty sessionScope.currentUser.images}">
                                        <img
                                            class="profile-avatar me-1"
                                            src="<c:url value='/image?fname=${sessionScope.currentUser.images}'/>">
                                    </c:when>

                                </c:choose>

                                ${sessionScope.currentUser.fullname}

                            </a>

                        </li>

                        <li class="nav-item">

                            <a class="nav-link"
                               href="<c:url value='/logout'/>">
                                Logout
                            </a>

                        </li>

                    </c:when>

                    <c:otherwise>

                        <li class="nav-item">

                            <a class="nav-link"
                               href="<c:url value='/login'/>">
                                Login
                            </a>

                        </li>

                        <li class="nav-item">

                            <a class="nav-link"
                               href="<c:url value='/register'/>">
                                Register
                            </a>

                        </li>

                    </c:otherwise>

                </c:choose>

            </ul>

        </div>

    </div>

</nav>

<main class="container main-container">

    <sitemesh:write property="body"/>

</main>

<footer>

    <div class="container text-center">

        <p class="mb-0">
            JPA CRUD Category
        </p>

    </div>

</footer>

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>