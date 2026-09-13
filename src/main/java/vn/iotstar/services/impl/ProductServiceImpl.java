package vn.iotstar.services.impl;

import java.util.List;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Product;
import vn.iotstar.services.IProductService;

public class ProductServiceImpl implements IProductService {

    private final IProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }

    @Override
    public Product findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> getTop10New() {
        return productDao.getTop10New();
    }

    @Override
    public List<Product> getPaging(int page, int pageSize) {
        return productDao.getPaging(page, pageSize);
    }

    @Override
    public int countAll() {
        return productDao.countAll();
    }
}
