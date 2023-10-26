import 'package:flutter/material.dart';

class CustomButtonScrollBar extends StatelessWidget {
  final Function() onTap;
  final String text;
  final bool selected;

  const CustomButtonScrollBar(
      {super.key,
      required this.text,
      required this.onTap,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            side: BorderSide(
                color: selected ? Colors.red : Colors.transparent, width: 3),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45))),
        child: Text(
          text,
          style:
              TextStyle(fontSize: widthScreen > 450 ? widthScreen * 0.05 : 18),
        ),
      ),
    );
  }
}
