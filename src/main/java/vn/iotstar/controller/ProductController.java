package vn.iotstar.controller;

import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;

import vn.iotstar.entity.Product;
import vn.iotstar.service.ProductService;

@Controller
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/product")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        Page<Product> result = productService.getPaging(page, 6);
        model.addAttribute("productList", result.getContent());
        model.addAttribute("endPage", Math.max(result.getTotalPages(), 1));
        model.addAttribute("currentPage", result.getNumber() + 1);
        return "product-list";
    }

    @GetMapping("/product/detail")
    public String detail(@RequestParam("id") int id, Model model) {
        Product product = productService.findById(id);
        if (product == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        model.addAttribute("product", product);
        return "product-detail";
    }
}
