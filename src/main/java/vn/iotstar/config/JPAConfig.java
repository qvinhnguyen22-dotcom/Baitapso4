package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceException;
import jakarta.persistence.Persistence;

public final class JPAConfig {
    private static volatile EntityManagerFactory factory;

    private JPAConfig() {
    }

    private static EntityManagerFactory factory() {
        EntityManagerFactory result = factory;
        if (result == null) {
            synchronized (JPAConfig.class) {
                result = factory;
                if (result == null) {
                    try {
                        result = Persistence.createEntityManagerFactory("jpa-crud");
                        factory = result;
                    } catch (RuntimeException ex) {
                        throw new PersistenceException(
                                "Không thể khởi tạo persistence unit 'jpa-crud'. "
                                        + "Kiểm tra SQL Server SQLEXPRESS và database JPA_DB.", ex);
                    }
                }
            }
        }
        return result;
    }

    public static EntityManager getEntityManager() {
        EntityManagerFactory factory = factory();
        if (!factory.isOpen()) {
            throw new IllegalStateException("EntityManagerFactory 'jpa-crud' đã bị đóng");
        }
        return factory.createEntityManager();
    }

    public static void close() {
        EntityManagerFactory result = factory;
        if (result != null && result.isOpen()) {
            result.close();
            factory = null;
        }
    }
}