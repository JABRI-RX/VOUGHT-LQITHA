package com.example.pl9itha.repositories;

import com.example.pl9itha.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User,Integer> {

     void deleteById(int userid);
}
