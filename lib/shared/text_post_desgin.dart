import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextPostDesgin extends StatefulWidget {
  final Map data;

  const TextPostDesgin({
    super.key,
    required this.data,
  });

  @override
  State<TextPostDesgin> createState() => _TextPostDesginState();
}

class _TextPostDesginState extends State<TextPostDesgin> {
  Map userData = {};
  bool isLoading = true;
  int commentCount = 0;
  bool showHeart = false;
  bool isLikeAnimating = false;
  bool isShowText = true;
  late int followers;
  late int following;
  late int postCount;
  late bool showFollow;

  // getCommentCount() async {
  //   try {
  //     QuerySnapshot commentdata = await FirebaseFirestore.instance
  //         .collection("textPostSSS")
  //         .doc(widget.data["postId"])
  //         .collection("commentSSS")
  //         .get();

  //     setState(() {
  //       commentCount = commentdata.docs.length;
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  showmodel() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              FirebaseAuth.instance.currentUser!.uid == widget.data["uid"]
                  ? SimpleDialogOption(
                      onPressed: () async {
                        Navigator.of(context).pop();

                        await FirebaseFirestore.instance
                            .collection("textPostSSS")
                            .doc(widget.data["postId"])
                            .delete();
                      },
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "Delete Post",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : const SimpleDialogOption(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "You can't Delete Post",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
              SimpleDialogOption(
                onPressed: () async {
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
        });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // getCommentCount();
  // }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Container(
      ///////
      decoration: BoxDecoration(
          // color: mobileBackgroundColor,
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 14, 15, 34),
            Color.fromARGB(255, 38, 43, 116),
          ]),
          borderRadius: BorderRadius.circular(30)),

      margin: EdgeInsets.symmetric(
          horizontal: widthScreen * 0.01, vertical: widthScreen * 0.01),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 13.0),
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
                            ? widthScreen * 0.04
                            : widthScreen * 0.04,
                        backgroundImage:
                            NetworkImage(widget.data["profileImg"]),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: widthScreen > 600
                          ? widthScreen * 0.07
                          : widthScreen * 0.08,
                      child: FittedBox(
                        child: Text(
                          widget.data["username"],
                          // style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),

                // _______________________

                widthScreen > 600
                    ? Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isShowText = !isShowText;
                            });
                          },
                          child: Container(
                            // width: widthScreen,
                            margin: EdgeInsets.symmetric(
                                horizontal: widthScreen * 0.01),
                            child: Text(
                              widget.data["description"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: isShowText ? 2 : 10,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isShowText = !isShowText;
                            });
                          },
                          child: Container(
                            width: widthScreen,
                            margin: EdgeInsets.symmetric(
                                horizontal: widthScreen * 0.03),
                            child: Text(
                              widget.data["description"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: isShowText ? 2 : 10,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),

                // _______________________

                SizedBox(
                  width: widthScreen > 600
                      ? widthScreen * 0.08
                      : widthScreen * 0.08,
                  child: FittedBox(
                    child: IconButton(
                        onPressed: () {
                          showmodel();
                        },
                        icon: const Icon(Icons.more_vert)),
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
