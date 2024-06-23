 

import 'package:flutter/material.dart';
 
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
 
class MyDatetime extends StatefulWidget {
  final String label;
  TextEditingController dateFoundBox;
  MyDatetime({ 
      super.key,
      required this.label, required this.dateFoundBox ,
 
    });

  @override
  State<MyDatetime> createState() => _MyDatetimeState();
}

class _MyDatetimeState extends State<MyDatetime> {
  final TextEditingController dateTimeBox = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Container(
            child: GestureDetector(
              onTap: (){
                DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(2001, 11, 9),
                maxTime: DateTime(2049, 6, 7), 
                onChanged: (date){
                  
                }, 
                onConfirm: (date) {
                  setState(() {
                    widget.dateFoundBox.text = date.toString() ;
                  });
                }, 
                currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child:Container(
                decoration:  BoxDecoration(
               
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.secondary
              )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 15),
                child: Text(widget.dateFoundBox.text.isEmpty ? "Selecte Date":widget.dateFoundBox.text,
                  style: TextStyle(
                    color:Theme.of(context).colorScheme.secondary 
                  ),
                )    
              )
            )
 
          ) ;
  }
}