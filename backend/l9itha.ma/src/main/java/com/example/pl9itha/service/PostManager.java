package com.example.pl9itha.service;

import com.example.pl9itha.entities.Post;

import java.util.List;

public interface PostManager {
    public Post getpost(Integer id);
    public Post addpost(Post post);
    public List<Post> getpost();
    public void deletepost(int id );
    public Post updatepost(int id , Post post);
}
