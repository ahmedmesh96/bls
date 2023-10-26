import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class BodyFollowingDesign extends StatefulWidget {
  final Map data;
  const BodyFollowingDesign({super.key, required this.data});

  @override
  State<BodyFollowingDesign> createState() => _BodyFollowingDesignState();
}

class _BodyFollowingDesignState extends State<BodyFollowingDesign> {
  bool isfollow = true;
  late Map allUid;

  @override
  void initState() {
    super.initState();
    // allDataFromDB!.followers;
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    // final double heightScreen = MediaQuery.of(context).size.height;
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;

    return Container(
      ///////
      decoration: BoxDecoration(
          // color: mobileBackgroundColor,
          // gradient: LinearGradient(colors: [
          //     Color.fromARGB(255, 38, 43, 116),
          //     Color.fromARGB(255, 14, 15, 34)
          //   ], begin: Alignment.topCenter),
          borderRadius: BorderRadius.circular(12)),

      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
        padding: const EdgeInsets.only(top: 3, bottom: 3, left: 7, right: 7),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 14, 15, 34),
              Color.fromARGB(255, 38, 43, 116),
            ]),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(124, 0, 102, 255)),
                  child: CircleAvatar(
                    radius: widthScreen * 0.06,
                    backgroundImage: NetworkImage(widget.data["profileImg"]),
                  ),
                ),
                const SizedBox(
                  width: 17,
                ),
                Text(
                  widget.data['username'],
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              child: FittedBox(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(45)),
                      child: const Text(
                        "Visit",
                        style: TextStyle(fontSize: 18),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
