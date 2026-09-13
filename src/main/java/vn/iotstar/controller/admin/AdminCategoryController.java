package vn.iotstar.controller.admin;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.iotstar.entity.Category;
import vn.iotstar.service.CategoryService;

@Controller
@RequestMapping("/admin")
public class AdminCategoryController {

    private final CategoryService categoryService;

    public AdminCategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping("/categories")
    public String list(@RequestParam(value = "keyword", required = false) String keyword,
                       @RequestParam(value = "page", defaultValue = "1") int page,
                       Model model) {
        Page<Category> result = categoryService.search(keyword, page);
        model.addAttribute("listcate", result.getContent());
        model.addAttribute("keyword", keyword == null ? "" : keyword);
        model.addAttribute("currentPage", result.getNumber() + 1);
        model.addAttribute("totalPages", Math.max(result.getTotalPages(), 1));
        model.addAttribute("totalItems", result.getTotalElements());
        return "admin/category-list";
    }

    @GetMapping("/category/add")
    public String addForm(Model model) {
        if (!model.containsAttribute("cate")) {
            Category category = new Category();
            category.setStatus(1);
            model.addAttribute("cate", category);
        }
        return "admin/category-add";
    }

    @PostMapping("/category/insert")
    public String insert(Category cate,
                         @RequestParam(value = "images", required = false) String imageUrl,
                         @RequestParam(value = "images1", required = false) MultipartFile uploadFile,
                         RedirectAttributes redirectAttributes,
                         Model model) {
        try {
            categoryService.save(cate, imageUrl, uploadFile, false);
            redirectAttributes.addFlashAttribute("success", "Thêm danh mục thành công.");
            return "redirect:/admin/categories";
        } catch (IllegalArgumentException ex) {
            model.addAttribute("error", ex.getMessage());
            model.addAttribute("cate", cate);
            return "admin/category-add";
        }
    }

    @GetMapping("/category/edit")
    public String editForm(@RequestParam("id") int id, Model model, RedirectAttributes redirectAttributes) {
        Category category = categoryService.findById(id);
        if (category == null) {
            redirectAttributes.addFlashAttribute("error", "Danh mục không tồn tại.");
            return "redirect:/admin/categories";
        }
        model.addAttribute("cate", category);
        return "admin/category-edit";
    }

    @PostMapping("/category/update")
    public String update(Category cate,
                         @RequestParam(value = "images", required = false) String imageUrl,
                         @RequestParam(value = "images1", required = false) MultipartFile uploadFile,
                         RedirectAttributes redirectAttributes,
                         Model model) {
        try {
            categoryService.save(cate, imageUrl, uploadFile, true);
            redirectAttributes.addFlashAttribute("success", "Cập nhật danh mục thành công.");
            return "redirect:/admin/categories";
        } catch (IllegalArgumentException ex) {
            model.addAttribute("error", ex.getMessage());
            model.addAttribute("cate", cate);
            return "admin/category-edit";
        }
    }

    @GetMapping("/category/delete")
    public String delete(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
        try {
            categoryService.delete(id);
            redirectAttributes.addFlashAttribute("success", "Đã xóa danh mục.");
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/admin/categories";
    }
}
