package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.Category;
import vn.iotstar.services.CategoryServiceImpl;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.utils.Constant;

@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 6 * 1024 * 1024
)
@WebServlet(urlPatterns = {
        "/admin/categories",
        "/admin/category/add",
        "/admin/category/insert",
        "/admin/category/edit",
        "/admin/category/update",
        "/admin/category/delete"
})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ICategoryService cateService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String path =
                getPath(req);

        switch (path) {

            case "/admin/categories":

                List<Category> list =
                        cateService.findAll();

                req.setAttribute(
                        "listcate",
                        list
                );

                req.getRequestDispatcher(
                        "/views/admin/category-list.jsp"
                ).forward(req, resp);

                break;

            case "/admin/category/add":

                req.getRequestDispatcher(
                        "/views/admin/category-add.jsp"
                ).forward(req, resp);

                break;

            case "/admin/category/edit":

                int editId =
                        parseId(
                                req.getParameter("id")
                        );

                if (editId <= 0) {

                    resp.sendError(
                            HttpServletResponse.SC_BAD_REQUEST
                    );

                    return;
                }

                Category category =
                        cateService.findById(editId);

                if (category == null) {

                    resp.sendError(
                            HttpServletResponse.SC_NOT_FOUND
                    );

                    return;
                }

                req.setAttribute(
                        "cate",
                        category
                );

                req.getRequestDispatcher(
                        "/views/admin/category-edit.jsp"
                ).forward(req, resp);

                break;

            case "/admin/category/delete":

                int deleteId =
                        parseId(
                                req.getParameter("id")
                        );

                if (deleteId <= 0) {

                    resp.sendError(
                            HttpServletResponse.SC_BAD_REQUEST
                    );

                    return;
                }

                cateService.delete(deleteId);

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/categories"
                );

                break;

            default:

                resp.sendError(
                        HttpServletResponse.SC_NOT_FOUND
                );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String path =
                getPath(req);

        switch (path) {

            case "/admin/category/insert":

                insertCategory(req, resp);

                break;

            case "/admin/category/update":

                updateCategory(req, resp);

                break;

            default:

                resp.sendError(
                        HttpServletResponse.SC_NOT_FOUND
                );
        }
    }

    private void insertCategory(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String categoryName =
                trim(
                        req.getParameter("categoryname")
                );

        String imageUrl =
                trim(
                        req.getParameter("images")
                );

        String statusText =
                req.getParameter("status");

        if (categoryName == null ||
                categoryName.length() < 2 ||
                categoryName.length() > 255) {

            showCategoryError(
                    req,
                    resp,
                    "Tên danh mục phải từ 2 đến 255 ký tự.",
                    null
            );

            return;
        }

        int status =
                parseStatus(statusText);

        if (status == -1) {

            showCategoryError(
                    req,
                    resp,
                    "Trạng thái không hợp lệ.",
                    null
            );

            return;
        }

        if (imageUrl != null &&
                !imageUrl.isEmpty() &&
                !isValidImageUrl(imageUrl)) {

            showCategoryError(
                    req,
                    resp,
                    "Link ảnh không hợp lệ.",
                    null
            );

            return;
        }

        Category category =
                new Category();

        category.setCategoryname(
                categoryName
        );

        category.setStatus(status);

        String uploadedFile =
                uploadImage(req);

        if (uploadedFile != null) {

            category.setImages(
                    uploadedFile
            );

        } else if (imageUrl != null &&
                !imageUrl.isEmpty()) {

            category.setImages(
                    imageUrl
            );

        } else {

            category.setImages(
                    "avatar.png"
            );
        }

        cateService.insert(category);

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/categories"
        );
    }

    private void updateCategory(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        int categoryId =
                parseId(
                        req.getParameter("categoryid")
                );

        if (categoryId <= 0) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            return;
        }

        Category category =
                cateService.findById(categoryId);

        if (category == null) {

            resp.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );

            return;
        }

        String categoryName =
                trim(
                        req.getParameter("categoryname")
                );

        String imageUrl =
                trim(
                        req.getParameter("images")
                );

        int status =
                parseStatus(
                        req.getParameter("status")
                );

        if (categoryName == null ||
                categoryName.length() < 2 ||
                categoryName.length() > 255) {

            showCategoryError(
                    req,
                    resp,
                    "Tên danh mục phải từ 2 đến 255 ký tự.",
                    category
            );

            return;
        }

        if (status == -1) {

            showCategoryError(
                    req,
                    resp,
                    "Trạng thái không hợp lệ.",
                    category
            );

            return;
        }

        if (imageUrl != null &&
                !imageUrl.isEmpty() &&
                !isValidImageUrl(imageUrl)) {

            showCategoryError(
                    req,
                    resp,
                    "Link ảnh không hợp lệ.",
                    category
            );

            return;
        }

        category.setCategoryname(
                categoryName
        );

        category.setStatus(status);

        String uploadedFile =
                uploadImage(req);

        if (uploadedFile != null) {

            category.setImages(
                    uploadedFile
            );

        } else if (imageUrl != null &&
                !imageUrl.isEmpty()) {

            category.setImages(
                    imageUrl
            );
        }

        cateService.update(category);

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/categories"
        );
    }

    private String uploadImage(
            HttpServletRequest req)
            throws IOException, ServletException {

        Part part =
                req.getPart("images1");

        if (part == null ||
                part.getSize() == 0) {

            return null;
        }

        String originalName =
                Paths.get(
                        part.getSubmittedFileName()
                )
                .getFileName()
                .toString();

        String extension =
                getExtension(originalName);

        if (!isAllowedImage(extension)) {

            throw new ServletException(
                    "Chỉ cho phép JPG, JPEG, PNG hoặc GIF."
            );
        }

        File uploadDir =
                new File(Constant.DIR);

        if (!uploadDir.exists() &&
                !uploadDir.mkdirs()) {

            throw new IOException(
                    "Không thể tạo thư mục upload."
            );
        }

        String fileName =
                System.currentTimeMillis()
                        + "."
                        + extension;

        part.write(
                uploadDir.getAbsolutePath()
                        + File.separator
                        + fileName
        );

        return fileName;
    }

    private void showCategoryError(
            HttpServletRequest req,
            HttpServletResponse resp,
            String error,
            Category category)
            throws ServletException, IOException {

        req.setAttribute(
                "error",
                error
        );

        req.setAttribute(
                "cate",
                category
        );

        String path =
                getPath(req);

        if ("/admin/category/update".equals(path)) {

            req.getRequestDispatcher(
                    "/views/admin/category-edit.jsp"
            ).forward(req, resp);

        } else {

            req.getRequestDispatcher(
                    "/views/admin/category-add.jsp"
            ).forward(req, resp);
        }
    }

    private String getPath(
            HttpServletRequest req) {

        return req.getRequestURI()
                .substring(
                        req.getContextPath().length()
                );
    }

    private int parseId(String value) {

        try {

            int id =
                    Integer.parseInt(value);

            return id > 0 ? id : -1;

        } catch (Exception e) {

            return -1;
        }
    }

    private int parseStatus(
            String value) {

        try {

            int status =
                    Integer.parseInt(value);

            if (status == 0 ||
                    status == 1) {

                return status;
            }

        } catch (Exception ignored) {
        }

        return -1;
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

    private boolean isValidImageUrl(
            String url) {

        return url.matches(
                "(?i)^(https?://).+\\.(jpg|jpeg|png|gif)(\\?.*)?$"
        );
    }
}