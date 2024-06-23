package com.example.pl9itha.service;

import com.example.pl9itha.entities.Post;
import com.example.pl9itha.repositories.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service

public class PostService implements PostManager{
    @Autowired
    private PostRepository postRepository;
    @Override
    public Post getpost (Integer id) {
        return postRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id " + id));
    }

    @Override
    public Post addpost(Post post) {
        return postRepository.save(post);    }

    @Override
    public List<Post> getpost() {
        return postRepository.findAll();
    }

    @Override
    public void deletepost(int id) {
        postRepository.deleteById(id);
    }

    @Override
    public Post updatepost(int id, Post post) {
        Optional<Post> existingPost = postRepository.findById(id);
        if (existingPost.isPresent()) {
            Post updatedPost = existingPost.get();
            updatedPost.setName(post.getName());
            updatedPost.setDescription(post.getDescription());
            updatedPost.setLocation(post.getLocation());
            updatedPost.setPhone(post.getPhone());


            // Update other fields as necessary
            return postRepository.save(updatedPost);
        } else {
            throw new RuntimeException("Post not found with id " + id);
        }
    }
}
