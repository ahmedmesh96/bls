import 'package:bls/chat/chat_screens/chat_home_screen.dart';
import 'package:bls/chat/chat_screens/old_chat_screen.dart';
import 'package:bls/provider/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({super.key});

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  bool isfollow = true;
  Map userData = {};
  bool isLoading = true;
  int? followers;
  late int following;
  late int postCount;
  late bool showFollow;
  List followersList = [];
  List followingList = [];
  int index = 0;
  int indexScreen = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final allMyDataFromDB = Provider.of<UserProvider>(context).getUser;

    return Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: RadialGradient(colors: [
            Color.fromARGB(255, 38, 43, 116),
            Color.fromARGB(255, 14, 15, 34)
          ], radius: 0.7),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "My Chats",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              children: [
                Container(
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(45)),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -0.9,
                        left: indexScreen == 0 ? -0.5 : screenWidth * 0.346,
                        child: Container(
                          width: screenWidth * 0.35,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(45)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                indexScreen = 0;
                              });
                            },
                            style: ButtonStyle(
                              elevation: const MaterialStatePropertyAll(0),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  // side: BorderSide(
                                  //     color: indexScreen == 0
                                  //         ? Colors.red
                                  //         : Colors.transparent),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Old Chats',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),

                          ////////////////////////////
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                indexScreen = 1;
                              });
                            },
                            style: ButtonStyle(
                              elevation: const MaterialStatePropertyAll(0),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  // side: BorderSide(
                                  //     color: indexScreen == 1
                                  //         ? Colors.red
                                  //         : Colors.transparent),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                              ),
                            ),
                            child: const Text(
                              'New Chat',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          /////////////////////////////
                        ],
                      ),
                    ],
                  ),
                ),
                indexScreen == 0
                    ?
                    //* Old Chats  //////
                    Expanded(child: OldChatScreen())

                    // Expanded(
                    //     child: ChatsPage(
                    //         // child: ,
                    //         ))
                    :

                    //* New Chats  //////
                    Expanded(
                        child: ChatHomeScreen(
                            // allMyDataFromDB: allMyDataFromDB,
                            ))

                // Expanded(child: UsersPage())
              ],
            ),
          ),
        ));
  }
}
