import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bls/firbase_services/firestore.dart';
import 'package:bls/responsive/mobile.dart';
import 'package:bls/responsive/responsive.dart';
import 'package:bls/responsive/web.dart';

import 'package:bls/screens/add_post_screens/video_post.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';

import 'package:path/path.dart' show basename;

import 'add_post_text.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final decController = TextEditingController();

  bool isLoading = false;
  Uint8List? imgPath;
  String? imgName;

  uploadText2Screen() async {
    // Navigator.pop(context);
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

  // uploadVideo2Screen()async{
  //   Navigator.pop(context);

  // }

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
                // Navigator.of(context).pop();
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
                // Navigator.of(context).pop();
                // await uploadVideo2Screen();
                // pickVideo(ImageSource.gallery, context);
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Post Video",
                style: TextStyle(fontSize: 18, color: Colors.grey),
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
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          height: heightScreen,
          width: widthScreen,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 38, 43, 116),
              Color.fromARGB(255, 14, 15, 34)
            ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
          ),
          child: imgPath == null
              ? Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: const Text("Add New Post")),
                  body: Center(
                      child: IconButton(
                    onPressed: () {
                      showmodel();
                    },
                    icon: const Icon(
                      Icons.upload,
                      size: 44,
                    ),
                  )),
                )
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    actions: [
                      TextButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            await FireStoreMethods().uploadPost(
                                imgName: imgName,
                                imgPath: imgPath,
                                description: decController.text,
                                profileImg: allDataFromDB!.profileImg,
                                username: allDataFromDB.username,
                                context: context);

                            setState(() {
                              isLoading = false;
                              imgPath = null;
                            });
                            setState(() {
                              decController.clear();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Responsive(
                                      myMobileScreen: MobileScreen(),
                                      myWebScreen: WebScreen(),
                                    ),
                                  ));
                            });
                          },
                          child: const Text(
                            "Post",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {
                        setState(() {
                          imgPath = null;
                        });
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  body: Column(
                    children: [
                      isLoading
                          ? const LinearProgressIndicator()
                          : const Divider(
                              thickness: 1,
                              height: 30.0,
                            ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(124, 0, 102, 255)),
                            child: CircleAvatar(
                              radius: 33,
                              backgroundImage: NetworkImage(
                                  allDataFromDB!.profileImg
                                  // "https://www.indiewire.com/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg"
                                  ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: widthScreen * 0.15,
                              child: FittedBox(
                                  child: Text(allDataFromDB.username)))
                        ],
                      ),
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          controller: decController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                              hintText: "write a caption...",
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        width: widthScreen,
                        height: heightScreen * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          image: DecorationImage(
                              image: MemoryImage(imgPath!), fit: BoxFit.cover
                              // image: NetworkImage("https://www.flypgs.com/blog/wp-content/uploads/2019/04/dogal-anit-1.jpg"), fit: BoxFit.cover
                              ),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
