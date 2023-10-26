import 'package:flutter/material.dart';


class IconBottomBar extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  const IconBottomBar({super.key,  
    required this.icon,
    required this.onPressed,
    required this.text,
    required this.selected
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onPressed,
         icon: Icon(icon, size: 25, color: selected ? Colors.deepOrangeAccent : Colors.white,)
         ),
         Text(text, style: TextStyle(fontSize: 12, height: 0.01, color: selected ? Colors.deepOrangeAccent : Colors.white),
         )

      ],
    );
  }
}