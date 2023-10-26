import 'package:flutter/material.dart';

class IconTopBar extends StatelessWidget {
  final IconData icon;

  final Function() onPressed;

  const IconTopBar({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: Colors.white,
            )),
      ],
    );
  }
}
