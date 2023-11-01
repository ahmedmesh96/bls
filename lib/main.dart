// import 'package:bls/firbase_services/chat_service/navigation_service.dart';
// import 'package:bls/provider/chat_provider/auth_provider.dart';
// import 'package:bls/screens/bottom_button_srcreens/home_screen/home_screen.dart';
// import 'package:bls/screens/login_register_screens/register.dart';
// import 'package:bls/screens/login_register_screens/sign_in.dart';
// import 'package:bls/screens/splash_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// //Packages
// import 'package:provider/provider.dart';

// //Services

// //Providers

// //Pages

// void main() {
//   runApp(
//     SplashPage(
//       key: UniqueKey(),
//       onInitializationComplete: () {
//         runApp(
//           MainApp(),
//         );
//       },
//     ),
//   );
// }

// class MainApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<AuthenticationProvider>(
//           create: (BuildContext _context) {
//             return AuthenticationProvider();
//           },
//         )
//       ],
//       child: MaterialApp(
//         title: 'Chatify',
//         theme: ThemeData(
//           backgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
//           scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
//           bottomNavigationBarTheme: BottomNavigationBarThemeData(
//             backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
//           ),
//         ),
//         navigatorKey: NavigationService.navigatorKey,
//         initialRoute: '/login',
//         routes: {
//           '/login': (BuildContext _context) => LoginPage(),
//           '/register': (BuildContext _context) => RegisterPage(),
//           '/home': (BuildContext _context) => HomeScreen(
//                 uiddd: FirebaseAuth.instance.currentUser!.uid,
//               ),
//         },
//       ),
//     );
//   }
// }

import 'package:bls/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bls/provider/user_provider.dart';
import 'package:bls/responsive/mobile.dart';
import 'package:bls/responsive/responsive.dart';
import 'package:bls/responsive/web.dart';

import 'package:bls/screens/login_register_screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bls/shared/snack_bar.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) async {
    if (kIsWeb) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
        apiKey: "AIzaSyC8EjiJQzXVJVfU8CMgzbqo2iwcvnVWnx8",
        authDomain: "instagram-tut-3502d.firebaseapp.com",
        projectId: "instagram-tut-3502d",
        storageBucket: "instagram-tut-3502d.appspot.com",
        messagingSenderId: "737392623661",
        appId: "1:737392623661:web:1c37f9689bc8cc2d1c38a4",
      ));
    } else {
      await Firebase.initializeApp();
    }
    runApp(const MyApp());
  });
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   //enter full-screen
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

//   //for setting orientation to portrait only
//   SystemChrome.setPreferredOrientations(
//           [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
//       .then((value) {
//     _initializeFirebase();
//     runApp(const MyApp());
//   });
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return UserProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BLS',
        theme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return const
                  // VerifyEmailPage();
                  Responsive(
                myMobileScreen: MobileScreen(),
                myWebScreen: WebScreen(),
              );
            } else {
              return Login();
            }
          },
        ),
        // home: const Responsive(
        //   myMobileScreen: MobileScreen(),
        //   myWebScreen: WebScreen(),
        // ),
      ),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // var result = await FlutterNotificationChannel.registerNotificationChannel(
  //     description: 'For Showing Message Notification',
  //     id: 'chats',
  //     importance: NotificationImportance.IMPORTANCE_HIGH,
  //     name: 'Chats');
  // log('\nNotification Channel Result: $result');
}
