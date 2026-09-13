package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.entity.User;

public class UserDao implements IUserDao {

    @Override
    public User findByEmail(String email) {
        return findOne(
                "LOWER(TRIM(u.email))",
                normalize(email)
        );
    }

    @Override
    public User findByUsername(String username) {
        return findOne(
                "LOWER(TRIM(u.username))",
                normalize(username)
        );
    }

    @Override
    public User findById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            return entityManager.find(User.class, id);
        } finally {
            entityManager.close();
        }
    }

    private User findOne(String field, String value) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE " + field + " = :value";
            TypedQuery<User> query = entityManager.createQuery(jpql, User.class);
            query.setParameter("value", value);

            return query.getResultStream()
                        .findFirst()
                        .orElse(null);
        } finally {
            entityManager.close();
        }
    }

    private String normalize(String value) {
        return value == null
                ? ""
                : value.trim().toLowerCase(java.util.Locale.ROOT);
    }

    @Override
    public void insert(User user) {
        executeTransaction(entityManager -> entityManager.persist(user));
    }

    @Override
    public void update(User user) {
        executeTransaction(entityManager -> entityManager.merge(user));
    }

    @Override
    public void updateProfile(User user) {
        executeTransaction(entityManager -> {
            User managed = entityManager.find(User.class, user.getId());
            if (managed == null) {
                throw new IllegalArgumentException("Không tìm thấy người dùng.");
            }
            managed.setFullname(user.getFullname());
            managed.setPhone(user.getPhone());
            
            if (user.getAvatar() != null && !user.getAvatar().isBlank()) {
                managed.setAvatar(user.getAvatar());
            }
            if (user.getImages() != null && !user.getImages().isBlank()) {
                managed.setImages(user.getImages());
            }
        });
    }

    private void executeTransaction(java.util.function.Consumer<EntityManager> operation) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            operation.accept(entityManager);
            transaction.commit();
        } catch (RuntimeException exception) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw exception;
        } finally {
            entityManager.close();
        }
    }
}