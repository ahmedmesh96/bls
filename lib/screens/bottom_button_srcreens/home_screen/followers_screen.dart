import 'package:bls/screens/bottom_button_srcreens/profile.dart';
import 'package:bls/widget/body_following.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FollowersScreennn extends StatefulWidget {
  final Map userData;
  final bool isLoading;
  final int? followers;
  final int following;

  final bool showFollow;
  final List followersList;
  final List followingList;
  final int index;
  final int indexScreen;
  const FollowersScreennn(
      {super.key,
      required this.userData,
      required this.isLoading,
      this.followers,
      required this.following,
      required this.showFollow,
      required this.followersList,
      required this.followingList,
      required this.index,
      required this.indexScreen});

  @override
  State<FollowersScreennn> createState() => _FollowersScreennnState();
}

class _FollowersScreennnState extends State<FollowersScreennn> {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: widget.followers == 0
          ? Center(
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(bottom: 10),
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red.withOpacity(0.7)),
                    // color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25),
                    // border: Border.all(width: 2, color: Colors.white30)
                    gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 14, 15, 34),
                          Color.fromARGB(255, 38, 43, 116),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "There are no followers ",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
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
                  .where('uid', whereIn: widget.followersList
                      // whereIn: allDataFromDB!.followers.toList()
                      )
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
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
                                builder: (context) => Profile(
                                      uiddd: snapshot.data!.docs[widget.index]
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
    );
  }
}
