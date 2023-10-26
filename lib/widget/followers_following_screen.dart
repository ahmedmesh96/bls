

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FollowersScreen extends StatefulWidget {
  final String uiddd;
  const FollowersScreen({super.key, required this.uiddd});
  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
Map userData = {};
  bool isLoading = true;
  late int followers;
  late List followersList;
  late int following;
 
  late bool showFollow;




 
//_______get data____________________________________________________
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
      followersList = userData["followers"].toList;

      //
      showFollow = userData["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);

      // to get post count
      // var snapshotPosts = await FirebaseFirestore.instance
      //     .collection('postSSS')
      //     .where("uid", isEqualTo: widget.uiddd)
      //     .get();

      // postCount = snapshotPosts.docs.length;
    } catch (e) {
      // print(e.toString());
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
  //-------------------------------------------------------




  

  



  

  @override
  Widget build(BuildContext context) {

    // final double heightScreen = MediaQuery.of(context).size.height;
    return 
                    


    
    Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('userSSS')
                    .where("uid", isEqualTo: widget.uiddd)
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

                  return Center(child: Text(followers.toString()),); 
                  // ListView.builder(
                  //   scrollDirection: Axis.vertical,
                  //   itemCount: 1,
                  //   itemBuilder: (context, index){
                  //     return 
                  //   },
                  //   );
                  
                  // ListView(
                  //     children: snapshot.data!.docs
                  //         .map((DocumentSnapshot document) {
                  //   Map<String, dynamic> data =
                  //       document.data()! as Map<String, dynamic>;
                  //   return FolowerDesgin(
                  //     data: data,
                  //   );
                  // }).toList());
                },
              ),
            )
    ;
  }
}


// __________________________________________________________________________________________________________________



// class GetUserName extends StatelessWidget {
//   final String uid;

//   GetUserName(this.uid);

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('userSSS').doc(uid).get() as CollectionReference<Object?>;
//     // CollectionReference usersFollowers = FirebaseFirestore.instance.collection('userSSS').doc(followers);

//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(uid).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//           return Text("Full Name: ${data['full_name']} ${data['last_name']}");
//         }

//         return Text("loading");
//       },
//     );
//   }
// }








// __________________________________________________________________________________________________________________


class FolowerDesgin extends StatefulWidget {
  final Map data;

  const FolowerDesgin({super.key, required this.data});

  @override
  State<FolowerDesgin> createState() => _FolowerDesginState();
}

class _FolowerDesginState extends State<FolowerDesgin> {
  bool  isFollow = true;
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    

    return Container(
      margin: const  EdgeInsets.only(left: 10, top: 15, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: const  Color.fromARGB(255, 195, 46, 46),
                radius: widthScreen > 600
                                      ? widthScreen * 0.055
                                      : widthScreen * 0.075,
                child: CircleAvatar(
                                  radius: widthScreen > 600
                                      ? widthScreen * 0.05
                                      : widthScreen * 0.07,
                                  backgroundImage:
                                      NetworkImage(widget.data["profileImg"]),
                                ),
              ),

                              Container(margin:const  EdgeInsets.only(left: 20),
                                width: widthScreen * 0.1,
                                child: FittedBox(child: Text(widget.data["username"], style: const TextStyle(fontSize: 33),)))
            ],
          ),

          SizedBox(
            width: widthScreen > 600 ? widthScreen * 0.1 : widthScreen* 0.15,
            child: FittedBox(
              child: ElevatedButton(onPressed: (){
                setState(() {
                  isFollow = !isFollow;
                });
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                backgroundColor: isFollow ? Colors.green: Colors.red
              ), child: Text( isFollow  ? "Follow" : "Unfollow"),),
            ),
          )
        ],
      ),

    );
  }
}




//_______________________
// following screen


class FollowingScreen extends StatefulWidget {
  final String uiddd;

  
  const FollowingScreen({super.key, required this.uiddd});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  Map userData = {};
  bool isLoading = true;
  late int followers;
  late List followersList;
  late int following;
  late int postCount;
  late bool showFollow;
  late int connectionCount;
  final decController = TextEditingController();

  //________________________________________________
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
      followersList = userData["followers"].toList;

      //
      showFollow = userData["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);

      // to get post count
      // var snapshotPosts = await FirebaseFirestore.instance
      //     .collection('postSSS')
      //     .where("uid", isEqualTo: widget.uiddd)
      //     .get();

      // postCount = snapshotPosts.docs.length;
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
  //__________________________
  @override
  Widget build(BuildContext context) {
    return   Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('userSSS')
                    .where("uid", isEqualTo: widget.uiddd)
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

                  return Center(child: Text(following.toString())); 
                  
                },
              ),
            );
                   
}}