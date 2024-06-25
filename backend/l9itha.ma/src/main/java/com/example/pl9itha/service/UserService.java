package com.example.pl9itha.service;

import com.example.pl9itha.entities.User;
import com.example.pl9itha.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService implements UserManager{
   @Autowired
    private UserRepository userRepository;

    @Override
    public User getuser(Integer userid) {
        return userRepository.findById(userid)
                .orElseThrow(() -> new RuntimeException("User not found with id " + userid));

    }

    @Override
    public User adduser(User user) {
        return userRepository.save(user);
    }

    @Override
    public List<User> getuser() {
        return userRepository.findAll();
    }

    @Override
    public void deleteuser(int userid) {
        userRepository.deleteById(userid);
    }

    @Override
    public User updateuser(int userid, User user) {
        Optional<User> existingUser = userRepository.findById(userid);
        if (existingUser.isPresent()) {
            User updatedUser = existingUser.get();
            updatedUser.setUsername(user.getUsername());
            updatedUser.setEmail(user.getEmail());
            updatedUser.setPassword(user.getPassword());
            updatedUser.setPhone(user.getPhone());

            return userRepository.save(updatedUser);
        } else {
            throw new RuntimeException("User not found with id " + userid);
        }
    }
}
