import 'dart:io';

import 'package:bls/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;

  Future getImage({required profileImg}) async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage(profileImg: profileImg);
      }
    });
  }

  Future uploadImage({required profileImg}) async {
    String fileName = const Uuid().v1();
    int status = 1;

    await _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": _auth.currentUser!.uid,
      "profileImg": profileImg,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);
    }
  }

  void onSendMessage({required profileImag}) async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.uid,
        "profileImg": profileImag,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final allMyDataFromDB = Provider.of<UserProvider>(context).getUser;

    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: RadialGradient(colors: [
          Color.fromARGB(255, 38, 43, 116),
          Color.fromARGB(255, 14, 15, 34)
        ], radius: 0.7),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: StreamBuilder<DocumentSnapshot>(
            stream: _firestore
                .collection("userSSS")
                .doc(userMap['uid'])
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return SizedBox(
                  child: Column(
                    children: [
                      Text(userMap['name']),
                      Text(
                        snapshot.data!['status'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.75,
                width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chatroom')
                      .doc(chatRoomId)
                      .collection('chats')
                      .orderBy("time", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> map = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          return messages(
                              size: size,
                              map: map,
                              context: context,
                              profileImg: allMyDataFromDB!.profileImg);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Container(
                // color: Colors.red,
                height: size.height / 10,
                width: size.width,
                alignment: Alignment.center,
                child: SizedBox(
                  height: size.height / 12,
                  width: size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height / 17,
                        width: size.width / 1.3,
                        child: TextField(
                          controller: _message,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => getImage(
                                    profileImg: allMyDataFromDB!.profileImg),
                                icon: const Icon(Icons.photo),
                              ),
                              hintText: "Send Message",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () => onSendMessage(
                              profileImag:
                                  allMyDataFromDB!.profileImg.toString())),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget messages(
      {required size, required map, required context, required profileImg}) {
    return map['type'] == "text"
        ? SizedBox(
            child: map['sendby'] == _auth.currentUser!.uid
                ? Row(
                    mainAxisAlignment: map['sendby'] == _auth.currentUser!.uid
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          // width: size.width,
                          alignment: map['sendby'] == _auth.currentUser!.uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: map['sendby'] == _auth.currentUser!.uid
                                  ? Colors.green
                                  : Colors.blue,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                map['message'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(map!['profileImg']),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: map['sendby'] == _auth.currentUser!.uid
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(map!['profileImg']),
                      ),
                      Expanded(
                        child: Container(
                          // width: size.width,
                          alignment: map['sendby'] == _auth.currentUser!.uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: map['sendby'] == _auth.currentUser!.uid
                                  ? Colors.green
                                  : Colors.blue,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                map['message'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        : SizedBox(
            child: map['sendby'] == _auth.currentUser!.uid
                ? Row(
                    mainAxisAlignment: map['sendby'] == _auth.currentUser!.uid
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height / 3.5,
                        // width: size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        alignment: map['sendby'] == _auth.currentUser!.uid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ShowImage(
                                imageUrl: map['message'],
                              ),
                            ),
                          ),
                          child: Container(
                            height: size.height / 2.5,
                            width: size.width / 2,
                            decoration: BoxDecoration(border: Border.all()),
                            alignment:
                                map['message'] != "" ? null : Alignment.center,
                            child: map['message'] != ""
                                ? Image.network(
                                    map['message'],
                                    fit: BoxFit.cover,
                                  )
                                : const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(map!['profileImg']),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: map['sendby'] == _auth.currentUser!.uid
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(map!['profileImg']),
                      ),
                      Container(
                        height: size.height / 3.5,
                        // width: size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        alignment: map['sendby'] == _auth.currentUser!.uid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ShowImage(
                                imageUrl: map['message'],
                              ),
                            ),
                          ),
                          child: Container(
                            height: size.height / 2.5,
                            width: size.width / 2,
                            decoration: BoxDecoration(border: Border.all()),
                            alignment:
                                map['message'] != "" ? null : Alignment.center,
                            child: map['message'] != ""
                                ? Image.network(
                                    map['message'],
                                    fit: BoxFit.cover,
                                  )
                                : const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ));
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                opacity: 0.4)),
        // color: Colors.black,
        child: Image.network(imageUrl),
      ),
    )

        // Scaffold(
        //   backgroundColor: Colors.transparent,
        //   appBar: AppBar(
        //     backgroundColor: Colors.transparent,
        //   ),
        //   body: Container(
        //     height: size.height,
        //     width: size.width,
        //     color: Colors.black,
        //     child: Image.network(imageUrl),
        //   ),
        // )

        ;
  }
}

//