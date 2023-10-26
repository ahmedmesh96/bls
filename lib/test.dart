// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// import 'package:flutter/material.dart';




// class TEstBodyFollowingDesign extends StatefulWidget {
  
  
//   const TEstBodyFollowingDesign({super.key, 

//   });

//   @override
//   State<TEstBodyFollowingDesign> createState() => _TEstBodyFollowingDesignState();
// }

// class _TEstBodyFollowingDesignState extends State<TEstBodyFollowingDesign> {
//   int commentCount = 0;
//   bool showHeart = false;
//   bool isLikeAnimating = false;
//   bool isShowText = true;
//     Map userData = {};
//   bool isLoading = true;
//   late int followers;
//   late int following;
//   late int postCount;
//   late bool showFollow;













//   // follow screens. 
//   import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../provider/user_provider.dart';
// import '../../../widget/body_following.dart';

// class ConnectionScreen extends StatefulWidget {
//   const ConnectionScreen({super.key});

//   @override
//   State<ConnectionScreen> createState() => _ConnectionScreenState();
// }

// class _ConnectionScreenState extends State<ConnectionScreen> {
//   bool isfollow = true;
//   Map userData = {};
//   bool isLoading = true;
//   int? followers;
//   late int following;
//   late int postCount;
//   late bool showFollow;
//   List followersList = [];

//   getData() async {
//     setState(() {
//       isLoading = true;
//     });
//     // get Data from DB
//     try {
//       DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//           .instance
//           .collection('userSSS')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .get();

//       userData = snapshot.data()!;

//       followers = userData['followers'].length;
//       following = userData["following"].length;
//       followersList = userData['followers'];
//     } catch (e) {
//       print(e.toString());
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final allDataFromDB = Provider.of<UserProvider>(context).getUser;

//     return Container(
//       height: screenHeight,
//       width: screenWidth,
//       decoration: const BoxDecoration(
//         gradient: RadialGradient(colors: [
//           Color.fromARGB(255, 35, 40, 113),
//           Color.fromARGB(255, 14, 15, 34)
//         ], radius: 0.7),
//       ),
//       child: SafeArea(
//         child: DefaultTabController(
//           length: 3,
//           child: isLoading
//               ? const Scaffold(
//                   backgroundColor: Colors.transparent,
//                   body: Center(
//                       child: CircularProgressIndicator(
//                     color: Colors.white,
//                   )),
//                 )
//               : Scaffold(
//                   backgroundColor: Colors.transparent,
//                   appBar: AppBar(
//                     centerTitle: false,
//                     title: SizedBox(
//                         width: screenWidth > 600
//                             ? screenWidth * 0.25
//                             : screenWidth * 0.35,
//                         child: const FittedBox(child: Text("My Connections"))),
//                     backgroundColor: Colors.transparent,
//                     elevation: 0,
//                     bottom: TabBar(tabs: [
//                       Tab(
//                         child: SizedBox(
//                             width: screenWidth > 600
//                                 ? screenWidth * 0.13
//                                 : screenHeight * 0.09,
//                             child: const FittedBox(child: Text("Followers"))),
//                       ),
//                       Tab(
//                         child: SizedBox(
//                             width: screenWidth > 600
//                                 ? screenWidth * 0.13
//                                 : screenHeight * 0.09,
//                             child: const FittedBox(child: Text("Following"))),
//                       ),
//                       Tab(
//                         child: SizedBox(
//                             width: screenWidth > 600
//                                 ? screenWidth * 0.13
//                                 : screenHeight * 0.09,
//                             child: const FittedBox(child: Text("Suggestion"))),
//                       ),
//                     ]),
//                   ),
//                   body: TabBarView(children: [
//                     //* Followers  //////
//                     SizedBox(
//                       child: followers == 0
//                           ? const Center(
//                               child: Text("There are no followeings"),
//                             )
//                           : StreamBuilder<QuerySnapshot>(
//                               stream: FirebaseFirestore.instance
//                                   .collection('userSSS')
//                                   // .doc(FirebaseAuth.instance.currentUser!.uid)
//                                   .where('uid',
//                                       whereIn:
//                                           allDataFromDB!.followers.toList())
//                                   .snapshots(),
//                               builder: (BuildContext context,
//                                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                                 if (snapshot.hasError) {
//                                   return const Text('Something went wrong');
//                                 }

//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return const Center(
//                                       child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                   ));
//                                 }

//                                 return ListView(
//                                   children: snapshot.data!.docs
//                                       .map((DocumentSnapshot document) {
//                                     Map<String, dynamic> data = document.data()!
//                                         as Map<String, dynamic>;
//                                     return ElevatedButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             print(userData['followers']
//                                                 .toList()
//                                                 .length);
//                                           });
//                                         },
//                                         child: Text("ok"));
//                                     //     BodyFollowingDesign(
//                                     //   data: data,
//                                     // );
//                                   }).toList(),
//                                 );
//                               },
//                             ),
//                     ),

//                     // /*//////////////////////////////////*

//                     //* Following  //////

//                     SizedBox(
//                       child: following == 0
//                           ? const Center(
//                               child: Text("There are no followeings "),
//                             )
//                           : StreamBuilder<QuerySnapshot>(
//                               stream: FirebaseFirestore.instance
//                                   .collection('userSSS')
//                                   // .doc(FirebaseAuth.instance.currentUser!.uid)
//                                   .where('uid',
//                                       whereIn:
//                                           allDataFromDB!.following.toList())
//                                   .snapshots(),
//                               builder: (BuildContext context,
//                                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                                 if (snapshot.hasError) {
//                                   return const Text('Something went wrong');
//                                 }

