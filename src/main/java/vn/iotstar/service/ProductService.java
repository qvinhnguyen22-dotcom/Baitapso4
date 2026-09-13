package vn.iotstar.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.repository.CategoryRepository;
import vn.iotstar.repository.ProductRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;

    public ProductService(ProductRepository productRepository, CategoryRepository categoryRepository) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
    }

    public List<Product> getTop10New() {
        return productRepository.findAllByOrderByProductIdDesc(PageRequest.of(0, 10)).getContent();
    }

    public Page<Product> getPaging(int page, int pageSize) {
        return productRepository.findAllByOrderByProductIdDesc(PageRequest.of(Math.max(page - 1, 0), pageSize));
    }

    public List<Product> findAll() {
        return productRepository.findAllByOrderByProductIdDesc();
    }

    public Product findById(int id) {
        return productRepository.findByProductId(id);
    }

    public List<Category> findAllCategories() {
        return categoryRepository.findAll(Sort.by("categoryname"));
    }

    @Transactional
    public void save(Product product) {
        productRepository.save(product);
    }

    @Transactional
    public void delete(int id) {
        productRepository.deleteById(id);
    }
}
