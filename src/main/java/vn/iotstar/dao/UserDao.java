package vn.iotstar.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig;
import vn.iotstar.entity.User;

public class UserDao implements IUserDao {
    @Override
    public User findByEmail(String email) {
        return findOne("LOWER(TRIM(u.email))", normalize(email));
    }

    @Override
    public User findByUsername(String username) {
        return findOne("LOWER(TRIM(u.username))", normalize(username));
    }

    private User findOne(String field, String value) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE " + field + " = :value";
            TypedQuery<User> query = entityManager.createQuery(jpql, User.class);
            query.setParameter("value", value);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            entityManager.close();
        }
    }

    private String normalize(String value) {
        return value == null ? "" : value.trim().toLowerCase(java.util.Locale.ROOT);
    }

    @Override
    public void insert(User user) {
        executeTransaction(entityManager -> entityManager.persist(user));
    }

    @Override
    public void update(User user) {
        executeTransaction(entityManager -> entityManager.merge(user));
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