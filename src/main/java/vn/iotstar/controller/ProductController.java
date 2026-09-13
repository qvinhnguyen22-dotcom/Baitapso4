package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;

@WebServlet(urlPatterns = {
        "/product",
        "/product/detail",
        "/admin/products",
        "/admin/product/add",
        "/admin/product/insert",
        "/admin/product/edit",
        "/admin/product/update",
        "/admin/product/delete"
})
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ProductDaoImpl productDao =
            new ProductDaoImpl();

    private final CategoryDao categoryDao =
            new CategoryDao();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String path =
                getPath(req);

        switch (path) {

            case "/product":
                showProductList(req, resp);
                break;

            case "/product/detail":
                showProductDetail(req, resp);
                break;

            case "/admin/products":
                showAdminProductList(req, resp);
                break;

            case "/admin/product/add":
                showProductForm(
                        req,
                        resp,
                        null
                );
                break;

            case "/admin/product/edit":

                Product editProduct =
                        findProduct(req);

                if (editProduct == null) {

                    resp.sendError(
                            HttpServletResponse.SC_NOT_FOUND
                    );

                    return;
                }

                showProductForm(
                        req,
                        resp,
                        editProduct
                );

                break;

            case "/admin/product/delete":

                deleteProduct(req, resp);

                break;

            default:

                resp.sendError(
                        HttpServletResponse.SC_NOT_FOUND
                );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String path =
                getPath(req);

        switch (path) {

            case "/admin/product/insert":

                saveProduct(
                        req,
                        resp,
                        false
                );

                break;

            case "/admin/product/update":

                saveProduct(
                        req,
                        resp,
                        true
                );

                break;

            default:

                resp.sendError(
                        HttpServletResponse.SC_NOT_FOUND
                );
        }
    }

    private void showProductList(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        int page =
                parsePositiveInt(
                        req.getParameter("page"),
                        1
                );

        int pageSize = 6;

        int totalProducts =
                productDao.countAll();

        int endPage =
                Math.max(
                        1,
                        (int) Math.ceil(
                                (double) totalProducts
                                        / pageSize
                        )
                );

        page =
                Math.min(
                        page,
                        endPage
                );

        req.setAttribute(
                "productList",
                productDao.getPaging(
                        page,
                        pageSize
                )
        );

        req.setAttribute(
                "endPage",
                endPage
        );

        req.setAttribute(
                "currentPage",
                page
        );

        req.getRequestDispatcher(
                "/views/product-list.jsp"
        ).forward(req, resp);
    }

    private void showProductDetail(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        Product product =
                findProduct(req);

        if (product == null) {

            resp.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );

            return;
        }

        req.setAttribute(
                "product",
                product
        );

        req.getRequestDispatcher(
                "/views/product-detail.jsp"
        ).forward(req, resp);
    }

    private void showAdminProductList(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute(
                "productList",
                productDao.getPaging(
                        1,
                        Integer.MAX_VALUE
                )
        );

        req.getRequestDispatcher(
                "/views/admin/product-list.jsp"
        ).forward(req, resp);
    }

    private void showProductForm(
            HttpServletRequest req,
            HttpServletResponse resp,
            Product product)
            throws ServletException, IOException {

        List<Category> categories =
                categoryDao.findAll();

        req.setAttribute(
                "categories",
                categories
        );

        req.setAttribute(
                "product",
                product
        );

        String view =
                product == null
                        ? "/views/admin/product-add.jsp"
                        : "/views/admin/product-edit.jsp";

        req.getRequestDispatcher(
                view
        ).forward(req, resp);
    }

    private void saveProduct(
            HttpServletRequest req,
            HttpServletResponse resp,
            boolean update)
            throws ServletException, IOException {

        Product product;

        if (update) {

            product =
                    findProduct(req);

            if (product == null) {

                resp.sendError(
                        HttpServletResponse.SC_NOT_FOUND
                );

                return;
            }

        } else {

            product =
                    new Product();
        }

        String productName =
                trim(
                        req.getParameter("productName")
                );

        String priceText =
                trim(
                        req.getParameter("price")
                );

        String description =
                trim(
                        req.getParameter("description")
                );

        String images =
                trim(
                        req.getParameter("images")
                );

        String categoryText =
                req.getParameter("categoryId");

        if (productName == null ||
                productName.length() < 2 ||
                productName.length() > 200) {

            showProductError(
                    req,
                    resp,
                    product,
                    "Tên sản phẩm phải từ 2 đến 200 ký tự."
            );

            return;
        }

        double price;

        try {

            price =
                    Double.parseDouble(
                            priceText
                    );

            if (price < 0 ||
                    Double.isNaN(price) ||
                    Double.isInfinite(price)) {

                throw new NumberFormatException();
            }

        } catch (Exception e) {

            showProductError(
                    req,
                    resp,
                    product,
                    "Giá sản phẩm phải là số lớn hơn hoặc bằng 0."
            );

            return;
        }

        int categoryId =
                parsePositiveInt(
                        categoryText,
                        0
                );

        if (categoryId <= 0) {

            showProductError(
                    req,
                    resp,
                    product,
                    "Vui lòng chọn danh mục."
            );

            return;
        }

        Category category =
                categoryDao.findById(
                        categoryId
                );

        if (category == null) {

            showProductError(
                    req,
                    resp,
                    product,
                    "Danh mục không tồn tại."
            );

            return;
        }

        if (images != null &&
                !images.isEmpty() &&
                !isValidImage(images)) {

            showProductError(
                    req,
                    resp,
                    product,
                    "Link hình ảnh không hợp lệ."
            );

            return;
        }

        product.setProductName(
                productName
        );

        product.setPrice(
                price
        );

        product.setDescription(
                description
        );

        product.setImages(
                images
        );

        product.setCategory(
                category
        );

        if (update) {

            productDao.update(product);

        } else {

            productDao.insert(product);
        }

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/products"
        );
    }

    private void deleteProduct(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws IOException {

        int id =
                parsePositiveInt(
                        req.getParameter("id"),
                        0
                );

        if (id <= 0) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            return;
        }

        Product product =
                productDao.findById(id);

        if (product != null) {

            productDao.delete(id);
        }

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/products"
        );
    }

    private Product findProduct(
            HttpServletRequest req) {

        int id =
                parsePositiveInt(
                        req.getParameter("id"),
                        0
                );

        if (id <= 0) {

            return null;
        }

        return productDao.findById(id);
    }

    private void showProductError(
            HttpServletRequest req,
            HttpServletResponse resp,
            Product product,
            String error)
            throws ServletException, IOException {

        req.setAttribute(
                "error",
                error
        );

        req.setAttribute(
                "product",
                product
        );

        req.setAttribute(
                "categories",
                categoryDao.findAll()
        );

        String path =
                getPath(req);

        if ("/admin/product/update".equals(path)) {

            req.getRequestDispatcher(
                    "/views/admin/product-edit.jsp"
            ).forward(req, resp);

        } else {

            req.getRequestDispatcher(
                    "/views/admin/product-add.jsp"
            ).forward(req, resp);
        }
    }

    private int parsePositiveInt(
            String value,
            int fallback) {

        try {

            int parsed =
                    Integer.parseInt(value);

            return parsed > 0
                    ? parsed
                    : fallback;

        } catch (Exception e) {

            return fallback;
        }
    }

    private String trim(
            String value) {

        return value == null
                ? null
                : value.trim();
    }

    private String getPath(
            HttpServletRequest req) {

        return req.getRequestURI()
                .substring(
                        req.getContextPath().length()
                );
    }

    private boolean isValidImage(
            String value) {

        return value.matches(
                "(?i)^(https?://).+\\.(jpg|jpeg|png|gif)(\\?.*)?$"
        );
    }
}