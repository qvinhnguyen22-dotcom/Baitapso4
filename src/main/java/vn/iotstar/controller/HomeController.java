package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Product;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/home" })
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy 10 sản phẩm mới nhất hiển thị trang chủ
        List<Product> top10Products = productService.getTop10New();
        req.setAttribute("top10Products", top10Products);
        req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
    }
}