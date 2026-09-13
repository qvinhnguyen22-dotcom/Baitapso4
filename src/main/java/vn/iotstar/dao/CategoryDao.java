package vn.iotstar.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig;
import vn.iotstar.entity.Category;

public class CategoryDao implements ICategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Category category) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int cateid) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Category category = enma.find(Category.class, cateid);
            if (category != null) {
                enma.createQuery(
                        "UPDATE Product p SET p.category = null WHERE p.category.categoryid = :id")
                        .setParameter("id", cateid)
                        .executeUpdate();
                enma.remove(category);
            } else {
                throw new Exception("Không tìm thấy danh mục để xóa!");
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Category findById(int cateid) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            return enma.find(Category.class, cateid);
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> findAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public Category findByCategoryname(String name) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT c FROM Category c WHERE c.categoryname = :catename";
        try {
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("catename", name);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            enma.close();
        }
    }
}