//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return const Center(
//                                       child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                   ));
//                                 }

//                                 return ListView(
//                                   children: snapshot.data!.docs
//                                       .map((DocumentSnapshot document) {
//                                     Map<String, dynamic> data = document.data()!
//                                         as Map<String, dynamic>;
//                                     return BodyFollowingDesign(
//                                       data: data,
//                                     );
//                                   }).toList(),
//                                 );
//                               },
//                             ),
//                     ),
//                     //* suggestions  //////

//                     SizedBox(
//                       // color: Colors.amber,

//                       child: StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('userSSS')
//                             // .doc(FirebaseAuth.instance.currentUser!.uid)
//                             .where(
//                               'uid',
//                               whereNotIn:
//                                   userData['followers'] + userData['following'],

//                               // isNotEqualTo: allDataFromDB?.uid

//                               // isNotEqualTo: allDataFromDB?.uid,
//                             )
//                             .snapshots(),
//                         builder: (BuildContext context,
//                             AsyncSnapshot<QuerySnapshot> snapshot) {
//                           if (snapshot.hasError) {
//                             return const Text('Something went wrong');
//                           }

//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                                 child: CircularProgressIndicator(
//                               color: Colors.white,
//                             ));
//                           }

//                           return ListView(
//                             children: snapshot.data!.docs
//                                 .map((DocumentSnapshot document) {
//                               Map<String, dynamic> data =
//                                   document.data()! as Map<String, dynamic>;
//                               return BodyFollowingDesign(
//                                 data: data,
//                               );
//                             }).toList(),
//                           );
//                         },
//                       ),
//                     ),

//                     // FollowersScreen(uiddd: FirebaseAuth.instance.currentUser!.uid,),
//                     // FollowingScreen(uiddd: FirebaseAuth.instance.currentUser!.uid,),
//                   ]),
//                 ),
//         ),
//       ),
//     );
//   }
// }

   






//   getData() async {
//     setState(() {
//       isLoading = true;
//     });
//     // get Data from DB
//     try {
//       // await FirebaseFirestore.instance
//       //                               .collection("userSSS")
//       //                               .doc(FirebaseAuth.instance.currentUser!.uid)
//       //                               .update({
//       //                             "followers": FieldValue.arrayRemove(
//       //                                 [FirebaseAuth.instance.currentUser!.uid])
//       DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//           .instance
//           .collection('userSSS')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .get();

//       userData = snapshot.data()!;
      

//       followers = userData["followers"].length;
      
//       following = userData["following"].length;
      

      
      

//       //
//       showFollow = userData["followers"]
//           .contains(FirebaseAuth.instance.currentUser!.uid);

//       // to get post count
//       // var snapshotPosts = await FirebaseFirestore.instance
//       //     .collection('postSSS')
//       //     .where("uid", isEqualTo: widget.uiddd)
//       //     .get();

//       // postCount = snapshotPosts.docs.length;
//     } catch (e) {
//       // print(e.toString());
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }




//   void getFollowersUid (index) async{
//     final followersUid = await FirebaseFirestore.instance.collection("userSSS").get();
//     for ( var followerUid in followersUid.docs[index]["followers"] ) {
//       print(followerUid.data());
//     }
//   }




//   @override
//   void initState() {
//     super.initState();
//     getData();
//     // getFollowersUid();
//   }
  


//   // await FirebaseFirestore.instance
//   //                           .collection("postSSS")
//   //                           .doc(widget.data["postId"])
//   //                           .delete();




//   @override
//   Widget build(BuildContext context) {
//     final double widthScreen = MediaQuery.of(context).size.width;
//     final double heightScreen = MediaQuery.of(context).size.height;
    


              
//     return 
//     // userData["uid"]   == userData["followers"]
//     //       .contains(FirebaseAuth.instance.currentUser!.uid) ?
//       Container(
//             ///////
//             decoration: BoxDecoration(
//                 // color: mobileBackgroundColor,
//                 // gradient: LinearGradient(colors: [
//                 //     Color.fromARGB(255, 38, 43, 116),
//                 //     Color.fromARGB(255, 14, 15, 34)
//                 //   ], begin: Alignment.topCenter),
//                 borderRadius: BorderRadius.circular(12)),

//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 16.0, horizontal: 13.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(3),
//                             decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Color.fromARGB(125, 78, 91, 110)),
//                             child: CircleAvatar(
//                               radius: widthScreen > 600
//                                   ? widthScreen * 0.06
//                                   : widthScreen * 0.07,
//                               backgroundImage:
//                                   NetworkImage(userData["profileImg"]),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 17,
//                           ),
//                           SizedBox(
//                             width: widthScreen > 600
//                                 ? widthScreen * 0.1
//                                 : widthScreen * 0.12,
//                             child: FittedBox(
//                               child: Text(
//                                 userData['username'],
//                                 // style: const TextStyle(fontSize: 15),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: widthScreen > 600
//                             ? widthScreen * 0.08
//                             : widthScreen * 0.12,
//                         child: FittedBox(
//                           child: IconButton(
//                               onPressed: () {
//                                 // showmodel();
//                                 setState(() {
//                                   // getFollowersUid();
//                                 });
//                               },
//                               icon: const Icon(Icons.more_vert)),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
          
        
//   }
// }
