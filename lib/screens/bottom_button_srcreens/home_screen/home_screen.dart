import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:bls/bars/app_bar.dart';
import 'package:bls/screens/main_scroll_bar_screen/favourt.dart';
import 'package:bls/screens/main_scroll_bar_screen/live_screen.dart';
import 'package:bls/screens/main_scroll_bar_screen/retreat_screen.dart';
import 'package:bls/screens/main_scroll_bar_screen/wellness_screen.dart';
import 'package:bls/widget/custom_buttun_scroll_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bls/icon/my_flutter_app_icons.dart';
import 'package:path/path.dart' show basename;

import '../../../bars/scroll_main_bar.dart';
import '../../../bars/top_bar.dart';
import '../../../shared/text_post_desgin.dart';
import '../../add_post_screens/add_post.dart';
import '../../add_post_screens/add_post_text.dart';
import 'connection_screen.dart';
import '../../add_post_screens/video_post.dart';

class HomeScreen extends StatefulWidget {
  final String uiddd;

  const HomeScreen({
    super.key,
    required this.uiddd,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map userData = {};
  bool isLoading = true;
  late int followers;
  late int following;
  late int postCount;
  late bool showFollow;
  late int connectionCount;
  int selectedIndex = 0;
  int selectedIndexHome = 1;
  int selectedIndexWellness = 2;
  int selectedIndexFavours = 3;
  int selectedIndexLive = 4;
  int selectedIndexRetreat = 5;

  final decController = TextEditingController();

  Uint8List? imgPath;
  String? imgName;

  getData() async {
    setState(() {
      isLoading = true;
    });
    // get Data from DB
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('userSSS')
          .doc(widget.uiddd)
          .get();

      userData = snapshot.data()!;

      followers = userData["followers"].length;
      following = userData["following"].length;
      connectionCount = followers + following;

      //
      showFollow = userData["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);

      // to get post count
      //   var snapshotPosts = await FirebaseFirestore.instance
      //       .collection('postSSS')
      //       .where("uid", isEqualTo: widget.uiddd)
      //       .get();

      //   postCount = snapshotPosts.docs.length;
      // } catch (e) {
      //   print(e.toString());
      // }

      var snapshotTextPosts = await FirebaseFirestore.instance
          .collection('textPostSSS')
          .where("uid", isEqualTo: widget.uiddd)
          .get();

      postCount = snapshotTextPosts.docs.length;
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
  }

  uploadText2Screen() async {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddPostText(),
        ));
  }

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VideoPost(
                videoFile: File(video.path),
                videoPath: video.path,
              )));
    }
  }

  showmodel() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: const Color.fromARGB(255, 19, 18, 58),
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(20)),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                // Navigator.of(context).pop();
                await uploadImage2Screen(ImageSource.camera);
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "From Camera",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
                await uploadImage2Screen(ImageSource.gallery);
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "From Gallery",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
                // await uploadVideo2Screen();
                pickVideo(ImageSource.gallery, context);
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Post Video",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
                await uploadText2Screen();
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Post Text",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  uploadImage2Screen(ImageSource source) async {
    Navigator.pop(context);

    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          // imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
        // showSnackBar(context,"Error => $e");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: heightScreen,
        width: widthScreen,
        decoration: const BoxDecoration(
          gradient: RadialGradient(colors: [
            Color.fromARGB(255, 38, 43, 116),
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
                  extendBodyBehindAppBar: true,
                  backgroundColor: Colors.transparent,
                  body: SizedBox(
                    height: heightScreen,
                    width: widthScreen,
                    // decoration: const BoxDecoration(
                    //   gradient: LinearGradient(colors: [
                    //     Color.fromARGB(255, 38, 43, 116),
                    //     Color.fromARGB(255, 14, 15, 34)
                    //   ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
                    // ),
                    child: Column(
                      children: [
                        selectedIndex == 0
                            ? Stack(
                                children: [
                                  Container(),
                                  SizedBox(
                                      width: widthScreen > 600
                                          ? widthScreen * 0.2
                                          : widthScreen * 0.35,
                                      child: const FittedBox(
                                          child: TopIconsBar())),
                                ],
                              )
                            : const SizedBox(),
                        selectedIndex == 0
                            ? SizedBox(
                                width: widthScreen > 600
                                    ? widthScreen * 0.2
                                    : widthScreen * 0.35,
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Hello, ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        " ${userData["username"]}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        selectedIndex == 0
                            ? SizedBox(
                                height: heightScreen * 0.01,
                              )
                            : const SizedBox(),
                        selectedIndex == 0
                            ? Stack(
                                alignment: AlignmentDirectional.topCenter,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    height: widthScreen > 375
                                        ? heightScreen * 0.25
                                        : heightScreen * 0.3,
                                    width: widthScreen * 0.95,
                                    decoration: BoxDecoration(
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
                                    // ___________________________________________________________
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //_____________ profile photo + name of user
                                        Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                bottom: widthScreen > 333
                                                    ? widthScreen * 0.01
                                                    : widthScreen * 0.1,
                                              ),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                      top: 5,
                                                    ),
                                                    padding: EdgeInsets.all(
                                                        heightScreen * 0.003),
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    232,
                                                                    0,
                                                                    0)),
                                                    child: CircleAvatar(
                                                      radius:
                                                          heightScreen * 0.04,
                                                      backgroundImage:
                                                          NetworkImage(userData[
                                                              "profileImg"]),
                                                      // "https://www.indiewire.com/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg"),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 10,
                                                    right: 0,
                                                    child: SizedBox(
                                                      width:
                                                          heightScreen * 0.024,
                                                      child: FittedBox(
                                                        child:
                                                            FloatingActionButton(
                                                          onPressed: () {
                                                            // showmodel();

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const AddPost(),
                                                                ));
                                                          },
                                                          backgroundColor:
                                                              Colors.deepOrange,
                                                          child: SizedBox(
                                                            width:
                                                                heightScreen *
                                                                    0.06,
                                                            child:
                                                                const FittedBox(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FittedBox(
                                                child: Text(userData["name"])),
                                          ],
                                        ),

                                        //___________________________________navigation bar__________

                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              // connectins Button
                                              Column(
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                // mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                      "${connectionCount.toInt()}"),
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const ConnectionScreen(),
                                                              ));
                                                        });
                                                      },
                                                      icon: const Icon(MyIcons
                                                          .users_outline)),
                                                  const Text("Connections")
                                                ],
                                              ),

                                              // SizedBox( width: widthScreen * 0.4,),

                                              // Favourte Button

                                              Column(
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                // mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                children: [
                                                  const Text("0"),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(MyIcons
                                                          .all_inclusive)),
                                                  const Text("Favours")
                                                ],
                                              ),
                                              // SizedBox( width: widthScreen * 0.4,),

                                              //Tokens Button
                                              Column(
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  const Text("0"),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                          MyIcons.diamond)),
                                                  const Text("Tokens")
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: heightScreen * 0.01,
                        ),
                        //************************************************ */
                        // * Scroll Main Bar * ///
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: widthScreen > 450
                                  ? widthScreen * 0.07
                                  : widthScreen * 0.1,
                              width: widthScreen,
                              color: Colors.white.withOpacity(0.15),
                            ),
                            Center(
                              child: FittedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButtonScrollBar(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = 0;
                                        });
                                      },
                                      selected: selectedIndex == 0,
                                      text: "News",
                                    ),
                                    CustomButtonScrollBar(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = 1;
                                        });
                                      },
                                      selected: selectedIndex == 1,
                                      text: "Wellness",
                                    ),
                                    CustomButtonScrollBar(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = 2;
                                        });
                                      },
                                      selected: selectedIndex == 2,
                                      text: "Favours",
                                    ),
                                    Stack(
                                      children: [
                                        CustomButtonScrollBar(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = 3;
                                            });
                                          },
                                          selected: selectedIndex == 3,
                                          text: "Live",
                                        ),
                                        Positioned(
                                          top: 7.8,
                                          right: 7,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle),
                                            // color: Colors.red,
                                            width: 9,
                                            height: 9,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomButtonScrollBar(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = 4;
                                        });
                                      },
                                      selected: selectedIndex == 4,
                                      text: "Retreat",
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        //  Expanded(child: AppBarNavigation()),

                        //************************************************ */

                        SizedBox(
                          height: heightScreen * 0.01,
                        ),
                        //* News View -------------------------------/
                        selectedIndex == 0
                            ? Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('textPostSSS')
                                      .orderBy("datePublished",
                                          descending: true)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return const Text('Something went wrong');
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
                                      return TextPostDesgin(
                                        data: data,
                                      );
                                    }).toList());
                                  },
                                ),
                              )
                            : const SizedBox(),

                        //* Wellness View -------------------------------/

                        selectedIndex == 1
                            ? const Expanded(child: WellnessScreen())
                            : const SizedBox(),

                        //* Favours View -------------------------------/

                        selectedIndex == 2
                            ? const Expanded(child: FavourtScreen())
                            : const SizedBox(),

                        //* Live View -------------------------------/

                        selectedIndex == 3
                            ? const Expanded(child: LiveScreen())
                            : const SizedBox(),

                        //* Retreat View -------------------------------/

                        selectedIndex == 4
                            ? const Expanded(child: RetreatScreen())
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
