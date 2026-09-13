package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.utils.Constant;

@WebServlet(urlPatterns = {
        "/profile",
        "/profile/update"
})
@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 6 * 1024 * 1024
)
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IUserDao userDao =
            new UserDao();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("currentUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login"
            );

            return;
        }

        User sessionUser =
                (User) session.getAttribute(
                        "currentUser"
                );

        User user =
                userDao.findById(
                        sessionUser.getId()
                );

        if (user == null) {

            session.invalidate();

            response.sendRedirect(
                    request.getContextPath()
                            + "/login"
            );

            return;
        }

        session.setAttribute(
                "currentUser",
                user
        );

        request.setAttribute(
                "user",
                user
        );

        request.getRequestDispatcher(
                "/views/profile.jsp"
        ).forward(
                request,
                response
        );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("currentUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login"
            );

            return;
        }

        User sessionUser =
                (User) session.getAttribute(
                        "currentUser"
                );

        User user =
                userDao.findById(
                        sessionUser.getId()
                );

        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login"
            );

            return;
        }

        String fullname =
                trim(
                        request.getParameter("fullname")
                );

        String phone =
                trim(
                        request.getParameter("phone")
                );

        if (fullname == null ||
                fullname.length() < 2 ||
                fullname.length() > 200) {

            showError(
                    request,
                    response,
                    user,
                    "Họ tên phải từ 2 đến 200 ký tự."
            );

            return;
        }

        if (phone != null &&
                !phone.isEmpty() &&
                !phone.matches(
                        "^[0-9]{10,11}$"
                )) {

            showError(
                    request,
                    response,
                    user,
                    "Số điện thoại phải gồm 10 hoặc 11 chữ số."
            );

            return;
        }

        user.setFullname(
                fullname
        );

        user.setPhone(
                phone == null ||
                        phone.isEmpty()
                        ? null
                        : phone
        );

        Part imagePart =
                request.getPart("images");

        if (imagePart != null &&
                imagePart.getSize() > 0) {

            String originalName =
                    Paths.get(
                            imagePart
                                    .getSubmittedFileName()
                    )
                    .getFileName()
                    .toString();

            String extension =
                    getExtension(
                            originalName
                    );

            if (!isAllowedImage(extension)) {

                showError(
                        request,
                        response,
                        user,
                        "Chỉ được upload JPG, JPEG, PNG hoặc GIF."
                );

                return;
            }

            File uploadDirectory =
                    new File(Constant.DIR);

            if (!uploadDirectory.exists() &&
                    !uploadDirectory.mkdirs()) {

                showError(
                        request,
                        response,
                        user,
                        "Không thể tạo thư mục upload."
                );

                return;
            }

            String fileName =
                    "user_"
                            + user.getId()
                            + "_"
                            + System.currentTimeMillis()
                            + "."
                            + extension;

            imagePart.write(
                    uploadDirectory.getAbsolutePath()
                            + File.separator
                            + fileName
            );

            user.setImages(
                    fileName
            );
        }

        userDao.update(user);

        session.setAttribute(
                "currentUser",
                user
        );

        session.setAttribute(
                "profileMessage",
                "Cập nhật thông tin cá nhân thành công."
        );

        response.sendRedirect(
                request.getContextPath()
                        + "/profile"
        );
    }

    private void showError(
            HttpServletRequest request,
            HttpServletResponse response,
            User user,
            String error)
            throws ServletException, IOException {

        request.setAttribute(
                "error",
                error
        );

        request.setAttribute(
                "user",
                user
        );

        request.getRequestDispatcher(
                "/views/profile.jsp"
        ).forward(
                request,
                response
        );
    }

    private String trim(String value) {

        return value == null
                ? null
                : value.trim();
    }

    private String getExtension(
            String fileName) {

        int dot =
                fileName.lastIndexOf('.');

        if (dot < 0 ||
                dot == fileName.length() - 1) {

            return "";
        }

        return fileName
                .substring(dot + 1)
                .toLowerCase();
    }

    private boolean isAllowedImage(
            String extension) {

        return extension.equals("jpg")
                || extension.equals("jpeg")
                || extension.equals("png")
                || extension.equals("gif");
    }
}