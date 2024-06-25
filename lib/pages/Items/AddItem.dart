import 'dart:developer';

import 'package:flutter/material.dart';
 import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lqitha/components/my_button.dart';
import 'package:lqitha/components/my_datetime.dart';
 
import 'package:lqitha/components/my_textfield.dart';
import 'package:lqitha/components/toast.dart';
import 'package:lqitha/dao/models/comment.dart';
import 'package:lqitha/dao/models/post.dart';
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/services/database/firestore.dart';
 
class AddItem extends StatefulWidget {
const AddItem({ super.key });

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController nameBox = TextEditingController();
  TextEditingController descriptionBox = TextEditingController();
  TextEditingController locationBox = TextEditingController();
  TextEditingController categoryBox = TextEditingController();
  TextEditingController phoneBox = TextEditingController();
  TextEditingController dateFoundBox = TextEditingController();
  late String? userId = "";
  late AuthService authService;
  FireStoreService db = FireStoreService();
  @override 
  void initState() {
    super.initState();
    authService = AuthService();
    userId = authService.getCurrentUser()?.uid;
 
  }
  void addPost() async{
    if( nameBox.text.isEmpty 
        ||descriptionBox.text.isEmpty 
        ||locationBox.text.isEmpty
        ||phoneBox.text.isEmpty
        ||dateFoundBox.text.isEmpty
        ){
          showToast(context, "Some Fields Are Empty");
          return;
        }
 
    Post p = Post(
      name:nameBox.text.trim().toLowerCase(),
      description:descriptionBox.text.trim(),
      location: locationBox.text.trim(),
      phone:phoneBox.text.trim(),
      dateLost:DateTime.parse(dateFoundBox.text) ,
      userId:userId,
    );
    //add two fake  c omment
    List<Comment> comments = [

    ];
    p.comments = comments;
    //end comment
    showToast(context, p.toJson().toString());
    log(p.toJson().toString());
    db.savePostToDatabase(p);
    
  }
  @override
  Widget build(BuildContext context){
    Color blueColor = Theme.of(context).colorScheme.secondary;
    return SingleChildScrollView(
      child: Column(

        children: [
   
          const SizedBox(height: 10,),
          Text("Create A Post Now ",
            style: TextStyle(fontSize: 20,color:Theme.of(context).colorScheme.secondary),
          ),
          const SizedBox(height: 10,),
          MyTextfield(
            controller: nameBox,
            color: blueColor,
            hintText: "Name : ",
            obsecureText:  false
          ),
          const SizedBox(height: 10,),
          MyTextfield(
            controller: descriptionBox,
            hintText: "description : ",
            color: blueColor,
            obsecureText:  false
          ),
          const SizedBox(height: 10,),
          MyTextfield(
            controller: locationBox,
            hintText: "location : ",
            color: blueColor,
            obsecureText:  false
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: MediaQuery.of(context).size.width *0.88,
            child: Container(
              child: IntlPhoneField(
                decoration:   InputDecoration(
                  floatingLabelStyle: TextStyle(
                    color:Theme.of(context).colorScheme.secondary
                  ),
                  labelText: 'Phone Number',
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                ),
                initialCountryCode: 'MA',
                onChanged: (phone) {
                setState(() {
                  phoneBox.text = phone.completeNumber;
                });
                },
              ),
            ),
          ),
          const SizedBox(height: 10,),
          MyDatetime(
            label: "Date Lost ",
            dateFoundBox:dateFoundBox
          ),
          const SizedBox(height: 20,),
          
          MyButton(
            text:"Add",
            onTap: (){
              addPost();
               
            }, 
            bgcolor: Theme.of(context).colorScheme.secondary, 
            fgcolor: Theme.of(context).colorScheme.inversePrimary
          )
        ],
      ),
    );
  }
}