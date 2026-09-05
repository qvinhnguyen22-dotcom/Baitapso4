package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface IUserDao {
    User findByEmail(String email);
    User findByUsername(String username);
    void insert(User user);
    void update(User user);
}