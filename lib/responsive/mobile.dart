import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bls/icon/my_flutter_app_icons.dart';

import 'package:bls/screens/bottom_button_srcreens/community_screen.dart';
import 'package:bls/screens/bottom_button_srcreens/profile.dart';

import '../screens/bottom_button_srcreens/library_screen.dart';
import '../screens/bottom_button_srcreens/home_screen/home_screen.dart';

import '../screens/bottom_button_srcreens/menu_screen.dart';
import '../shared/colors.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    return

        //  Scaffold(

        //     body: CupertinoTabScaffold(

        //       tabBar: CupertinoTabBar(

        //         border: const Border(top: BorderSide(color: Color.fromARGB(255, 112, 106, 106), style: BorderStyle.solid)),

        //         backgroundColor: const  Color.fromARGB(255, 11, 9, 38),

        //         items:
        //       const <BottomNavigationBarItem>[
        //       //active color use on first

        //       BottomNavigationBarItem(icon: Icon(Icons.home_outlined, color: Colors.grey,  ), activeIcon: Icon(Icons.home_outlined, color: Colors.deepOrange,)),
        //       BottomNavigationBarItem(icon: Icon(MyIcons.group_black ,   color: Colors.grey,  ), activeIcon: Icon(MyIcons.group_black, color: Colors.deepOrange,)),
        //       BottomNavigationBarItem(icon: Icon(MyIcons.avatar,  color: Colors.grey,  ), activeIcon: Icon(MyIcons.avatar, color: Colors.deepOrange,)),
        //       BottomNavigationBarItem(icon: Icon(MyIcons.play,  color: Colors.grey,  ), activeIcon: Icon(MyIcons.play, color: Colors.deepOrange,)),
        //       BottomNavigationBarItem(icon: Icon(Icons.menu,  color: Colors.grey,  ), activeIcon: Icon(Icons.menu, color: Colors.deepOrange,))
        //       ],
        //     ) ,
        //         tabBuilder: (context , index) {
        //           switch (index) {
        //             case 0:

        //               return CupertinoTabView(builder:  (context) {
        //                 return CupertinoPageScaffold( resizeToAvoidBottomInset: false,
        //                   child: MainHome(uiddd: FirebaseAuth.instance.currentUser!.uid,),);
        //               });
        //             case 1:
        //               return CupertinoTabView(builder: (context) {
        //                 return const CupertinoPageScaffold(child:CommunityScreen(),);
        //               });
        //             case 2:
        //               return CupertinoTabView(builder: (context) {
        //                 return CupertinoPageScaffold(child:Profile(uiddd: FirebaseAuth.instance.currentUser!.uid,), );
        //               });
        //             case 3:
        //               return CupertinoTabView(builder: (context) {
        //                 return const CupertinoPageScaffold(child: AddPostText(), );
        //               });
        //             case 4:
        //               return CupertinoTabView(builder: (context) {
        //                 return const CupertinoPageScaffold(child: Search(),);
        //               });
        //             default:
        //               CupertinoTabView(builder: (context) {
        //                 return const  CupertinoPageScaffold(child:  Text("page dates "),);
        //               });

        //           } return Container();
        //         }
        //     ),

        // );

        Scaffold(
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
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,

          // appBar: AppBar(
          //   title: const Text("Mobile Screen"),
          // ),
          bottomNavigationBar: CupertinoTabBar(

              // activeColor: primaryColor,
              // inactiveColor: secondaryColor,
              onTap: (index) {
                // navigate to the tabed page
                _pageController.jumpToPage(index);
                setState(() {
                  currentPage = index;
                });
              },
              backgroundColor: Colors.transparent,
              border: Border(
                  top: BorderSide(
                color: Colors.white.withOpacity(0.2),
              )),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      color: currentPage == 0 ? primaryColor : secondaryColor,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      MyIcons.group_black,
                      color: currentPage == 1 ? primaryColor : secondaryColor,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      MyIcons.avatar,
                      color: currentPage == 2 ? primaryColor : secondaryColor,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      MyIcons.play,
                      color: currentPage == 3 ? primaryColor : secondaryColor,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                      color: currentPage == 4 ? primaryColor : secondaryColor,
                    ),
                    label: ""),
              ]),
          body: PageView(
            onPageChanged: (index) {},
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              // ForgotPassword(),
              // VerifyEmailPage(),
              HomeScreen(
                uiddd: FirebaseAuth.instance.currentUser!.uid,
              ),
              const CommunityScreen(),
              Profile(
                uiddd: FirebaseAuth.instance.currentUser!.uid,
              ),
              const LibraryScreen(),

              const MenuScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class _KeepAlivePage extends StatefulWidget {
  const _KeepAlivePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
