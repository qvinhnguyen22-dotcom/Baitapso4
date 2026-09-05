package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

// Import JPAConfig từ package config hiện tại
import vn.iotstar.config.JPAConfig;

import vn.iotstar.entity.Product;
import java.util.List;

public class ProductDaoImpl {

    // Lấy 10 sản phẩm mới nhất
    public List<Product> getTop10New() {
        EntityManager enm = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT p FROM Product p ORDER BY p.productId DESC";
            TypedQuery<Product> query = enm.createQuery(jpql, Product.class);
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            enm.close();
        }
    }

    // Phân trang danh sách sản phẩm (pageSize sp / trang)
    public List<Product> getPaging(int page, int pageSize) {
        EntityManager enm = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT p FROM Product p ORDER BY p.productId DESC";
            TypedQuery<Product> query = enm.createQuery(jpql, Product.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            enm.close();
        }
    }

    // Đếm tổng số sản phẩm để tính tổng số trang
    public int countAll() {
        EntityManager enm = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT count(p) FROM Product p";
            TypedQuery<Long> query = enm.createQuery(jpql, Long.class);
            return query.getSingleResult().intValue();
        } finally {
            enm.close();
        }
    }

    // Tìm chi tiết sản phẩm theo ID
    public Product findById(int id) {
        EntityManager enm = JPAConfig.getEntityManager();
        try {
            return enm.find(Product.class, id);
        } finally {
            enm.close();
        }
    }

    // Thêm mới sản phẩm
    public void insert(Product product) {
        EntityManager enm = JPAConfig.getEntityManager();
        EntityTransaction trans = enm.getTransaction();
        try {
            trans.begin();
            enm.persist(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
        } finally {
            enm.close();
        }
    }

    // Cập nhật sản phẩm
    public void update(Product product) {
        EntityManager enm = JPAConfig.getEntityManager();
        EntityTransaction trans = enm.getTransaction();
        try {
            trans.begin();
            enm.merge(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
        } finally {
            enm.close();
        }
    }

    // Xóa sản phẩm theo ID
    public void delete(int id) {
        EntityManager enm = JPAConfig.getEntityManager();
        EntityTransaction trans = enm.getTransaction();
        try {
            trans.begin();
            Product product = enm.find(Product.class, id);
            if (product != null) {
                enm.remove(product);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
        } finally {
            enm.close();
        }
    }
}