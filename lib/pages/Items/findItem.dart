import 'package:flutter/material.dart';
 
class FindItem extends StatelessWidget {
const FindItem({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        const SizedBox(height: 10,),
          Text("Create A Post Now ",
            style: TextStyle(fontSize: 20,color:Theme.of(context).colorScheme.secondary),
          ),
      ],
    );
  }
}