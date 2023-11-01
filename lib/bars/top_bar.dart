import 'package:bls/chat/chat_screens/chat_home_screen.dart';
import 'package:bls/chat/chat_screens/main_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:bls/screens/top_bar_screens/search.dart';

import '../widget/icon_top_bar.dart';

class TopIconsBar extends StatefulWidget {
  const TopIconsBar({super.key});

  @override
  State<TopIconsBar> createState() => _TopIconsBarState();
}

class _TopIconsBarState extends State<TopIconsBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        IconTopBar(
          icon: Icons.search,
          onPressed: () {
            setState(() {
              // _selectedIndex = 0;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ));
          },
        ),
        InkWell(
          onTap: () {},
          child: Stack(
            children: [
              IconTopBar(
                icon: Icons.inbox,
                onPressed: () {
                  setState(() {
                    // _selectedIndex = 1;
                  });
                },
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.amberAccent,
                  radius: screenWidth > 600
                      ? screenWidth * 0.01
                      : screenWidth * 0.023,
                  child: const FittedBox(
                      child: Text(
                    "1",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        ),
        IconTopBar(
          icon: Icons.send,
          onPressed: () {
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MainChatScreen()));
            });
          },
        ),
      ],
    );
  }
}
