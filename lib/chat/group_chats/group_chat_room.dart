import 'dart:io';

import 'package:bls/chat/group_chats/group_info.dart';
import 'package:bls/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class GroupChatRoom extends StatelessWidget {
  final String groupChatId, groupName;

  GroupChatRoom({required this.groupName, required this.groupChatId, Key? key})
      : super(key: key);

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final allDataFromDB;
  File? imageFile;

  Future getImage({required profileImg, required name}) async {
    // final allDataFromDB = Provider.of<UserProvider>(context).getUser;
    ImagePicker picker = ImagePicker();

    await picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage(profileImg: profileImg, name: name);
      }
    });
  }

  Future uploadImage({required profileImg, required name}) async {
    String fileName = const Uuid().v1();
    int status = 1;

    await _firestore
        .collection('groups')
        .doc(groupChatId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": _auth.currentUser!.uid,
      "name": name,
      "profileImg": profileImg,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('groups')
          .doc(groupChatId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('groups')
          .doc(groupChatId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);
    }
  }

//******************************* */

  void onSendMessage({required profileImg, required name}) async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> chatData = {
        "sendBy": _auth.currentUser!.uid,
        "name": name,
        "profileImg": profileImg,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();

      await _firestore
          .collection('groups')
          .doc(groupChatId)
          .collection('chats')
          .add(chatData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // var heightAppBar = AppBar().preferredSize.height;
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
          title: Text(groupName),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GroupInfo(
                          groupName: groupName,
                          groupId: groupChatId,
                        ),
                      ),
                    ),
                icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Divider(
                thickness: 1,
                color: Colors.white.withOpacity(0.7),
              ),
              SizedBox(
                height: size.height * 0.75,
                width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('groups')
                      .doc(groupChatId)
                      .collection('chats')
                      .orderBy('time', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> chatMap =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                          return messageTile(
                              size: size,
                              chatMap: chatMap,
                              name: allMyDataFromDB!.name,
                              context: context,
                              profileImg: allMyDataFromDB.profileImg);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: size.height / 10,
                width: size.width,
                alignment: Alignment.center,
                child: SizedBox(
                  height: size.height / 0.51,
                  width: size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        // height: size.height / 17,
                        width: size.width / 1.3,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          expands: false,
                          minLines: 1,
                          maxLines: 100,
                          controller: _message,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => getImage(
                                    name: allMyDataFromDB!.name,
                                    profileImg: allMyDataFromDB.profileImg),
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
                              name: allMyDataFromDB!.name,
                              profileImg:
                                  allMyDataFromDB.profileImg.toString())),
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

  Widget messageTile(
      {required size,
      required chatMap,
      required name,
      required profileImg,
      required context}) {
    return chatMap['type'] == "text"
        ? SizedBox(
            child: chatMap['sendBy'] == _auth.currentUser!.uid
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        chatMap['sendBy'] == _auth.currentUser!.uid
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          // width: size.width,
                          alignment: chatMap['sendBy'] == _auth.currentUser!.uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              color: chatMap['sendBy'] == _auth.currentUser!.uid
                                  ? Colors.green
                                  : Colors.blue,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    chatMap!['name'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 0, 255, 229)),
                                  ),
                                  Text(
                                    chatMap['message'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(chatMap!['profileImg']),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment:
                        chatMap['sendby'] == _auth.currentUser!.uid
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(chatMap!['profileImg']),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // width: size.width,
                          alignment: chatMap['sendby'] == _auth.currentUser!.uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              color: chatMap['sendby'] == _auth.currentUser!.uid
                                  ? Colors.green
                                  : Colors.blue,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chatMap!['name'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 0, 255, 229)),
                                  ),
                                  Text(
                                    chatMap['message'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        : SizedBox(
            child: chatMap['sendby'] == _auth.currentUser!.uid
                ? Row(
                    mainAxisAlignment:
                        chatMap['sendby'] == _auth.currentUser!.uid
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height / 3.5,
                        // width: size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        alignment: chatMap['sendby'] == _auth.currentUser!.uid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ShowImage(
                                imageUrl: chatMap['message'],
                              ),
                            ),
                          ),
                          child: Container(
                            // color: Colors.red,
                            height: size.height / 2.5,
                            width: size.width / 2,
                            decoration: BoxDecoration(
                                color: Colors.green,

                                // color: Colors.red,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(22),
                                    bottomLeft: Radius.circular(22),
                                    bottomRight: Radius.circular(22)),
                                border: Border.all()),
                            alignment: chatMap['message'] != ""
                                ? null
                                : Alignment.center,
                            child: chatMap['message'] != ""
                                ? Stack(
                                    children: [
                                      Positioned(
                                          right: 3,
                                          child: Text(
                                            chatMap['name'],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 0, 255, 195)),
                                          )),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              top: 20,
                                              bottom: 3,
                                              left: 3,
                                              right: 3),
                                          height: size.height / 2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20),
                                                      topLeft:
                                                          Radius.circular(20)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    chatMap['message'],
                                                  ),
                                                  fit: BoxFit.cover))),
                                    ],
                                  )
                                : const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(chatMap!['profileImg']),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment:
                        chatMap['sendby'] == _auth.currentUser!.uid
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(chatMap!['profileImg']),
                        ),
                      ),
                      Container(
                        height: size.height / 3.5,
                        // width: size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        alignment: chatMap['sendby'] == _auth.currentUser!.uid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ShowImage(
                                imageUrl: chatMap['message'],
                              ),
                            ),
                          ),
                          child: Container(
                            height: size.height / 2.5,
                            width: size.width / 2,
                            decoration: BoxDecoration(
                                color: Colors.blue,

                                // color: Colors.red,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(22),
                                    bottomLeft: Radius.circular(22),
                                    bottomRight: Radius.circular(22)),
                                border: Border.all()),
                            alignment: chatMap['message'] != ""
                                ? null
                                : Alignment.center,
                            child: chatMap['message'] != ""
                                ? Stack(
                                    children: [
                                      Positioned(
                                          left: 3,
                                          child: Text(
                                            chatMap['name'],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 0, 255, 229)),
                                          )),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              top: 20,
                                              left: 3,
                                              bottom: 3,
                                              right: 3),
                                          height: size.height / 2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    chatMap['message'],
                                                  ),
                                                  fit: BoxFit.cover))),
                                    ],
                                  )
                                : const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ));

    // *************
    // return Builder(builder: (_) {
    //   if (chatMap['type'] == "text")

    //   {
    //     return Row(
    //       mainAxisAlignment: chatMap['sendby'] == _auth.currentUser!.uid
    //           ? MainAxisAlignment.end
    //           : MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Container(
    //           padding: const EdgeInsets.only(top: 10),
    //           child: CircleAvatar(
    //             radius: 10,
    //             backgroundImage: NetworkImage(chatMap!['profileImg']),
    //           ),
    //         ),
    //         Container(
    //           height: size.height / 3.5,
    //           // width: size.width,
    //           padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //           alignment: chatMap['sendby'] == _auth.currentUser!.uid
    //               ? Alignment.centerRight
    //               : Alignment.centerLeft,
    //           child: InkWell(
    //             onTap: () => Navigator.of(context).push(
    //               MaterialPageRoute(
    //                 builder: (_) => ShowImage(
    //                   imageUrl: chatMap['message'],
    //                 ),
    //               ),
    //             ),
    //             child: Container(
    //               height: size.height / 2.5,
    //               width: size.width / 2,
    //               decoration: BoxDecoration(border: Border.all()),
    //               alignment: chatMap['message'] != "" ? null : Alignment.center,
    //               child: chatMap['message'] != ""
    //                   ? Image.network(
    //                       chatMap['message'],
    //                       fit: BoxFit.cover,
    //                     )
    //                   : const CircularProgressIndicator(),
    //             ),
    //           ),
    //         ),
    //       ],
    //     )
    //         //   return SizedBox(
    //         //       child: chatMap['sendBy'] == _auth.currentUser!.uid
    //         //           ? Row(
    //         //               crossAxisAlignment: CrossAxisAlignment.start,
    //         //               mainAxisAlignment:
    //         //                   chatMap['sendBy'] == _auth.currentUser!.uid
    //         //                       ? MainAxisAlignment.end
    //         //                       : MainAxisAlignment.start,
    //         //               children: [
    //         //                 Expanded(
    //         //                   child: Container(
    //         //                     // width: size.width,
    //         //                     alignment: chatMap['sendBy'] == _auth.currentUser!.uid
    //         //                         ? Alignment.centerRight
    //         //                         : Alignment.centerLeft,
    //         //                     child: Container(
    //         //                         padding: const EdgeInsets.symmetric(
    //         //                             vertical: 8, horizontal: 14),
    //         //                         margin: const EdgeInsets.symmetric(
    //         //                             vertical: 5, horizontal: 8),
    //         //                         decoration: BoxDecoration(
    //         //                           borderRadius: BorderRadius.circular(15),
    //         //                           color:
    //         //                               chatMap['sendBy'] == _auth.currentUser!.uid
    //         //                                   ? Colors.green
    //         //                                   : Colors.blue,
    //         //                         ),
    //         //                         child: Column(
    //         //                           children: [
    //         //                             Text(
    //         //                               name,
    //         //                               // chatMap['sendBy'],
    //         //                               style: const TextStyle(
    //         //                                 fontSize: 12,
    //         //                                 fontWeight: FontWeight.w500,
    //         //                                 color: Colors.white,
    //         //                               ),
    //         //                             ),
    //         //                             Text(
    //         //                               chatMap['message'],
    //         //                               maxLines: 6,
    //         //                               // overflow: Over,
    //         //                               style: const TextStyle(
    //         //                                 fontSize: 16,
    //         //                                 fontWeight: FontWeight.w500,
    //         //                                 color: Colors.white,
    //         //                               ),
    //         //                             ),
    //         //                           ],
    //         //                         )),
    //         //                   ),
    //         //                 ),
    //         //                 Container(
    //         //                   padding: const EdgeInsets.only(top: 10),
    //         //                   child: CircleAvatar(
    //         //                     radius: 10,
    //         //                     backgroundImage: NetworkImage(chatMap!['profileImg']),
    //         //                   ),
    //         //                 ),
    //         //               ],
    //         //             )
    //         //           : Row(
    //         //               crossAxisAlignment: CrossAxisAlignment.start,
    //         //               mainAxisAlignment:
    //         //                   chatMap['sendBy'] == _auth.currentUser!.uid
    //         //                       ? MainAxisAlignment.end
    //         //                       : MainAxisAlignment.start,
    //         //               children: [
    //         //                 Container(
    //         //                   padding: const EdgeInsets.only(top: 10),
    //         //                   child: CircleAvatar(
    //         //                     radius: 10,
    //         //                     backgroundImage: NetworkImage(chatMap!['profileImg']),
    //         //                   ),
    //         //                 ),
    //         //                 Expanded(
    //         //                   child: Container(
    //         //                     // width: size.width,
    //         //                     alignment: chatMap['sendBy'] == _auth.currentUser!.uid
    //         //                         ? Alignment.centerRight
    //         //                         : Alignment.centerLeft,
    //         //                     child: Container(
    //         //                         padding: const EdgeInsets.symmetric(
    //         //                             vertical: 8, horizontal: 14),
    //         //                         margin: const EdgeInsets.symmetric(
    //         //                             vertical: 5, horizontal: 8),
    //         //                         decoration: BoxDecoration(
    //         //                           borderRadius: BorderRadius.circular(15),
    //         //                           color:
    //         //                               chatMap['sendBy'] == _auth.currentUser!.uid
    //         //                                   ? Colors.green
    //         //                                   : Colors.blue,
    //         //                         ),
    //         //                         child: Column(
    //         //                           children: [
    //         //                             Text(
    //         //                               name,
    //         //                               // chatMap['sendBy'],
    //         //                               style: const TextStyle(
    //         //                                 fontSize: 12,
    //         //                                 fontWeight: FontWeight.w500,
    //         //                                 color: Colors.white,
    //         //                               ),
    //         //                             ),
    //         //                             Text(
    //         //                               chatMap['message'],
    //         //                               maxLines: 6,
    //         //                               // overflow: Over,
    //         //                               style: const TextStyle(
    //         //                                 fontSize: 16,
    //         //                                 fontWeight: FontWeight.w500,
    //         //                                 color: Colors.white,
    //         //                               ),
    //         //                             ),
    //         //                           ],
    //         //                         )),
    //         //                   ),
    //         //                 ),
    //         //               ],
    //         //             ));
    //         // } else if (chatMap['type'] == "img") {
    //         //   return Container(
    //         //     width: size.width,
    //         //     alignment: chatMap['name'] == name
    //         //         ? Alignment.centerRight
    //         //         : Alignment.centerLeft,
    //         //     child: Container(
    //         //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    //         //       margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    //         //       // height: size.height / 2,
    //         //       width: size.width / 2,
    //         //       child: Image.network(
    //         //         chatMap['message'],
    //         //       ),
    //         //     ),
    //         //   )
    //         ;

    //     //************* */
    //   }

    //   else if (chatMap['type'] == "notify") {
    //     return Container(
    //       width: size.width,
    //       alignment: Alignment.center,
    //       child: Container(
    //         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    //         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(5),
    //           color: Colors.black38,
    //         ),
    //         child: Text(
    //           chatMap['message'],
    //           style: const TextStyle(
    //             fontSize: 14,
    //             fontWeight: FontWeight.bold,
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     );
    //   } else {
    //     return const SizedBox();
    //   }
    // });
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return
        //  Scaffold(
        //   backgroundColor: Colors.transparent,
        //   appBar: AppBar(
        //     backgroundColor: Colors.transparent,
        //   ),
        //   body: Container(
        //     height: size.height,
        //     width: size.width,
        //     decoration: BoxDecoration(
        //         image: DecorationImage(
        //             image: NetworkImage(imageUrl), fit: BoxFit.cover, opacity: 1)),
        //     // color: Colors.black,
        //     // child: SizedBox(width: size.width, child: Image.network(imageUrl)),
        //   ),
        // )

        Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}
