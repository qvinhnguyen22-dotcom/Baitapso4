package vn.iotstar.controller.admin;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ProductService;

@Controller
public class AdminProductController {

    private final ProductService productService;

    public AdminProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/admin/products")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        Page<Product> result = productService.getPaging(page, 8);
        model.addAttribute("productList", result.getContent());
        model.addAttribute("currentPage", result.getNumber() + 1);
        model.addAttribute("totalPages", Math.max(result.getTotalPages(), 1));
        return "admin/product-list";
    }

    @GetMapping("/admin/product/add")
    public String addForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", productService.findAllCategories());
        return "admin/product-add";
    }

    @GetMapping("/admin/product/edit")
    public String editForm(@RequestParam("id") int id, Model model, RedirectAttributes ra) {
        Product product = productService.findById(id);
        if (product == null) {
            ra.addFlashAttribute("error", "Sản phẩm không tồn tại.");
            return "redirect:/admin/products";
        }
        model.addAttribute("product", product);
        model.addAttribute("categories", productService.findAllCategories());
        return "admin/product-edit";
    }

    @PostMapping("/admin/product/insert")
    public String insert(Product product, @RequestParam("categoryId") int categoryId, Model model,
                         RedirectAttributes ra) {
        return save(product, categoryId, false, model, ra);
    }

    @PostMapping("/admin/product/update")
    public String update(Product product, @RequestParam("categoryId") int categoryId, Model model,
                         RedirectAttributes ra) {
        return save(product, categoryId, true, model, ra);
    }

    @GetMapping("/admin/product/delete")
    public String delete(@RequestParam("id") int id, RedirectAttributes ra) {
        productService.delete(id);
        ra.addFlashAttribute("success", "Đã xóa sản phẩm.");
        return "redirect:/admin/products";
    }

    private String save(Product product, int categoryId, boolean update, Model model, RedirectAttributes ra) {
        try {
            if (product.getProductName() == null || product.getProductName().trim().length() < 2) {
                throw new IllegalArgumentException("Tên sản phẩm phải từ 2 đến 200 ký tự.");
            }
            if (product.getPrice() < 0) {
                throw new IllegalArgumentException("Giá sản phẩm phải lớn hơn hoặc bằng 0.");
            }
            Category category = productService.findAllCategories().stream()
                    .filter(item -> item.getCategoryid() == categoryId)
                    .findFirst()
                    .orElse(null);
            if (category == null) {
                throw new IllegalArgumentException("Vui lòng chọn danh mục hợp lệ.");
            }
            if (update) {
                Product existing = productService.findById(product.getProductId());
                if (existing == null) {
                    throw new IllegalArgumentException("Sản phẩm không tồn tại.");
                }
                existing.setProductName(product.getProductName().trim());
                existing.setPrice(product.getPrice());
                existing.setDescription(product.getDescription());
                existing.setImages(product.getImages());
                existing.setCategory(category);
                productService.save(existing);
            } else {
                product.setProductName(product.getProductName().trim());
                product.setCategory(category);
                productService.save(product);
            }
            ra.addFlashAttribute("success", update ? "Cập nhật sản phẩm thành công." : "Thêm sản phẩm thành công.");
            return "redirect:/admin/products";
        } catch (IllegalArgumentException ex) {
            model.addAttribute("error", ex.getMessage());
            model.addAttribute("product", product);
            model.addAttribute("categories", productService.findAllCategories());
            return update ? "admin/product-edit" : "admin/product-add";
        }
    }
}
