// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bls/firbase_services/auth.dart';
import 'package:bls/responsive/responsive.dart';
import 'package:bls/screens/login_register_screens/sign_in.dart';
import 'package:bls/shared/colors.dart';

import 'package:path/path.dart' show basename;

import '../../responsive/mobile.dart';
import '../../responsive/web.dart';
import '../../shared/contants.dart';
import '../../shared/snack_bar.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isVisable = true;
  Uint8List? imgPath;
  String? imgName;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  final nameController = TextEditingController();

  bool isPassword8Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  uploadImage2Screen(ImageSource source) async {
    Navigator.pop(context);

    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          // imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  clickOnRegister() async {
    if (_formKey.currentState!.validate() &&
        imgName != null &&
        imgPath != null) {
      setState(() {
        isLoading = true;
      });
      await AuthMethods().register(
        emailll: emailController.text,
        passworddd: passwordController.text,
        context: context,
        titleee: titleController.text,
        usernameee: usernameController.text,
        imgName: imgName,
        imgPath: imgPath,
        nameee: nameController.text,
      );
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Responsive(
                  myMobileScreen: MobileScreen(),
                  myWebScreen: WebScreen(),
                )),
      );
    } else {
      showSnackBar(context, "ERROR");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    usernameController.dispose();
    ageController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

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

          title: Text("Register"),
          centerTitle: true,
          // elevation: 1,

          // backgroundColor: appbarGreen,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          margin: widthScreen > 600
              ? EdgeInsets.symmetric(vertical: 55, horizontal: widthScreen / 6)
              : null,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(33.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 90, 197, 255),
                        ),
                        child: Stack(
                          children: [
                            imgPath == null
                                ? CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 244, 244, 244),
                                    radius: 71,
                                    // backgroundImage: AssetImage("assets/img/avatar.png"),
                                    backgroundImage:
                                        AssetImage("assets/img/avatar.png"),
                                  )
                                : CircleAvatar(
                                    radius: 71,
                                    // backgroundImage: AssetImage("assets/img/avatar.png"),
                                    backgroundImage: MemoryImage(imgPath!),
                                  ),
                            Positioned(
                              left: 99,
                              bottom: -10,
                              child: IconButton(
                                onPressed: () {
                                  // uploadImage2Screen();
                                  showmodel();
                                },
                                icon: const Icon(Icons.add_a_photo_outlined),
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 33,
                      ),

                      TextFormField(
                          validator: (value) {
                            return value!.isEmpty ? "Can Not be empty" : null;
                          },
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your name : ",
                              suffixIcon: Icon(Icons.person))),
                      const SizedBox(
                        height: 22,
                      ),

                      TextFormField(
                          validator: (value) {
                            return value!.isEmpty ? "Can Not be empty" : null;
                          },
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your username : ",
                              suffixIcon: Icon(Icons.person))),
                      const SizedBox(
                        height: 22,
                      ),
                      //
                      TextFormField(
                          validator: (value) {
                            return value!.isEmpty ? "Can Not be empty" : null;
                          },
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your title : ",
                              suffixIcon: Icon(Icons.person_outline))),
                      const SizedBox(
                        height: 22,
                      ),
                      TextFormField(
                          // we return "null" when something is valid
                          validator: (email) {
                            return email!.contains(RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                                ? null
                                : "Enter a valid email";
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your Email : ",
                              suffixIcon: Icon(Icons.email))),
                      const SizedBox(
                        height: 22,
                      ),
                      TextFormField(
                          onChanged: (password) {},
                          // we return "null" when something is valid
                          validator: (value) {
                            return value!.length < 6
                                ? "Enter at least 6 characters"
                                : null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: isVisable ? true : false,
                          decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your Password : ",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisable = !isVisable;
                                    });
                                  },
                                  icon: isVisable
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off)))),
                      const SizedBox(
                        height: 15,
                      ),

                      ElevatedButton(
                        onPressed: () async {
                          clickOnRegister();
                        },
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Register",
                                style: TextStyle(fontSize: 19),
                              ),
                        style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all(BTNgreen),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(12)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do not have an account?",
                              style: TextStyle(fontSize: 18)),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              child: Text('sign in',
                                  style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
