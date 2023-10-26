import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../firbase_services/firestore.dart';
import '../../provider/user_provider.dart';
import '../../responsive/mobile.dart';
import '../../responsive/responsive.dart';
import '../../responsive/web.dart';

class AddPostText extends StatefulWidget {
  const AddPostText({super.key});

  @override
  State<AddPostText> createState() => _AddPostTextState();
}

class _AddPostTextState extends State<AddPostText> {
  final myController = TextEditingController();

  final textPostController = TextEditingController();

  bool isLoading = false;
  Uint8List? imgPath;
  String? imgName;

  get mobileBackgroundColor => null;

  @override
  Widget build(BuildContext context) {
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: heightScreen,
        width: widthScreen,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 38, 43, 116),
            Color.fromARGB(255, 14, 15, 34)
          ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    await FireStoreMethods().uploadTextPost(
                        imgName: imgName,
                        // imgPath: imgPath,
                        textPost: textPostController.text,
                        profileImg: allDataFromDB!.profileImg,
                        username: allDataFromDB.username,
                        context: context);

                    setState(() {
                      isLoading = false;
                      imgPath = null;
                    });
                    setState(() {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainHome(uiddd: FirebaseAuth.instance.currentUser!.uid,)));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Responsive(
                              myMobileScreen: MobileScreen(),
                              myWebScreen: WebScreen(),
                            ),
                          ));

                      textPostController.clear();
                    });
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ))
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                setState(() {
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainHome(uiddd: FirebaseAuth.instance.currentUser!.uid,)));
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Responsive(myMobileScreen: MobileScreen(), myWebScreen: WebScreen(),),));
                  Navigator.pop(context);
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
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(124, 0, 102, 255)),
                    child: CircleAvatar(
                      radius: 33,
                      backgroundImage: NetworkImage(allDataFromDB!.profileImg
                          // "https://www.indiewire.com/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg"
                          ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      width: widthScreen * 0.1,
                      child: FittedBox(child: Text(allDataFromDB.username)))
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: textPostController,
                  maxLines: 8,
                  decoration: const InputDecoration(
                      hintText: "write a caption...", border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
