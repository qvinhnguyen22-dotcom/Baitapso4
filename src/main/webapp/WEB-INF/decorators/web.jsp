<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><sitemesh:write property="title" default="QuangVinh Store" /></title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="<c:url value='/assets/css/app.css'/>" rel="stylesheet">
    <sitemesh:write property="head" />
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
    <!-- Header Decorator -->
    <header class="sticky-top shadow-sm">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark py-3">
            <div class="container">
                <a class="navbar-brand fw-bold fs-4 d-flex align-items-center gap-2" href="<c:url value='/home'/>">
                    <i class="fa-solid fa-bag-shopping text-primary"></i>
                    <span>QUANGVINH STORE</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#siteNavigation" aria-label="Mở menu">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="siteNavigation">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                        <li class="nav-item">
                            <a class="nav-link px-3" href="<c:url value='/home'/>">
                                <i class="fa-solid fa-house me-1"></i>Trang chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link px-3" href="<c:url value='/product'/>">
                                <i class="fa-solid fa-boxes-stacked me-1"></i>Sản phẩm
                            </a>
                        </li>
                    </ul>

                    <div class="navbar-nav ms-auto align-items-lg-center">
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">
                                <div class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle text-white d-flex align-items-center gap-2" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <!-- Avatar thu nhỏ trên header -->
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.currentUser.images and (sessionScope.currentUser.images.startsWith('http://') or sessionScope.currentUser.images.startsWith('https://'))}">
                                                <img class="rounded-circle border border-2 border-primary object-fit-cover" style="width: 34px; height: 34px;" src="${sessionScope.currentUser.images}" alt="Avatar">
                                            </c:when>
                                            <c:when test="${not empty sessionScope.currentUser.images and sessionScope.currentUser.images.startsWith('/')}">
                                                <img class="rounded-circle border border-2 border-primary object-fit-cover" style="width: 34px; height: 34px;" src="<c:url value='${sessionScope.currentUser.images}'/>" alt="Avatar">
                                            </c:when>
                                            <c:when test="${not empty sessionScope.currentUser.images}">
                                                <img class="rounded-circle border border-2 border-primary object-fit-cover" style="width: 34px; height: 34px;" src="<c:url value='/image?fname=${sessionScope.currentUser.images}'/>" alt="Avatar">
                                            </c:when>
                                            <c:when test="${not empty sessionScope.currentUser.avatar}">
                                                <img class="rounded-circle border border-2 border-primary object-fit-cover" style="width: 34px; height: 34px;" src="<c:url value='/image?fname=${sessionScope.currentUser.avatar}'/>" alt="Avatar">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa-solid fa-circle-user fa-2xl text-primary"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="fw-semibold">${sessionScope.currentUser.fullname}</span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2 rounded-3">
                                        <li>
                                            <div class="px-3 py-2 small text-muted border-bottom">
                                                Đăng nhập với:<br><strong class="text-dark">${sessionScope.currentUser.email}</strong>
                                            </div>
                                        </li>
                                        <li>
                                            <a class="dropdown-item py-2" href="<c:url value='/user/profile'/>">
                                                <i class="fa-solid fa-id-card me-2 text-primary"></i>Hồ sơ cá nhân
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><h6 class="dropdown-header text-uppercase small fw-bold text-muted">Khu vực Quản trị</h6></li>
                                        <li>
                                            <a class="dropdown-item py-2" href="<c:url value='/admin/products'/>">
                                                <i class="fa-solid fa-box-archive me-2 text-info"></i>Quản lý Sản phẩm
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item py-2" href="<c:url value='/admin/categories'/>">
                                                <i class="fa-solid fa-layer-group me-2 text-success"></i>Quản lý Danh mục
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item py-2 text-danger" href="<c:url value='/logout'/>">
                                                <i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a class="nav-link px-3" href="<c:url value='/login'/>">
                                    <i class="fa-solid fa-right-to-bracket me-1"></i>Đăng nhập
                                </a>
                                <a class="btn btn-primary btn-sm px-3 ms-lg-2 mt-2 mt-lg-0 text-white shadow-sm" href="<c:url value='/register'/>">
                                    <i class="fa-solid fa-user-plus me-1"></i>Đăng ký
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <!-- Nội dung chính được Sitemesh bọc tự động -->
    <main class="flex-grow-1">
        <sitemesh:write property="body" />
    </main>

    <!-- Footer Decorator -->
    <footer class="py-4 mt-5 border-top bg-white">
        <div class="container text-center text-secondary small">
            <div class="fw-semibold text-dark mb-1">© 2026 QuangVinh Store · Hệ thống bán lẻ công nghệ hàng đầu</div>
            <div>Bài tập 03 - Lập trình Web với Jakarta Servlet 6.0, JPA Hibernate & SiteMesh 3 Decorator</div>
        </div>
    </footer>

    <!-- Bootstrap 5.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
