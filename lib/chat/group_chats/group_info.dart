import 'package:bls/chat/chat_screens/chat_home_screen.dart';
import 'package:bls/chat/group_chats/add_members.dart';
import 'package:bls/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupInfo extends StatefulWidget {
  final String groupId, groupName;
  const GroupInfo({required this.groupId, required this.groupName, Key? key})
      : super(key: key);

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  List membersList = [];
  bool isLoading = true;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getGroupDetails();
  }

  Future getGroupDetails() async {
    await firestore
        .collection('groups')
        .doc(widget.groupId)
        .get()
        .then((chatMap) {
      membersList = chatMap['members'];
      print(membersList);
      isLoading = false;
      setState(() {});
    });
  }

  bool checkAdmin() {
    bool isAdmin = false;

    membersList.forEach((element) {
      if (element['uid'] == auth.currentUser!.uid) {
        isAdmin = element['isAdmin'];
      }
    });
    return isAdmin;
  }

  Future removeMembers(int index) async {
    String uid = membersList[index]['uid'];

    setState(() {
      isLoading = true;
      membersList.removeAt(index);
    });

    await firestore.collection('groups').doc(widget.groupId).update({
      "members": membersList,
    }).then((value) async {
      await firestore
          .collection('userSSS')
          .doc(uid)
          .collection('groups')
          .doc(widget.groupId)
          .delete();

      setState(() {
        isLoading = false;
      });
    });
  }

  void showDialogBox(int index) {
    if (checkAdmin()) {
      if (auth.currentUser!.uid != membersList[index]['uid']) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: ListTile(
                  onTap: () => removeMembers(index),
                  title: const Text("Remove This Member"),
                ),
              );
            });
      }
    }
  }

  Future onLeaveGroup() async {
    final allMyDataFromDB = Provider.of<UserProvider>(context).getUser;
    if (!checkAdmin()) {
      setState(() {
        isLoading = true;
      });

      for (int i = 0; i < membersList.length; i++) {
        if (membersList[i]['uid'] == auth.currentUser!.uid) {
          membersList.removeAt(i);
        }
      }

      await firestore.collection('groups').doc(widget.groupId).update({
        "members": membersList,
      });

      await firestore
          .collection('userSSS')
          .doc(auth.currentUser!.uid)
          .collection('groups')
          .doc(widget.groupId)
          .delete()
          .whenComplete(() {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => ChatHomeScreen(
                  // allMyDataFromDB: allMyDataFromDB,
                  )),
          (route) => false,
        );
      });

      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(
      //       builder: (_) => ChatHomeScreen(
      //           // allMyDataFromDB: allMyDataFromDB,
      //           )),
      //   (route) => false,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
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
          body: isLoading
              ? Container(
                  height: size.height,
                  width: size.width,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: BackButton(),
                      ),
                      SizedBox(
                        height: size.height / 8,
                        width: size.width / 1.1,
                        child: Row(
                          children: [
                            Container(
                              height: size.height / 11,
                              width: size.height / 11,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: Icon(
                                Icons.group,
                                color: Colors.white,
                                size: size.width / 10,
                              ),
                            ),
                            SizedBox(
                              width: size.width / 20,
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  widget.groupName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: size.width / 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        thickness: 1,
                        color: Colors.white.withOpacity(0.5),
                      ),

                      //

                      // SizedBox(
                      //   height: size.height / 20,
                      // ),

                      SizedBox(
                        width: size.width / 1.1,
                        child: Text(
                          "${membersList.length} Members",
                          style: TextStyle(
                            fontSize: size.width / 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: size.height / 20,
                      ),

                      // Members Name

                      checkAdmin()
                          ? ListTile(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => AddMembersINGroup(
                                    groupChatId: widget.groupId,
                                    name: widget.groupName,
                                    membersList: membersList,
                                  ),
                                ),
                              ),
                              leading: const Icon(
                                Icons.add,
                              ),
                              title: Text(
                                "Add Members",
                                style: TextStyle(
                                  fontSize: size.width / 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : const SizedBox(),

                      Flexible(
                        child: ListView.builder(
                          itemCount: membersList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                // color: mobileBackgroundColor,
                                gradient: const LinearGradient(colors: [
                                  Color.fromARGB(255, 14, 15, 34),
                                  Color.fromARGB(255, 38, 43, 116),
                                ]),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.white),
                              ),
                              child: ListTile(
                                onTap: () => showDialogBox(index),
                                leading: const Icon(Icons.account_circle),
                                title: Text(
                                  membersList[index]['name'],
                                  style: TextStyle(
                                    fontSize: size.width / 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(membersList[index]['email']),
                                trailing: Text(membersList[index]['isAdmin']
                                    ? "Admin"
                                    : ""),
                              ),
                            );
                          },
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.white.withOpacity(0.5),
                      ),

                      ListTile(
                        onTap: onLeaveGroup,
                        leading: const Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                        ),
                        title: Text(
                          "Leave Group",
                          style: TextStyle(
                            fontSize: size.width / 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
