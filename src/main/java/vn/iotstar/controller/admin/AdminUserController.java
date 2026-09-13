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

import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminUserController {

    private final UserService userService;

    public AdminUserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/users")
    public String list(@RequestParam(value = "keyword", required = false) String keyword,
                       @RequestParam(value = "page", defaultValue = "1") int page,
                       Model model) {
        Page<User> result = userService.search(keyword, page);
        model.addAttribute("users", result.getContent());
        model.addAttribute("keyword", keyword == null ? "" : keyword);
        model.addAttribute("currentPage", result.getNumber() + 1);
        model.addAttribute("totalPages", Math.max(result.getTotalPages(), 1));
        model.addAttribute("totalItems", result.getTotalElements());
        return "admin/user-list";
    }

    @GetMapping("/user/add")
    public String addForm(Model model) {
        if (!model.containsAttribute("user")) {
            User user = new User();
            user.setStatus(true);
            user.setRole("USER");
            model.addAttribute("user", user);
        }
        return "admin/user-add";
    }

    @PostMapping("/user/insert")
    public String insert(User user,
                         @RequestParam(value = "images", required = false) String imageUrl,
                         @RequestParam(value = "images1", required = false) MultipartFile uploadFile,
                         @RequestParam("password") String password,
                         RedirectAttributes redirectAttributes,
                         Model model) {
        try {
            userService.saveAdmin(user, imageUrl, uploadFile, false, password);
            redirectAttributes.addFlashAttribute("success", "Thêm người dùng thành công.");
            return "redirect:/admin/users";
        } catch (IllegalArgumentException ex) {
            model.addAttribute("error", ex.getMessage());
            model.addAttribute("user", user);
            return "admin/user-add";
        }
    }

    @GetMapping("/user/edit")
    public String editForm(@RequestParam("id") int id, Model model, RedirectAttributes redirectAttributes) {
        User user = userService.findById(id);
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Người dùng không tồn tại.");
            return "redirect:/admin/users";
        }
        model.addAttribute("user", user);
        return "admin/user-edit";
    }

    @PostMapping("/user/update")
    public String update(User user,
                         @RequestParam(value = "images", required = false) String imageUrl,
                         @RequestParam(value = "images1", required = false) MultipartFile uploadFile,
                         @RequestParam(value = "password", required = false) String password,
                         RedirectAttributes redirectAttributes,
                         Model model) {
        try {
            userService.saveAdmin(user, imageUrl, uploadFile, true, password);
            redirectAttributes.addFlashAttribute("success", "Cập nhật người dùng thành công.");
            return "redirect:/admin/users";
        } catch (IllegalArgumentException ex) {
            model.addAttribute("error", ex.getMessage());
            model.addAttribute("user", user);
            return "admin/user-edit";
        }
    }

    @GetMapping("/user/delete")
    public String delete(@RequestParam("id") int id, HttpSession session, RedirectAttributes redirectAttributes) {
        User current = (User) session.getAttribute("currentUser");
        try {
            userService.delete(id, current.getId());
            redirectAttributes.addFlashAttribute("success", "Đã xóa người dùng.");
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/admin/users";
    }
}
