package com.example.pl9itha.web;

import com.example.pl9itha.entities.Post;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.pl9itha.service.PostService;

import java.util.List;

@RestController
@RequestMapping("/posts")
public class PostController {

    @Autowired
    private PostService postService;

    @PutMapping("/{id}")
    public ResponseEntity<Post> updatePost(@PathVariable int id, @RequestBody Post post) {
        Post updatedPost = postService.updatepost(id, post);
        return ResponseEntity.ok(updatedPost);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePost(@PathVariable int id) {
        postService.deletepost(id);
        return ResponseEntity.noContent().build();
    }
    @GetMapping("/{id}")
    public ResponseEntity<Post> getPost(@PathVariable int id) {
        Post post = postService.getpost(id);
        return ResponseEntity.ok(post);
    }
    @PostMapping
    public ResponseEntity<Post> addPost(@RequestBody Post post) {
        Post newPost = postService.addpost(post);
        return ResponseEntity.ok(newPost);
    }
    @GetMapping
    public ResponseEntity<List<Post>> listPosts() {
        List<Post> posts = postService.getpost();
        return ResponseEntity.ok(posts);
    }






}
