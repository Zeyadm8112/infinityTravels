 import 'package:flutter/material.dart';
 _modalBottomSheetMenu(BuildContext context){
        showModalBottomSheet(
            context: context,
            builder: (builder){
              return  Container(
                height: 350.0,
                color: Colors.transparent, //could change this to Color(0xFF737373), 
                           //so you don't have to change MaterialApp canvasColor
                child:  Container(
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0))),
                    child: Row(children: [
                      
                    ],)),
              );
            }
        );
      }