package vn.iotstar.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import vn.iotstar.entity.Category;
import vn.iotstar.repository.CategoryRepository;
import vn.iotstar.repository.ProductRepository;

public class CategoryServiceTest {

    private CategoryRepository categoryRepository;
    private ProductRepository productRepository;
    private FileStorageService fileStorageService;
    private CategoryService categoryService;

    @BeforeEach
    void setUp() {
        categoryRepository = mock(CategoryRepository.class);
        productRepository = mock(ProductRepository.class);
        fileStorageService = mock(FileStorageService.class);
        when(fileStorageService.isValidImageUrl(anyString())).thenReturn(true);
        categoryService = new CategoryService(categoryRepository, productRepository, fileStorageService, 5);
    }

    @Test
    void search_withoutKeyword_callsFindAll() {
        Category cat = new Category();
        cat.setCategoryid(1);
        cat.setCategoryname("Điện thoại");
        Page<Category> expectedPage = new PageImpl<>(List.of(cat));

        when(categoryRepository.findAll(any(Pageable.class))).thenReturn(expectedPage);

        Page<Category> result = categoryService.search(null, 1);
        assertNotNull(result);
        assertEquals(1, result.getTotalElements());
        verify(categoryRepository).findAll(any(Pageable.class));
    }

    @Test
    void search_withKeyword_callsFindByCategorynameContainingIgnoreCase() {
        Category cat = new Category();
        cat.setCategoryid(1);
        cat.setCategoryname("Laptop");
        Page<Category> expectedPage = new PageImpl<>(List.of(cat));

        when(categoryRepository.findByCategorynameContainingIgnoreCase(eq("Laptop"), any(Pageable.class)))
                .thenReturn(expectedPage);

        Page<Category> result = categoryService.search("Laptop", 1);
        assertNotNull(result);
        assertEquals(1, result.getTotalElements());
        verify(categoryRepository).findByCategorynameContainingIgnoreCase(eq("Laptop"), any(Pageable.class));
    }

    @Test
    void save_duplicateName_throwsException() {
        Category cat = new Category();
        cat.setCategoryname("Điện thoại");
        cat.setStatus(1);

        when(categoryRepository.existsByCategorynameIgnoreCase("Điện thoại")).thenReturn(true);

        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            categoryService.save(cat, null, null, false);
        });
        assertTrue(exception.getMessage().contains("đã tồn tại"));
    }

    @Test
    void save_validCategory_success() {
        Category cat = new Category();
        cat.setCategoryname("Phụ kiện");
        cat.setStatus(1);

        when(categoryRepository.existsByCategorynameIgnoreCase("Phụ kiện")).thenReturn(false);

        categoryService.save(cat, "https://images.unsplash.com/sample.jpg", null, false);
        verify(categoryRepository).save(cat);
        assertEquals("Phụ kiện", cat.getCategoryname());
        assertEquals("https://images.unsplash.com/sample.jpg", cat.getImages());
    }

    @Test
    void delete_existingCategory_clearsProductCategoryAndDeletes() {
        when(categoryRepository.existsById(1)).thenReturn(true);

        categoryService.delete(1);

        verify(productRepository).clearCategory(1);
        verify(categoryRepository).deleteById(1);
    }

    @Test
    void delete_nonExistingCategory_throwsException() {
        when(categoryRepository.existsById(99)).thenReturn(false);

        assertThrows(IllegalArgumentException.class, () -> {
            categoryService.delete(99);
        });
        verify(categoryRepository, never()).deleteById(anyInt());
    }
}
