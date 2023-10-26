// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:bls/shared/colors.dart';

import '../../responsive/mobile.dart';
import '../../responsive/responsive.dart';
import '../../responsive/web.dart';
import '../../shared/snack_bar.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        // when we click on the link that existed on yahoo
        await FirebaseAuth.instance.currentUser!.reload();

        // is email verified or not (clicked on the link or not) (true or false)
        setState(() {
          isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        });

        if (isEmailVerified) {
          timer.cancel();
        }
      });
    }
  }

  sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      showSnackBar(context, "ERROR => ${e.toString()}");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return isEmailVerified
        ? Responsive(
            myMobileScreen: MobileScreen(),
            myWebScreen: WebScreen(),
          )
        : Scaffold(
            backgroundColor:
                widthScreen > 600 ? webBackgroundColor : mobileBackgroundColor,
            appBar: AppBar(
              title: Text("Verify Email"),
              elevation: 0,
            ),
            body: Container(
              decoration: BoxDecoration(
                  color: mobileBackgroundColor,
                  borderRadius: BorderRadius.circular(12)),
              margin: widthScreen > 600
                  ? EdgeInsets.symmetric(
                      vertical: 55, horizontal: widthScreen / 6)
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "A verification email has been sent to your email",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        canResendEmail ? sendVerificationEmail() : null;
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(mobileBackgroundColor),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: Text(
                        "Resent Email",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      // style: ButtonStyle(
                      //   backgroundColor: MaterialStateProperty.all(BTNpink),
                      //   padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8))),
                      // ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
