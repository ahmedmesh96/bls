// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:insta/bars/scroll_main_bar.dart';
// import 'package:insta/screens/main_home.dart';

// import '../screens/main_scroll_bar_screen/wellness_screen.dart';
// import '../widget/app_bar_bottom.dart';
// import '../widget/custom_buttun_scroll_bar.dart';

// class AppBarNavigation extends StatefulWidget {
//   const AppBarNavigation({super.key});

//   @override
//   State<AppBarNavigation> createState() => _AppBarNavigationState();
// }

// class _AppBarNavigationState extends State<AppBarNavigation> {
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final double heightScreen = MediaQuery.of(context).size.height;
//     final double widthScreen = MediaQuery.of(context).size.width;
//     return DefaultTabController(
//       length: 7,
//       child: Scaffold(

//         extendBodyBehindAppBar: true,
//         body: Container(
//           height: heightScreen,
//           width: widthScreen,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//               Color.fromARGB(255, 38, 43, 116),
//               Color.fromARGB(255, 14, 15, 34)
//             ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
//           ),

//         child:  SafeArea(
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             body: DefaultTabController(
//             length: 7,
//             child: NestedScrollView(
//               headerSliverBuilder: (context, _) {
//                 return [
//                   SliverList(
//                     delegate: SliverChildListDelegate(
//                   [
//                     // profileHeaderWidget(context),

//                   ],
//                     ),
//                   ),
//                 ];
//               },
//               body: Column(
//                 children: <Widget>[
//                   Material(
//                     color: Colors.white.withOpacity(0.2),
//                     elevation: 0,
//                     child: TabBar(

//                       mouseCursor: MouseCursor.defer,
//                       isScrollable:true,
//                   labelColor: Colors.black,
//                   unselectedLabelColor: Colors.grey[400],
//                   indicatorWeight: 1,
//                   indicatorColor: const Color.fromARGB(255, 255, 255, 255),
//                   tabs: const  [
//                     Tab(text: "News", ),
//                     Tab(text: "Wellness",),
//                     Tab(text: "Callendar",),
//                     Tab(text: "Favours",),
//                     Tab(text: "Live",),
//                     Tab(text: "Retreat",),
//                     Tab(text: "BoB",),

//                   ],
//                     ),
//                   ),
//                   const Expanded(
//                     child: TabBarView(
//                   children: [
//                    Center(child: Text("news"),),

//                    WellnessScreen(),
//                    Center(child: Text("calender"),),
//                    Center(child: Text("hgvhg"),),
//                    Center(child: Text("jhbjhbh"),),
//                    Center(child: Text("jhbjhbh"),),
//                    Center(child: Text("jhbjhbh"),),

//                   ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//                 ),
//           ),
//         ),
//       ),),);

//   }
// }

// // CustomButtonScrollBar(onTap: () { setState(() {
// //                             selectedIndex = 2;
// //                           }); }, selected: selectedIndex == 2, text: 'Calendar',),

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bar extends StatefulWidget {
  const Bar({Key? key}) : super(key: key);

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  /// List of Tab Bar Item
  List<String> items = [
    "Home",
    "Explore",
    "Search",
    "Feed",
    "Post",
    "Activity",
    "Setting",
    "Profile",
  ];

  /// List of body icon
  List<IconData> icons = [
    Icons.home,
    Icons.explore,
    Icons.search,
    Icons.feed,
    Icons.post_add,
    Icons.local_activity,
    Icons.settings,
    Icons.person
  ];
  int current = 0;

  /////////////////////////////////////
  //@CodeWithFlexz on Instagram
  //
  //AmirBayat0 on Github
  //Programming with Flexz on Youtube
  /////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],

      /// APPBAR
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Custom TabBar",
          style: GoogleFonts.laila(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            /// CUSTOM TABBAR
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            width: 80,
                            height: 45,
                            decoration: BoxDecoration(
                              color: current == index
                                  ? Colors.white70
                                  : Colors.white54,
                              borderRadius: current == index
                                  ? BorderRadius.circular(15)
                                  : BorderRadius.circular(10),
                              border: current == index
                                  ? Border.all(
                                      color: Colors.deepPurpleAccent, width: 2)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                items[index],
                                style: GoogleFonts.laila(
                                    fontWeight: FontWeight.w500,
                                    color: current == index
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: current == index,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  shape: BoxShape.circle),
                            ))
                      ],
                    );
                  }),
            ),

            /// MAIN BODY
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icons[current],
                    size: 200,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    items[current],
                    style: GoogleFonts.laila(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
