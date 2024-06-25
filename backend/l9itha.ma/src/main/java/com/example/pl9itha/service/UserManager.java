package com.example.pl9itha.service;

import com.example.pl9itha.entities.User;

import java.util.List;

public interface UserManager {
    public User getuser(Integer userid);
    public User adduser(User user);
    public List<User> getuser();
    public void deleteuser(int userid );
    public User updateuser(int userid , User user);



}
