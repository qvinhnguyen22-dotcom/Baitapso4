package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.dao.impl.ProductDaoImpl;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {
    "/product", "/product/detail", "/admin/products", "/admin/product/add",
    "/admin/product/insert", "/admin/product/edit", "/admin/product/update",
    "/admin/product/delete"
})
public class ProductController extends HttpServlet {
    private ProductDaoImpl productDao = new ProductDaoImpl();
    private CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = path(req);
        switch (path) {
            case "/product" -> showProductList(req, resp);
            case "/product/detail" -> showProductDetail(req, resp);
            case "/admin/products" -> showAdminProductList(req, resp);
            case "/admin/product/add" -> showProductForm(req, resp, null);
            case "/admin/product/edit" -> showProductForm(req, resp, findProduct(req));
            case "/admin/product/delete" -> deleteProduct(req, resp);
            default -> resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        switch (path(req)) {
            case "/admin/product/insert" -> saveProduct(req, resp, false);
            case "/admin/product/update" -> saveProduct(req, resp, true);
            default -> resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showProductList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int page = parsePositiveInt(req.getParameter("page"), 1);
        int pageSize = 6;
        int totalProducts = productDao.countAll();
        int endPage = Math.max(1, (int) Math.ceil((double) totalProducts / pageSize));
        page = Math.min(page, endPage);
        req.setAttribute("productList", productDao.getPaging(page, pageSize));
        req.setAttribute("endPage", endPage);
        req.setAttribute("currentPage", page);
        req.getRequestDispatcher("/views/product-list.jsp").forward(req, resp);
    }

    private void showProductDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Product product = findProduct(req);
        if (product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        req.setAttribute("product", product);
        req.getRequestDispatcher("/views/product-detail.jsp").forward(req, resp);
    }

    private void showAdminProductList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("productList", productDao.getPaging(1, Integer.MAX_VALUE));
        req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
    }

    private void showProductForm(HttpServletRequest req, HttpServletResponse resp, Product product)
            throws ServletException, IOException {
        if ("/admin/product/edit".equals(path(req)) && product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        List<Category> categories = categoryDao.findAll();
        req.setAttribute("categories", categories);
        req.setAttribute("product", product);
        String view = product == null ? "/views/admin/product-add.jsp" : "/views/admin/product-edit.jsp";
        req.getRequestDispatcher(view).forward(req, resp);
    }

    private void saveProduct(HttpServletRequest req, HttpServletResponse resp, boolean update)
            throws IOException, ServletException {
        Product product = update ? findProduct(req) : new Product();
        if (product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        String productName = req.getParameter("productName");
        int categoryId = parsePositiveInt(req.getParameter("categoryId"), 0);
        if (productName == null || productName.isBlank() || categoryId == 0) {
            req.setAttribute("error", "Tên sản phẩm và danh mục là bắt buộc.");
            showProductForm(req, resp, update ? product : null);
            return;
        }
        product.setProductName(productName.trim());
        product.setPrice(parsePrice(req.getParameter("price")));
        product.setDescription(req.getParameter("description"));
        product.setImages(req.getParameter("images"));
        Category category = categoryDao.findById(categoryId);
        if (category == null) {
            req.setAttribute("error", "Danh mục không tồn tại.");
            showProductForm(req, resp, update ? product : null);
            return;
        }
        product.setCategory(category);
        if (update) {
            productDao.update(product);
        } else {
            productDao.insert(product);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Product product = findProduct(req);
        if (product != null) {
            productDao.delete(product.getProductId());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private Product findProduct(HttpServletRequest req) {
        int id = parsePositiveInt(req.getParameter("id"), 0);
        return id == 0 ? null : productDao.findById(id);
    }

    private int parsePositiveInt(String value, int fallback) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed > 0 ? parsed : fallback;
        } catch (NumberFormatException | NullPointerException exception) {
            return fallback;
        }
    }

    private double parsePrice(String value) {
        try {
            double price = Double.parseDouble(value);
            return price >= 0 ? price : 0;
        } catch (NumberFormatException | NullPointerException exception) {
            return 0;
        }
    }

    private String path(HttpServletRequest req) {
        return req.getRequestURI().substring(req.getContextPath().length());
    }
}