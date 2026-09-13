package vn.iotstar.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import vn.iotstar.entity.Category;
import vn.iotstar.repository.CategoryRepository;
import vn.iotstar.repository.ProductRepository;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;
    private final FileStorageService fileStorageService;
    private final int pageSize;

    public CategoryService(CategoryRepository categoryRepository,
                           ProductRepository productRepository,
                           FileStorageService fileStorageService,
                           @Value("${app.page-size:5}") int pageSize) {
        this.categoryRepository = categoryRepository;
        this.productRepository = productRepository;
        this.fileStorageService = fileStorageService;
        this.pageSize = pageSize;
    }

    public Page<Category> search(String keyword, int page) {
        Pageable pageable = PageRequest.of(Math.max(page - 1, 0), pageSize,
                Sort.by("categoryid").descending());
        if (keyword == null || keyword.isBlank()) {
            return categoryRepository.findAll(pageable);
        }
        return categoryRepository.findByCategorynameContainingIgnoreCase(keyword.trim(), pageable);
    }

    public Category findById(int id) {
        return categoryRepository.findById(id).orElse(null);
    }

    public java.util.List<Category> findAll() {
        return categoryRepository.findAll(Sort.by("categoryname"));
    }

    @Transactional
    public void save(Category category, String imageUrl, MultipartFile uploadFile, boolean update) {
        String name = category.getCategoryname() == null ? "" : category.getCategoryname().trim();
        if (name.length() < 2 || name.length() > 255) {
            throw new IllegalArgumentException("Tên danh mục phải từ 2 đến 255 ký tự.");
        }
        if (category.getStatus() != 0 && category.getStatus() != 1) {
            throw new IllegalArgumentException("Trạng thái không hợp lệ.");
        }
        boolean duplicated = update
                ? categoryRepository.existsByCategorynameIgnoreCaseAndCategoryidNot(name, category.getCategoryid())
                : categoryRepository.existsByCategorynameIgnoreCase(name);
        if (duplicated) {
            throw new IllegalArgumentException("Tên danh mục đã tồn tại.");
        }

        category.setCategoryname(name);

        try {
            String stored = fileStorageService.store(uploadFile, "cate_");
            if (stored != null) {
                category.setImages(stored);
            } else if (imageUrl != null && !imageUrl.isBlank()) {
                String value = imageUrl.trim();
                if (value.startsWith("http://") || value.startsWith("https://")) {
                    if (!fileStorageService.isValidImageUrl(value)) {
                        throw new IllegalArgumentException("Link ảnh không hợp lệ.");
                    }
                }
                category.setImages(value);
            } else if (!update) {
                category.setImages("avatar.png");
            }
        } catch (Exception ex) {
            throw new IllegalArgumentException(ex.getMessage());
        }

        categoryRepository.save(category);
    }

    @Transactional
    public void delete(int id) {
        if (!categoryRepository.existsById(id)) {
            throw new IllegalArgumentException("Không tìm thấy danh mục.");
        }
        productRepository.clearCategory(id);
        categoryRepository.deleteById(id);
    }
}
