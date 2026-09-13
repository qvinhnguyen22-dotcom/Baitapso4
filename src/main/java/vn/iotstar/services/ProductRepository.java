package vn.iotstar.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import vn.iotstar.entity.Product;

public interface ProductRepository extends JpaRepository<Product, Integer> {

    @EntityGraph(attributePaths = "category")
    List<Product> findAllByOrderByProductIdDesc();

    @EntityGraph(attributePaths = "category")
    Page<Product> findAllByOrderByProductIdDesc(Pageable pageable);

    @EntityGraph(attributePaths = "category")
    Product findByProductId(int productId);

    @Modifying
    @Query("UPDATE Product p SET p.category = null WHERE p.category.categoryid = :categoryId")
    int clearCategory(@Param("categoryId") int categoryId);
}
