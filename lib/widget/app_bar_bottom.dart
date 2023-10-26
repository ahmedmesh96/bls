
import 'package:flutter/material.dart';


class AppBarBottomDesgin extends StatelessWidget {
  final Function() onTap;

    final String text;
  final bool selected;
  const AppBarBottomDesgin({super.key, required this.text, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          // margin:  EdgeInsets.all(heightScreen * 0.0005),
          padding: const EdgeInsets.only(top: 8, left: 13, bottom: 8, right: 13,),
          decoration: BoxDecoration(
            
            // color: selected?  Colors.red : Colors.transparent,
            borderRadius: BorderRadius.circular(20), 
            
          
          ),
          // height: heightScreen *0.04,
         
          child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ),),
          
        ),
    );
  }
}


