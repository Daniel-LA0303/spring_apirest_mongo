package com.example.SB_apirest_mongo.repository;

import com.example.SB_apirest_mongo.model.User;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserRepository extends MongoRepository<User, String> {
}
