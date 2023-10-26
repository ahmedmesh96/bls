import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class FollowersDesgin extends StatefulWidget {
  const FollowersDesgin({
    super.key,
  });

  @override
  State<FollowersDesgin> createState() => _FollowersDesginState();
}

class _FollowersDesginState extends State<FollowersDesgin> {
  int commentCount = 0;
  bool showHeart = false;
  bool isLikeAnimating = false;
  bool isShowText = true;
  bool isfollow = true;
  Map userData = {};
  bool isLoading = true;
  late int followers;
  late int following;
  late int postCount;
  late bool showFollow;
  List followersList = [];
  Map allUid = {};

  getData() async {
    setState(() {
      isLoading = true;
    });
    // get Data from DB
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('userSSS')
              // .where(['uid'], whereIn: followersList  )
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();

      userData = snapshot.data()!;

      followers = userData["followers"].length;
      following = userData["following"].length;
      followersList = userData['followers'];

      //
      showFollow = userData["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);

      // to get post count
      // var followersUid = await FirebaseFirestore.instance
      //     .collection('postSSS')
      //     .where("followers")
      //     .snapshots();
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    followersList;
  }

  @override
  Widget build(BuildContext context) {
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;

    final double widthScreen = MediaQuery.of(context).size.width;

    return isLoading
        ? const Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        : Container(
            ///////
            decoration: BoxDecoration(
                // color: mobileBackgroundColor,
                // gradient: LinearGradient(colors: [
                //     Color.fromARGB(255, 38, 43, 116),
                //     Color.fromARGB(255, 14, 15, 34)
                //   ], begin: Alignment.topCenter),
                borderRadius: BorderRadius.circular(12)),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(125, 78, 91, 110)),
                            child: CircleAvatar(
                              radius: widthScreen > 600
                                  ? widthScreen * 0.06
                                  : widthScreen * 0.07,
                              backgroundImage:
                                  NetworkImage(allDataFromDB!.profileImg
                                      // userData["profileImg"]
                                      ),
                            ),
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                          SizedBox(
                            width: widthScreen > 600
                                ? widthScreen * 0.1
                                : widthScreen * 0.12,
                            child: FittedBox(
                              child: Text(
                                userData['username'],
                                // style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: widthScreen > 600
                            ? widthScreen * 0.1
                            : widthScreen * 0.15,
                        child: FittedBox(
                          child: isfollow
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(45))),
                                  onPressed: () {
                                    setState(() {
                                      isfollow = false;
                                      print(followersList);
                                    });
                                  },
                                  child: const Text("Follow"))
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(45))),
                                  onPressed: () {
                                    setState(() {
                                      isfollow = true;
                                    });
                                  },
                                  child: const Text("Unfollow")),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
