package vn.iotstar.services;

import vn.iotstar.entity.User;

public interface IUserService {
    User findById(int id);
    User findByEmail(String email);
    User findByUsername(String username);
    void updateProfile(User user);
}