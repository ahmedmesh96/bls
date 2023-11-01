import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bls/firbase_services/auth.dart';
import 'package:bls/screens/login_register_screens/register.dart';
import '../../shared/contants.dart';
import '../../shared/snack_bar.dart';
import 'forgot_passowrd.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  signIn() async {
    setState(() {
      isLoading = true;
    });

    await AuthMethods().signIn(
        emailll: emailController.text,
        passworddd: passwordController.text,
        context: context);

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;
    showSnackBar(context, "successfully sign-in ");
  }

  //* google sign in *///

  // Future<UserCredential?> _signInWithGoogle() async {
  //   try {
  //     await InternetAddress.lookup('google.com');
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     // log('\n_signInWithGoogle: $e');
  //     showSnackBar(context, "ERROR : 'Something Went Wrong (Check Internet!) ");

  //     return null;
  //   }
  // }

  // _handleGoogleBtnClick() {
  //   //for showing progress bar
  //   Dialogs.showProgressBar(context);

  //   _signInWithGoogle().then((user) async {
  //     //for hiding progress bar
  //     Navigator.pop(context);

  //     if (user != null) {
  //       // log('\nUser: ${user.user}');
  //       // log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

  //       if ((await APIs.userExists())) {
  //         Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (_) => HomeScreen(
  //                       uiddd: FirebaseAuth.instance.currentUser!.uid,
  //                     )));
  //       } else {
  //         await APIs.createUser().then((value) {
  //           Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (_) => HomeScreen(
  //                         uiddd: FirebaseAuth.instance.currentUser!.uid,
  //                       )));
  //         });
  //       }
  //     }
  //   });
  // }
//***************************************** */

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    // final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Container(
      height: heightScreen,
      width: widthScreen,
      decoration: const BoxDecoration(
        gradient: RadialGradient(colors: [
          Color.fromARGB(255, 38, 43, 116),
          Color.fromARGB(255, 14, 15, 34)
        ], radius: 0.7),
      ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Sign in"),
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: widthScreen > 600
                ? EdgeInsets.symmetric(
                    vertical: 55, horizontal: widthScreen / 6)
                : null,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(33.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 64,
                      ),
                      TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your Email : ",
                              suffixIcon: const Icon(Icons.email))),
                      const SizedBox(
                        height: 33,
                      ),
                      TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: isVisable ? false : true,
                          decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your Password : ",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisable = !isVisable;
                                    });
                                  },
                                  icon: isVisable
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)))),
                      const SizedBox(
                        height: 33,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          signIn();
                        },
                        style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all(BTNgreen),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Sign in",
                                style: TextStyle(fontSize: 19),
                              ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Do not have an account?",
                              style: TextStyle(fontSize: 18)),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Register()),
                                );
                              },
                              child: const Text('sign up',
                                  style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline))),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPassword()),
                            );
                          },
                          child: const Text(
                            "forget password?",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          )),
                      const SizedBox(
                        width: 299,
                        child: Row(
                          children: [
                            Expanded(
                                child: Divider(
                              thickness: 0.6,
                            )),
                            Text(
                              "OR",
                              style: TextStyle(),
                            ),
                            Expanded(
                                child: Divider(
                              thickness: 0.6,
                            )),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 27),
                        child: GestureDetector(
                          onTap: () {
                            // googleSignInProvider.googlelogin();
                            // _handleGoogleBtnClick();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    // color: Colors.purple,
                                    color:
                                        const Color.fromARGB(255, 200, 67, 79),
                                    width: 1)),
                            child: SvgPicture.asset(
                              "assets/icons/google.svg",
                              color: const Color.fromARGB(255, 255, 28, 28),
                              // color: Color.fromARGB(255, 200, 67, 79),
                              height: 27,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            )),
          )),
    );
  }
}
