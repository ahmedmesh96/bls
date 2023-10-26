// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../screens/bottom_button_srcreens/home_screen/home_screen.dart';

// import '../screens/main_scroll_bar_screen/wellness_screen.dart';
// import '../widget/custom_buttun_scroll_bar.dart';
// import 'app_bar.dart';

// class ScrollMainBar extends StatefulWidget {
//   const ScrollMainBar({
//     super.key,
//   });

//   @override
//   State<ScrollMainBar> createState() => _ScrollMainBarState();
// }

// class _ScrollMainBarState extends State<ScrollMainBar> {
//   int selectedIndex = 0;
//   // final screen = [
//   // MainHome(uiddd: FirebaseAuth.instance.currentUser!.uid,),
//   // WellnessScreen()

//   // ];

//   @override
//   Widget build(BuildContext context) {
//     // final double heightScreen = MediaQuery.of(context).size.height;
//     final double widthScreen = MediaQuery.of(context).size.width;

//     return widthScreen > 700
//         ? Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 height:
//                     widthScreen > 450 ? widthScreen * 0.07 : widthScreen * 0.1,
//                 width: widthScreen,
//                 color: Colors.white.withOpacity(0.15),
//               ),
//               Center(
//                 child: FittedBox(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomButtonScrollBar(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = 0;
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => HomeScreen(
//                                     uiddd:
//                                         FirebaseAuth.instance.currentUser!.uid,
//                                   ),
//                                 ));
//                           });
//                         },
//                         selected: selectedIndex == 0,
//                         text: "News",
//                       ),
//                       CustomButtonScrollBar(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = 1;
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const WellnessScreen(),
//                                 ));
//                           });
//                         },
//                         selected: selectedIndex == 1,
//                         text: "Wellness",
//                       ),
//                       CustomButtonScrollBar(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = 2;
//                           });
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const Bar(),
//                               ));
//                         },
//                         selected: selectedIndex == 2,
//                         text: "Calendar",
//                       ),
//                       CustomButtonScrollBar(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = 3;
//                           });
//                         },
//                         selected: selectedIndex == 3,
//                         text: "Favours",
//                       ),
//                       Stack(
//                         children: [
//                           CustomButtonScrollBar(
//                             onTap: () {
//                               setState(() {
//                                 selectedIndex = 4;
//                               });
//                             },
//                             selected: selectedIndex == 4,
//                             text: "Live",
//                           ),
//                           Positioned(
//                             top: 7.8,
//                             right: 7,
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                   color: Colors.red, shape: BoxShape.circle),
//                               // color: Colors.red,
//                               width: 9,
//                               height: 9,
//                             ),
//                           ),
//                         ],
//                       ),
//                       CustomButtonScrollBar(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = 5;
//                           });
//                         },
//                         selected: selectedIndex == 5,
//                         text: "Retreat",
//                       ),
//                       CustomButtonScrollBar(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = 6;
//                           });
//                         },
//                         selected: selectedIndex == 6,
//                         text: "BoB",
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           )
//         : Container(
//             height: 45
//             //  widthScreen > 600 ? widthScreen * 0.07: heightScreen * 0.05
//             ,
//             width: widthScreen,
//             color: Colors.white24,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CustomButtonScrollBar(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = 0;

//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => HomeScreen(
//                                 uiddd: FirebaseAuth.instance.currentUser!.uid,
//                               ),
//                             ));
//                       });
//                     },
//                     selected: selectedIndex == 0,
//                     text: "News",
//                   ),
//                   CustomButtonScrollBar(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = 1;

//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const WellnessScreen(),
//                             ));
//                       });
//                     },
//                     selected: selectedIndex == 1,
//                     text: "Wellness",
//                   ),
//                   CustomButtonScrollBar(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = 3;
//                       });
//                     },
//                     selected: selectedIndex == 3,
//                     text: "Favours",
//                   ),
//                   Stack(
//                     children: [
//                       CustomButtonScrollBar(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = 4;
//                           });
//                         },
//                         selected: selectedIndex == 4,
//                         text: "Live",
//                       ),
//                       Positioned(
//                         top: 7.8,
//                         right: 7,
//                         child: Container(
//                           decoration: const BoxDecoration(
//                               color: Colors.red, shape: BoxShape.circle),
//                           // color: Colors.red,
//                           width: 9,
//                           height: 9,
//                         ),
//                       ),
//                     ],
//                   ),
//                   CustomButtonScrollBar(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = 5;
//                       });
//                     },
//                     selected: selectedIndex == 5,
//                     text: "Retreat",
//                   ),
//                   CustomButtonScrollBar(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = 6;
//                       });
//                     },
//                     selected: selectedIndex == 6,
//                     text: "BoB",
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }
