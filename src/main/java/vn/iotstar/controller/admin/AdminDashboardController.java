package vn.iotstar.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.iotstar.service.CategoryService;
import vn.iotstar.service.UserService;

@Controller
public class AdminDashboardController {

    private final CategoryService categoryService;
    private final UserService userService;

    public AdminDashboardController(CategoryService categoryService, UserService userService) {
        this.categoryService = categoryService;
        this.userService = userService;
    }

    @GetMapping("/admin")
    public String dashboard(Model model) {
        model.addAttribute("categoryCount", categoryService.search(null, 1).getTotalElements());
        model.addAttribute("userCount", userService.search(null, 1).getTotalElements());
        return "admin/dashboard";
    }
}
