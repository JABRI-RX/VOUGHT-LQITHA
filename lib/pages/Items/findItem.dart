import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lqitha/components/my_button.dart';
import 'package:lqitha/components/my_textfield.dart';
import 'package:lqitha/components/toast.dart';
import 'package:lqitha/dao/models/post.dart';
import 'package:lqitha/pages/Items/detailsItem.dart';
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/services/database/firestore.dart';
 
class FindItem extends StatefulWidget {
const FindItem({ super.key });

  @override
  State<FindItem> createState() => _FindItemState();
}

class _FindItemState extends State<FindItem> {
  
  late TextEditingController itemNameBox ;
  final db = FireStoreService();
  late String? userId;
  late Future<List<Map<String,dynamic>>> _postsFuture;
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    itemNameBox = TextEditingController();
    userId = AuthService().getCurrentUser()!.uid;
  }
  @override
  Widget build(BuildContext context){
        Color color = Theme.of(context).colorScheme.inversePrimary;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          MyTextfield(
            controller: itemNameBox,
            hintText: "Item Name",
            obsecureText: false,
            color: Theme.of(context).colorScheme.secondary
          ),
          const SizedBox(height: 10,),
          MyButton(
            text: "Find Items",
            onTap: (){
              // if(itemNameBox.text.trim() == ""){
              //   showToast(context, "Item Name Field IS Empty");
              //   return;
              // }
              setState(() {
                _postsFuture = db.getPostsByName(itemNameBox.text.toLowerCase());
              });
              isSearching = true;
                 
            },
            bgcolor: Theme.of(context).colorScheme.secondary,
            fgcolor: Theme.of(context).colorScheme.inversePrimary
          ),
          // const SizedBox(height: 10,),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
            thickness: 3,
          ),
          if(isSearching) ... [
            FutureBuilder(
            future: _postsFuture  ,
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if ( snapshot.data!.isEmpty == true){
                return Center(
                  child: Text("No Items With this Name"),
                );
              }
              else if (snapshot.hasError){
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
              else{
 
                List<Map<String, dynamic>> posts = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context,index){
                      Post p = posts[index]["data"];
                      log("Post in list item is ${p.id}");
                      return  Container(
                        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                        decoration: BoxDecoration(
                          color: p.userId == userId
                            ?Theme.of(context).colorScheme.tertiary 
                            :Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading:   Icon(Icons.inbox,color: color,),
                          
                          title: Text(p.name ?? "No Title",
                            style: TextStyle(color: color),
                          ),
                          subtitle: Text(p.description ?? "No description",
                            style: TextStyle(color: color),
                          ),
                          trailing: Icon(Icons.arrow_right_alt ,color: color, ),
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context)=> DetailsItem(postId:p.id!))
                            );
                          },
                        ),
                      );
                    }
                  ),
                );
              }
            }
          )
          ]
        ],
      ),
    );
  }
}