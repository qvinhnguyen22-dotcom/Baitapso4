package vn.iotstar.services;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDao;
import vn.iotstar.entity.User;

public class UserService implements IUserService {
    private final IUserDao userDao = new UserDao();

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public void updateProfile(User user) {
        userDao.updateProfile(user);
    }
}