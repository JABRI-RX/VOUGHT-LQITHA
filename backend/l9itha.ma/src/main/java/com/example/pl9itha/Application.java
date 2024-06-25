package com.example.pl9itha;

import com.example.pl9itha.entities.Post;
import com.example.pl9itha.entities.User;
import com.example.pl9itha.service.PostManager;
import com.example.pl9itha.service.UserManager;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.Date;


@SpringBootApplication
public class Application  {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public CommandLineRunner start(UserManager userManager, PostManager postmanager){
        return (args -> {
            User u1 = new User("salahEDD","salah@gmail,com","SALAH123","0601010101");
            userManager.adduser(u1);

            Post p1 = new Post("iphoneXr","iphoneXrblanc","casablanca","0613059858");
            p1.setUser(u1);
            postmanager.addpost(p1);
        });
    }
}
