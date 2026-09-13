package vn.iotstar.services;

import java.util.List;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.entity.Category;

public class CategoryServiceImpl implements ICategoryService {

    private final ICategoryDao cateDao = new CategoryDao();

    @Override
    public void insert(Category category) {
        cateDao.insert(category);
    }

    @Override
    public void update(Category category) {
        cateDao.update(category);
    }

    @Override
    public void delete(int id) {
        try {
            cateDao.delete(id);
        } catch (Exception e) {
            throw new RuntimeException("Xóa danh mục thất bại: " + e.getMessage(), e);
        }
    }

    @Override
    public Category findById(int id) {
        return cateDao.findById(id);
    }

    @Override
    public List<Category> findAll() {
        return cateDao.findAll();
    }
}