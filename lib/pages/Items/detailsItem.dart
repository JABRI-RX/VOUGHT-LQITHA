import 'package:flutter/material.dart';
import 'package:lqitha/pages/Items/listItemDetails.dart';

class DetailsItem extends StatefulWidget {
  String postId;
  DetailsItem({ 
    super.key,
    required this.postId
    });

  @override
  State<DetailsItem> createState() => _DetailsItemState();
}

class _DetailsItemState extends State<DetailsItem> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Details ",
            style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
         backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: ListItemDetails(postId:widget.postId),
    );
  }
}