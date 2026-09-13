package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;
import java.util.List;

public class ProductDaoImpl implements IProductDao {

    @Override
    public List<Product> findAll() {
        EntityManager enm = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT p FROM Product p LEFT JOIN FETCH p.category ORDER BY p.productId DESC";
            TypedQuery<Product> query = enm.createQuery(jpql, Product.class);
            return query.getResultList();
        } finally {
            enm.close();
        }
    }

    // Lấy 10 sản phẩm mới nhất
    @Override
    public List<Product> getTop10New() {
        EntityManager enm = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT p FROM Product p LEFT JOIN FETCH p.category ORDER BY p.productId DESC";
            TypedQuery<Product> query = enm.createQuery(jpql, Product.class);
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            enm.close();
        }
    }

    // Phân trang danh sách sản phẩm (pageSize sp / trang)
    @Override
    public List<Product> getPaging(int page, int pageSize) {
        EntityManager enm = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT p FROM Product p LEFT JOIN FETCH p.category ORDER BY p.productId DESC";
            TypedQuery<Product> query = enm.createQuery(jpql, Product.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            enm.close();
        }
    }

    // Đếm tổng số sản phẩm để tính tổng số trang
    @Override
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
    @Override
    public Product findById(int id) {
        EntityManager enm = JPAConfig.getEntityManager();
        try {
            TypedQuery<Product> query = enm.createQuery(
                "SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE p.productId = :id",
                Product.class);
            query.setParameter("id", id);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            enm.close();
        }
    }

    // Thêm mới sản phẩm
    @Override
    public void insert(Product product) {
        EntityManager enm = JPAConfig.getEntityManager();
        EntityTransaction trans = enm.getTransaction();
        try {
            trans.begin();
            enm.persist(product);
            trans.commit();
        } catch (RuntimeException e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enm.close();
        }
    }

    // Cập nhật sản phẩm
    @Override
    public void update(Product product) {
        EntityManager enm = JPAConfig.getEntityManager();
        EntityTransaction trans = enm.getTransaction();
        try {
            trans.begin();
            enm.merge(product);
            trans.commit();
        } catch (RuntimeException e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enm.close();
        }
    }

    // Xóa sản phẩm theo ID
    @Override
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
        } catch (RuntimeException e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enm.close();
        }
    }
}