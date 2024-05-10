package com.example.SB_apirest_mongo.service;

import com.example.SB_apirest_mongo.model.User;

import java.util.List;
import java.util.Optional;

public interface UserService {

    List<User> findAll();

    Optional<User> findById(String id);

    User save(User user);

    User update(User user);

    void deleteById(String id);
}
