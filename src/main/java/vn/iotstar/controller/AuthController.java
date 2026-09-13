package vn.iotstar.controller;

import java.security.SecureRandom;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.utils.EmailUtils;

@Controller
public class AuthController {

    private static final long OTP_VALIDITY_MILLIS = 5 * 60 * 1000L;
    private static final SecureRandom RANDOM = new SecureRandom();

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String loginForm() {
        return "login";
    }

    @GetMapping("/register")
    public String registerForm() {
        return "register";
    }

    @GetMapping("/verify-otp")
    public String verifyForm() {
        return "verify-otp";
    }

    @GetMapping("/forgot-password")
    public String forgotForm() {
        return "forgot-password";
    }

    @GetMapping("/reset-password")
    public String resetForm() {
        return "resetPassword";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @PostMapping("/register")
    public String register(@RequestParam String fullname,
                           @RequestParam String email,
                           @RequestParam String username,
                           @RequestParam String password,
                           @RequestParam String confirmPassword,
                           HttpSession session,
                           Model model) {
        fullname = trim(fullname);
        email = normalize(email);
        username = trim(username);

        if (fullname == null || fullname.length() < 2 || fullname.length() > 200) {
            return error(model, "register", "Họ tên phải từ 2 đến 200 ký tự.");
        }
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            return error(model, "register", "Email không hợp lệ.");
        }
        if (username == null || !username.matches("^[A-Za-z0-9_]{3,50}$")) {
            return error(model, "register", "Username phải từ 3 đến 50 ký tự và chỉ gồm chữ, số, dấu gạch dưới.");
        }
        if (password == null || password.length() < 6 || password.length() > 200) {
            return error(model, "register", "Mật khẩu phải từ 6 đến 200 ký tự.");
        }
        if (!password.equals(confirmPassword)) {
            return error(model, "register", "Mật khẩu xác nhận không khớp.");
        }
        if (userService.findByEmail(email) != null || userService.findByUsername(username) != null) {
            return error(model, "register", "Email hoặc username đã tồn tại.");
        }

        String otp = generateOtp();
        User user = new User();
        user.setFullname(fullname);
        user.setEmail(email);
        user.setUsername(username);
        user.setPassword(password);
        user.setStatus(false);
        user.setRole("USER");
        user.setCode(otp);
        userService.save(user);

        session.setAttribute("registrationEmail", user.getEmail());
        session.setAttribute("registrationOtpCreatedAt", System.currentTimeMillis());
        EmailUtils.sendEmail(user.getEmail(), "Mã xác thực đăng ký", "Mã OTP của bạn là: " + otp);
        return "redirect:/verify-otp";
    }

    @PostMapping("/verify-otp")
    public String verify(@RequestParam String otp, HttpSession session, Model model) {
        String email = (String) session.getAttribute("registrationEmail");
        User user = email == null ? null : userService.findByEmail(email);
        otp = trim(otp);
        if (otp == null || !otp.matches("\\d{6}")) {
            return error(model, "verify-otp", "OTP phải gồm đúng 6 chữ số.");
        }
        if (user == null || !isValidOtp(session, "registrationOtpCreatedAt", user, otp)) {
            return error(model, "verify-otp", "Mã OTP không đúng hoặc đã hết hạn.");
        }
        user.setStatus(true);
        user.setCode(null);
        userService.save(user);
        session.removeAttribute("registrationEmail");
        session.removeAttribute("registrationOtpCreatedAt");
        model.addAttribute("message", "Xác thực thành công. Bạn có thể đăng nhập.");
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        username = trim(username);
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            return error(model, "login", "Vui lòng nhập đầy đủ username và password.");
        }
        User user = userService.findByUsername(username);
        if (user == null || !user.isStatus() || !user.getPassword().equals(password)) {
            String message = user != null && !user.isStatus()
                    ? "Tài khoản chưa được kích hoạt."
                    : "Username hoặc password không đúng.";
            return error(model, "login", message);
        }
        session.setAttribute("currentUser", user);
        return user.isAdmin() ? "redirect:/admin" : "redirect:/home";
    }

    @PostMapping("/forgot-password")
    public String forgot(@RequestParam String email, HttpSession session, Model model) {
        email = normalize(email);
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            return error(model, "forgot-password", "Email không hợp lệ.");
        }
        User user = userService.findByEmail(email);
        if (user == null) {
            return error(model, "forgot-password", "Email không tồn tại.");
        }
        String otp = generateOtp();
        user.setCode(otp);
        userService.save(user);
        session.setAttribute("resetEmail", user.getEmail());
        session.setAttribute("resetOtpCreatedAt", System.currentTimeMillis());
        EmailUtils.sendEmail(user.getEmail(), "Mã OTP đặt lại mật khẩu", "Mã OTP của bạn là: " + otp);
        return "redirect:/reset-password";
    }

    @PostMapping("/reset-password")
    public String reset(@RequestParam String otp,
                        @RequestParam String password,
                        @RequestParam String confirmPassword,
                        HttpSession session,
                        Model model) {
        String email = (String) session.getAttribute("resetEmail");
        otp = trim(otp);
        if (otp == null || !otp.matches("\\d{6}")) {
            return error(model, "resetPassword", "OTP phải gồm 6 chữ số.");
        }
        if (password == null || password.length() < 6 || password.length() > 200) {
            return error(model, "resetPassword", "Mật khẩu phải từ 6 đến 200 ký tự.");
        }
        if (!password.equals(confirmPassword)) {
            return error(model, "resetPassword", "Mật khẩu xác nhận không khớp.");
        }
        User user = email == null ? null : userService.findByEmail(email);
        if (user == null || !isValidOtp(session, "resetOtpCreatedAt", user, otp)) {
            return error(model, "resetPassword", "OTP không đúng hoặc đã hết hạn.");
        }
        user.setPassword(password);
        user.setCode(null);
        userService.save(user);
        session.removeAttribute("resetEmail");
        session.removeAttribute("resetOtpCreatedAt");
        model.addAttribute("message", "Đặt lại mật khẩu thành công.");
        return "login";
    }

    private boolean isValidOtp(HttpSession session, String createdAtKey, User user, String otp) {
        Object createdAt = session.getAttribute(createdAtKey);
        return otp != null
                && otp.equals(user.getCode())
                && createdAt instanceof Long
                && System.currentTimeMillis() - (Long) createdAt <= OTP_VALIDITY_MILLIS;
    }

    private String error(Model model, String view, String message) {
        model.addAttribute("error", message);
        return view;
    }

    private String generateOtp() {
        return String.format("%06d", RANDOM.nextInt(1_000_000));
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private String normalize(String email) {
        return email == null ? null : email.trim().toLowerCase(java.util.Locale.ROOT);
    }
}
