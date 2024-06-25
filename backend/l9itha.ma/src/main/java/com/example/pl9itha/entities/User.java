package com.example.pl9itha.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

import java.util.Collection;

@Entity
@Table(name = "User")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userid;
    private String username ;
    private String email ;
    private String password ;
    private  String phone ;
    @OneToMany(mappedBy = "user")
    @JsonBackReference
    public Collection<Post> posts ;
    public  User(String username,String email,String password,String phone){
        this.username = username;
        this.email = email;
        this.password = password;
        this.phone = phone;
    }
}

