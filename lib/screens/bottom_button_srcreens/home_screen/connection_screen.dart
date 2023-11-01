import 'package:bls/screens/bottom_button_srcreens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';
import '../../../widget/body_following.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
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

  getData() async {
    setState(() {
      isLoading = true;
    });
    // get Data from DB
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('userSSS')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = snapshot.data()!;

      followers = userData['followers'].length;
      following = userData["following"].length;
      followersList = userData['followers'].toList();
      followingList = userData['following'].toList();
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    getData();
    setState(() {});
    super.dispose();
    followers;
    following;
    followersList;
    followingList;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final allDataFromDB = Provider.of<UserProvider>(context).getUser;

    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: const BoxDecoration(
        gradient: RadialGradient(colors: [
          Color.fromARGB(255, 35, 40, 113),
          Color.fromARGB(255, 14, 15, 34)
        ], radius: 0.7),
      ),
      child: SafeArea(
        child: isLoading
            ? const Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
              )
            : Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  centerTitle: true,
                  title: SizedBox(
                      width: screenWidth > 600
                          ? screenWidth * 0.25
                          : screenWidth * 0.35,
                      child: const FittedBox(child: Text("My Connections"))),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(45)),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -0.8,
                            left: indexScreen == 0
                                ? 0
                                : indexScreen == 1
                                    ? screenWidth * 0.26
                                    : screenWidth * 0.526,
                            child: Container(
                              width: indexScreen == 0
                                  ? screenWidth * 0.25
                                  : indexScreen == 1
                                      ? screenWidth * 0.25
                                      : screenWidth * 0.27,
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
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
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
                                  'Followers',
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
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
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
                                  'Following',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              /////////////////////////////
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    indexScreen = 2;
                                  });
                                },
                                style: ButtonStyle(
                                  elevation: const MaterialStatePropertyAll(0),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.transparent),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      // side: BorderSide(
                                      //     color: indexScreen == 2
                                      //         ? Colors.red
                                      //         : Colors.transparent),
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Suggestion',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    indexScreen == 0
                        ?
                        //* Followers  //////
                        Expanded(
                            child: followers == 0
                                ? Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        height: screenHeight * 0.2,
                                        width: screenWidth * 0.9,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.red.withOpacity(0.7)),
                                          // color: Colors.white.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          // border: Border.all(width: 2, color: Colors.white30)
                                          gradient: const LinearGradient(
                                              colors: [
                                                Color.fromARGB(255, 14, 15, 34),
                                                Color.fromARGB(
                                                    255, 38, 43, 116),
                                                // Color.fromARGB(255, 14, 15, 34)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              stops: [
                                                0.3,
                                                0.6,
                                              ]),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "There are no followers ",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SvgPicture.asset(
                                              "assets/svg/sad_face_icon.svg",
                                              color: Colors.red,
                                              height: 50,
                                            )
                                          ],
                                        )),
                                  )
                                : StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('userSSS')
                                        // .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .where('uid', whereIn: followersList
                                            // whereIn: allDataFromDB!.followers.toList()
                                            )
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return const Text(
                                            'Something went wrong');
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ));
                                      }

                                      return ListView(
                                        children: snapshot.data!.docs
                                            .map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document
                                              .data()! as Map<String, dynamic>;
                                          return
                                              // ElevatedButton(
                                              //     onPressed: () {
                                              //       setState(() {
                                              //         print(userData['followers']
                                              //             .toList()
                                              //             .length);
                                              //       });
                                              //     },
                                              //     child: Text("ok"));
                                              InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Profile(
                                                            uiddd: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["uid"],
                                                          )));
                                            },
                                            child: BodyFollowingDesign(
                                              data: data,
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                          )
                        : indexScreen == 1
                            ?

                            //* Following  //////

                            Expanded(
                                child: following == 0
                                    ? Center(
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            height: screenHeight * 0.2,
                                            width: screenWidth * 0.9,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.red
                                                      .withOpacity(0.7)),
                                              // color: Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              // border: Border.all(width: 2, color: Colors.white30)
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 14, 15, 34),
                                                    Color.fromARGB(
                                                        255, 38, 43, 116),
                                                    // Color.fromARGB(255, 14, 15, 34)
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  stops: [
                                                    0.3,
                                                    0.6,
                                                  ]),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "There are no followeings ",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SvgPicture.asset(
                                                  "assets/svg/sad_face_icon.svg",
                                                  color: Colors.red,
                                                  height: 50,
                                                )
                                              ],
                                            )),
                                      )
                                    : StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('userSSS')
                                            // .doc(FirebaseAuth.instance.currentUser!.uid)
                                            .where('uid', whereIn: followingList
                                                // whereIn: allDataFromDB!
                                                //     .following
                                                //     .toList()
                                                )
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            return const Text(
                                                'Something went wrong');
                                          }

                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.white,
                                            ));
                                          }

                                          return ListView(
                                            children: snapshot.data!.docs.map(
                                                (DocumentSnapshot document) {
                                              Map<String, dynamic> data =
                                                  document.data()!
                                                      as Map<String, dynamic>;
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  Profile(
                                                                    uiddd: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                        ["uid"],
                                                                  )));
                                                },
                                                child: BodyFollowingDesign(
                                                  data: data,
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        },
                                      ),
                              )
                            : indexScreen == 2
                                ?

                                //* suggestions  //////

                                Expanded(
                                    // color: Colors.amber,

                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('userSSS')
                                          // .doc(FirebaseAuth.instance.currentUser!.uid)
                                          .where('uid',
                                              whereNotIn:
                                                  userData['followers'] +
                                                      userData['following'] +
                                                      [userData['uid']]

                                              // userData['fo llowing' , 'uid']

                                              // isNotEqualTo: allDataFromDB?.uid

                                              // isNotEqualTo: allDataFromDB?.uid,
                                              )
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ));
                                        }

                                        return ListView(
                                          children: snapshot.data!.docs
                                              .map((DocumentSnapshot document) {
                                            Map<String, dynamic> data =
                                                document.data()!
                                                    as Map<String, dynamic>;
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile(
                                                              uiddd: snapshot
                                                                      .data!
                                                                      .docs[
                                                                  index]["uid"],
                                                            )));
                                              },
                                              child: BodyFollowingDesign(
                                                data: data,
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                  ],
                ),
              ),
      ),
    );
  }
}
