package vn.iotstar.controller;

import java.io.IOException;
import java.security.SecureRandom;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.utils.EmailUtils;

@WebServlet(urlPatterns = {
        "/register",
        "/verify-otp",
        "/login",
        "/forgot-password",
        "/reset-password",
        "/logout"
})
public class AuthController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final long OTP_VALIDITY_MILLIS =
            5 * 60 * 1000L;

    private static final SecureRandom RANDOM =
            new SecureRandom();

    private final IUserDao userDao =
            new UserDao();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String path = path(request);

        if ("/logout".equals(path)) {

            request.getSession().invalidate();

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

        } else if ("/verify-otp".equals(path)) {

            request.getRequestDispatcher(
                    "/views/verify-otp.jsp"
            ).forward(request, response);

        } else if ("/reset-password".equals(path)) {

            request.getRequestDispatcher(
                    "/views/reset-password.jsp"
            ).forward(request, response);

        } else {

            String view =
                    "/views"
                    + path
                    + ".jsp";

            request.getRequestDispatcher(
                    view
            ).forward(request, response);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String path =
                path(request);

        switch (path) {

            case "/register" ->
                    register(request, response);

            case "/verify-otp" ->
                    verifyRegistration(
                            request,
                            response
                    );

            case "/login" ->
                    login(request, response);

            case "/forgot-password" ->
                    forgotPassword(
                            request,
                            response
                    );

            case "/reset-password" ->
                    resetPassword(
                            request,
                            response
                    );

            default ->
                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND
                    );
        }
    }

    private void register(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        String fullname =
                trim(request.getParameter("fullname"));

        String email =
                normalizeEmail(
                        request.getParameter("email")
                );

        String username =
                trim(request.getParameter("username"));

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirmPassword");

        if (fullname == null ||
                fullname.length() < 2 ||
                fullname.length() > 200) {

            showError(
                    request,
                    response,
                    "/views/register.jsp",
                    "Họ tên phải từ 2 đến 200 ký tự."
            );

            return;
        }

        if (email == null ||
                !email.matches(
                        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
                )) {

            showError(
                    request,
                    response,
                    "/views/register.jsp",
                    "Email không hợp lệ."
            );

            return;
        }

        if (username == null ||
                !username.matches(
                        "^[A-Za-z0-9_]{3,50}$"
                )) {

            showError(
                    request,
                    response,
                    "/views/register.jsp",
                    "Username phải từ 3 đến 50 ký tự và chỉ gồm chữ, số, dấu gạch dưới."
            );

            return;
        }

        if (password == null ||
                password.length() < 6 ||
                password.length() > 200) {

            showError(
                    request,
                    response,
                    "/views/register.jsp",
                    "Mật khẩu phải từ 6 đến 200 ký tự."
            );

            return;
        }

        if (!password.equals(confirmPassword)) {

            showError(
                    request,
                    response,
                    "/views/register.jsp",
                    "Mật khẩu xác nhận không khớp."
            );

            return;
        }

        if (userDao.findByEmail(email) != null ||
                userDao.findByUsername(username) != null) {

            showError(
                    request,
                    response,
                    "/views/register.jsp",
                    "Email hoặc username đã tồn tại."
            );

            return;
        }

        String otp =
                generateOtp();

        User user =
                new User();

        user.setFullname(fullname);
        user.setEmail(email);
        user.setUsername(username);
        user.setPassword(password);
        user.setStatus(false);
        user.setCode(otp);

        userDao.insert(user);

        HttpSession session =
                request.getSession();

        session.setAttribute(
                "registrationEmail",
                user.getEmail()
        );

        session.setAttribute(
                "registrationOtpCreatedAt",
                System.currentTimeMillis()
        );

        EmailUtils.sendEmail(
                user.getEmail(),
                "Mã xác thực đăng ký",
                "Mã OTP của bạn là: " + otp
        );

        response.sendRedirect(
                request.getContextPath()
                + "/verify-otp"
        );
    }

    private void verifyRegistration(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session =
                request.getSession();

        String email =
                (String) session.getAttribute(
                        "registrationEmail"
                );

        String otp =
                trim(request.getParameter("otp"));

        User user =
                email == null
                        ? null
                        : userDao.findByEmail(email);

        if (otp == null ||
                !otp.matches("\\d{6}")) {

            showError(
                    request,
                    response,
                    "/views/verify-otp.jsp",
                    "OTP phải gồm đúng 6 chữ số."
            );

            return;
        }

        if (user == null ||
                !isValidOtp(
                        session,
                        "registrationOtpCreatedAt",
                        user,
                        otp
                )) {

            showError(
                    request,
                    response,
                    "/views/verify-otp.jsp",
                    "Mã OTP không đúng hoặc đã hết hạn."
            );

            return;
        }

        user.setStatus(true);
        user.setCode(null);

        userDao.update(user);

        session.removeAttribute(
                "registrationEmail"
        );

        session.removeAttribute(
                "registrationOtpCreatedAt"
        );

        request.setAttribute(
                "message",
                "Xác thực thành công. Bạn có thể đăng nhập."
        );

        request.getRequestDispatcher(
                "/views/login.jsp"
        ).forward(
                request,
                response
        );
    }

    private void login(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        String username =
                trim(
                        request.getParameter("username")
                );

        String password =
                request.getParameter("password");

        if (username == null ||
                username.isEmpty() ||
                password == null ||
                password.isEmpty()) {

            showError(
                    request,
                    response,
                    "/views/login.jsp",
                    "Vui lòng nhập đầy đủ username và password."
            );

            return;
        }

        User user =
                userDao.findByUsername(username);

        if (user == null ||
                !user.isStatus() ||
                !user.getPassword().equals(password)) {

            String message =
                    user != null &&
                    !user.isStatus()
                            ? "Tài khoản chưa được kích hoạt."
                            : "Username hoặc password không đúng.";

            showError(
                    request,
                    response,
                    "/views/login.jsp",
                    message
            );

            return;
        }

        request.getSession()
                .setAttribute(
                        "currentUser",
                        user
                );

        response.sendRedirect(
                request.getContextPath()
                + "/home"
        );
    }

    private void forgotPassword(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        String email =
                normalizeEmail(
                        request.getParameter("email")
                );

        if (email == null ||
                !email.matches(
                        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
                )) {

            showError(
                    request,
                    response,
                    "/views/forgot-password.jsp",
                    "Email không hợp lệ."
            );

            return;
        }

        User user =
                userDao.findByEmail(email);

        if (user == null) {

            showError(
                    request,
                    response,
                    "/views/forgot-password.jsp",
                    "Email không tồn tại."
            );

            return;
        }

        String otp =
                generateOtp();

        user.setCode(otp);

        userDao.update(user);

        HttpSession session =
                request.getSession();

        session.setAttribute(
                "resetEmail",
                user.getEmail()
        );

        session.setAttribute(
                "resetOtpCreatedAt",
                System.currentTimeMillis()
        );

        EmailUtils.sendEmail(
                user.getEmail(),
                "Mã OTP đặt lại mật khẩu",
                "Mã OTP của bạn là: " + otp
        );

        response.sendRedirect(
                request.getContextPath()
                + "/reset-password"
        );
    }

    private void resetPassword(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session =
                request.getSession();

        String email =
                (String) session.getAttribute(
                        "resetEmail"
                );

        String otp =
                trim(
                        request.getParameter("otp")
                );

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirmPassword");

        if (otp == null ||
                !otp.matches("\\d{6}")) {

            showError(
                    request,
                    response,
                    "/views/reset-password.jsp",
                    "OTP phải gồm 6 chữ số."
            );

            return;
        }

        if (password == null ||
                password.length() < 6 ||
                password.length() > 200) {

            showError(
                    request,
                    response,
                    "/views/reset-password.jsp",
                    "Mật khẩu phải từ 6 đến 200 ký tự."
            );

            return;
        }

        if (!password.equals(confirmPassword)) {

            showError(
                    request,
                    response,
                    "/views/reset-password.jsp",
                    "Mật khẩu xác nhận không khớp."
            );

            return;
        }

        User user =
                email == null
                        ? null
                        : userDao.findByEmail(email);

        if (user == null ||
                !isValidOtp(
                        session,
                        "resetOtpCreatedAt",
                        user,
                        otp
                )) {

            showError(
                    request,
                    response,
                    "/views/reset-password.jsp",
                    "OTP không đúng hoặc đã hết hạn."
            );

            return;
        }

        user.setPassword(password);
        user.setCode(null);

        userDao.update(user);

        session.removeAttribute(
                "resetEmail"
        );

        session.removeAttribute(
                "resetOtpCreatedAt"
        );

        request.setAttribute(
                "message",
                "Đặt lại mật khẩu thành công."
        );

        request.getRequestDispatcher(
                "/views/login.jsp"
        ).forward(
                request,
                response
        );
    }

    private boolean isValidOtp(
            HttpSession session,
            String createdAtKey,
            User user,
            String otp) {

        Object createdAt =
                session.getAttribute(
                        createdAtKey
                );

        return otp != null
                && otp.equals(user.getCode())
                && createdAt instanceof Long
                && System.currentTimeMillis()
                - (Long) createdAt
                <= OTP_VALIDITY_MILLIS;
    }

    private void showError(
            HttpServletRequest request,
            HttpServletResponse response,
            String view,
            String error)
            throws ServletException, IOException {

        request.setAttribute(
                "error",
                error
        );

        request.getRequestDispatcher(
                view
        ).forward(
                request,
                response
        );
    }

    private String path(
            HttpServletRequest request) {

        return request.getRequestURI()
                .substring(
                        request.getContextPath()
                                .length()
                );
    }

    private String generateOtp() {

        return String.format(
                "%06d",
                RANDOM.nextInt(1_000_000)
        );
    }

    private String trim(String value) {

        return value == null
                ? null
                : value.trim();
    }

    private String normalizeEmail(
            String email) {

        return email == null
                ? null
                : email.trim()
                        .toLowerCase(
                                java.util.Locale.ROOT
                        );
    }
}