package com.example.pl9itha.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

import java.util.Date;
@Entity
@ToString
@Table(name = "Post")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Post {
    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY)
    public int id ;
    public String name ;
    public String description ;
    public String location ;
    public String phone ;
    public Date datefound ;
    @ManyToOne
    @JsonBackReference
    private User user ;
    public Post(String name,String description,String location,String phone){
        this.name = name;
        this.description = description;
        this.location = location;
        this.phone = phone;
        this.datefound = new Date();
    }

}
