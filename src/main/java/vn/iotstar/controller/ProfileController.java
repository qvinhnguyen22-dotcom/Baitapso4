package vn.iotstar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;

@Controller
public class ProfileController {

    private final UserService userService;

    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping({"/profile", "/user/profile"})
    public String profile(HttpSession session, Model model) {
        User sessionUser = (User) session.getAttribute("currentUser");
        User user = userService.findById(sessionUser.getId());
        if (user == null) {
            session.invalidate();
            return "redirect:/login";
        }
        session.setAttribute("currentUser", user);
        model.addAttribute("user", user);
        return "profile";
    }

    @PostMapping({"/profile/update", "/profile"})
    public String update(@RequestParam String fullname,
                         @RequestParam(required = false) String phone,
                         @RequestParam(value = "images", required = false) MultipartFile uploadFile,
                         HttpSession session,
                         Model model,
                         RedirectAttributes ra) {
        User sessionUser = (User) session.getAttribute("currentUser");
        User user = userService.findById(sessionUser.getId());
        try {
            userService.updateProfile(user, fullname, phone, uploadFile);
            session.setAttribute("currentUser", userService.findById(user.getId()));
            ra.addFlashAttribute("message", "Cập nhật thông tin cá nhân thành công.");
            return "redirect:/profile";
        } catch (IllegalArgumentException ex) {
            model.addAttribute("error", ex.getMessage());
            model.addAttribute("user", user);
            return "profile";
        }
    }
}
