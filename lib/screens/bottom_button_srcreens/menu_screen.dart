import 'package:flutter/material.dart';
import 'package:bls/icon/my_flutter_app_icons.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Menu",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    MyIcons.avatar,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "My Account",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "Setting",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.report_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "Report",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    MyIcons.eye,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "Subscritions",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.security_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "Security",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.live_help_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "Live Support",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.star_border,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "Give Rate",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "Share App",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, left: 10, bottom: 30),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(45)),
              child: const Text(
                "Privacy and Terms",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    MyIcons.avatar,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "My Account",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    MyIcons.avatar,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "My Account",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(45)),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    MyIcons.avatar,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    "My Account",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
