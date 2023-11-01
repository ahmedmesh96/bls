// // // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

// //Packages
// import 'package:bls/chat/chat_service/cloud_storage_service.dart';
// import 'package:bls/chat/chat_service/database_service.dart';
// import 'package:bls/chat/chat_service/media_service.dart';
// import 'package:bls/chat/chat_service/navigation_service.dart';
// import 'package:bls/chat/chat_provider/auth_provider.dart';
// import 'package:bls/widget/widgets_chat/custom_input_fields.dart';
// import 'package:bls/widget/widgets_chat/rounded_button.dart';
// import 'package:bls/widget/widgets_chat/rounded_image.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:get_it/get_it.dart';
// import 'package:provider/provider.dart';

// //Services

// //Widgets

// //Providers

// class RegisterPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _RegisterPageState();
//   }
// }

// class _RegisterPageState extends State<RegisterPage> {
//   late double _deviceHeight;
//   late double _deviceWidth;

//   late AuthenticationProvider _auth;
//   late DatabaseService _db;
//   late CloudStorageService _cloudStorage;
//   late NavigationService _navigation;

//   String? _email;
//   String? _password;
//   String? _name;
//   String? _username;
//   String? _title;

//   PlatformFile? _profileImage;

//   final _registerFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     _auth = Provider.of<AuthenticationProvider>(context);
//     _db = GetIt.instance.get<DatabaseService>();
//     _cloudStorage = GetIt.instance.get<CloudStorageService>();
//     _navigation = GetIt.instance.get<NavigationService>();
//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidth = MediaQuery.of(context).size.width;
//     return _buildUI();
//   }

//   Widget _buildUI() {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: _deviceWidth * 0.03,
//           vertical: _deviceHeight * 0.02,
//         ),
//         height: _deviceHeight * 0.98,
//         width: _deviceWidth * 0.97,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             _profileImageField(),
//             SizedBox(
//               height: _deviceHeight * 0.05,
//             ),
//             _registerForm(),
//             SizedBox(
//               height: _deviceHeight * 0.05,
//             ),
//             _registerButton(),
//             SizedBox(
//               height: _deviceHeight * 0.02,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _profileImageField() {
//     return GestureDetector(
//       onTap: () {
//         GetIt.instance.get<MediaService>().pickImageFromLibrary().then(
//           (_file) {
//             setState(
//               () {
//                 _profileImage = _file;
//               },
//             );
//           },
//         );
//       },
//       child: () {
//         if (_profileImage != null) {
//           return RoundedImageFile(
//             key: UniqueKey(),
//             image: _profileImage!,
//             size: _deviceHeight * 0.15,
//           );
//         } else {
//           return RoundedImageNetwork(
//             key: UniqueKey(),
//             imagePath: "https://i.pravatar.cc/150?img=65",
//             size: _deviceHeight * 0.15,
//           );
//         }
//       }(),
//     );
//   }

//   Widget _registerForm() {
//     return Container(
//       height: _deviceHeight * 0.35,
//       child: Form(
//         key: _registerFormKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CustomTextFormField(
//                 onSaved: (_value) {
//                   setState(() {
//                     _name = _value;
//                   });
//                 },
//                 regEx: r'.{8,}',
//                 hintText: "Name",
//                 obscureText: false),
//             CustomTextFormField(
//                 onSaved: (value) {
//                   setState(() {
//                     _username = value;
//                   });
//                 },
//                 regEx: r'.{8,}',
//                 hintText: "User Name",
//                 obscureText: false),
//             CustomTextFormField(
//                 onSaved: (_value) {
//                   setState(() {
//                     _title = _value;
//                   });
//                 },
//                 regEx: r'.{8,}',
//                 hintText: "Title",
//                 obscureText: false),
//             CustomTextFormField(
//                 onSaved: (_value) {
//                   setState(() {
//                     _email = _value;
//                   });
//                 },
//                 regEx:
//                     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
//                 hintText: "Email",
//                 obscureText: false),
//             CustomTextFormField(
//                 onSaved: (_value) {
//                   setState(() {
//                     _password = _value;
//                   });
//                 },
//                 regEx: r".{8,}",
//                 hintText: "Password",
//                 obscureText: true),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _registerButton() {
//     return RoundedButton(
//       name: "Register",
//       height: _deviceHeight * 0.065,
//       width: _deviceWidth * 0.65,
//       onPressed: () async {
//         if (_registerFormKey.currentState!.validate() &&
//             _profileImage != null) {
//           _registerFormKey.currentState!.save();
//           String? _uid = await _auth.registerUserUsingEmailAndPassword(
//               _email!, _password!);
//           String? _profileImg =
//               await _cloudStorage.saveUserImageToStorage(_uid!, _profileImage!);
//           await _db.createUser(_uid, _email!, _name!, _profileImg!, _username!,
//               _title!, _password!);
//           await _auth.logout();
//           await _auth.loginUsingEmailAndPassword(_email!, _password!);
//         }
//       },
//     );
//   }
// }

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
        // lastActive: null,
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
