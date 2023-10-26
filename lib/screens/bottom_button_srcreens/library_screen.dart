import 'package:flutter/material.dart';
import 'package:bls/bars/top_bar.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: heightScreen,
        width: widthScreen,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 38, 43, 116),
            Color.fromARGB(255, 14, 15, 34)
          ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const TopIconsBar(),
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    // color: Colors.red,
                    width: widthScreen,
                    height: heightScreen * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: widthScreen * 0.1,
                            child: const FittedBox(
                                child: Text(
                              "Live",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ))),
                        SizedBox(
                            width: widthScreen * 0.5,
                            child: const FittedBox(
                                child: Text(
                              "Don't miss our live classes",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 0, 255, 229)),
                            ))),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.network(
                                      "https://play-lh.googleusercontent.com/OLHlI1s-qAmZfMJKylQMxKbf_n60zyvQX82Db1FBtuHgSe82hr5U15srd3Wq9etcOa4=w526-h296-rw",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: heightScreen * 0.3,
                                    child: const FittedBox(
                                        child: Text(
                                      "Kung Fu Online Class",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMDab2xolruv_cQJJLUAqtEuHMvy2F9dTyRg&usqp=CAU",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: heightScreen * 0.3,
                                    child: const FittedBox(
                                        child: Text(
                                      "Fitness Online Class",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbhy4B6e6ZPLAKIU6HKCOssCrIevutG3TKuA&usqp=CAU",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      width: heightScreen * 0.3,
                                      child: const FittedBox(
                                          child: Text(
                                        "Tai Chi Online Class",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )))
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    child: Image.network(
                                      "https://yogapractice.com/wp-content/uploads/2021/01/Meditation-Certification-10-Reasons-to-Become-a-Meditation-Teacher.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      width: heightScreen * 0.3,
                                      child: const FittedBox(
                                          child: Text(
                                        "Meditation Online Class",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )))
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  //_______________________________________________________________

                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    // color: Colors.red,
                    width: widthScreen,
                    // height: heightScreen * 0.35,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: widthScreen * 0.3,
                            child: const FittedBox(
                                child: Text(
                              "Your Library",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ))),
                        SizedBox(
                            width: widthScreen * 0.5,
                            child: const FittedBox(
                                child: Text(
                              "Classes you have purchased",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 0, 255, 229)),
                            ))),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    // child: Image.network("https://play-lh.googleusercontent.com/OLHlI1s-qAmZfMJKylQMxKbf_n60zyvQX82Db1FBtuHgSe82hr5U15srd3Wq9etcOa4=w526-h296-rw", fit: BoxFit.cover,),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: heightScreen * 0.3,
                                    child: const Text(
                                      "Matrial arts is the antidote to all the poison in your life",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),

                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    // child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMDab2xolruv_cQJJLUAqtEuHMvy2F9dTyRg&usqp=CAU", fit: BoxFit.cover,),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: heightScreen * 0.3,
                                    child: const FittedBox(
                                        child: Text(
                                      "Qigong on the nature",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbhy4B6e6ZPLAKIU6HKCOssCrIevutG3TKuA&usqp=CAU",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      width: heightScreen * 0.3,
                                      child: const FittedBox(
                                          child: Text(
                                        "Tai Chi Online Class",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )))
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    child: Image.network(
                                      "https://yogapractice.com/wp-content/uploads/2021/01/Meditation-Certification-10-Reasons-to-Become-a-Meditation-Teacher.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      width: heightScreen * 0.3,
                                      child: const FittedBox(
                                          child: Text(
                                        "Meditation Online Class",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )))
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  //_______________________________________________________

                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    // color: Colors.red,
                    width: widthScreen,
                    // height: heightScreen * 0.35,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: widthScreen * 0.3,
                            child: const FittedBox(
                                child: Text(
                              "Your Library",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ))),
                        SizedBox(
                            width: widthScreen * 0.5,
                            child: const FittedBox(
                                child: Text(
                              "Classes you have purchased",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 0, 255, 229)),
                            ))),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    // child: Image.network("https://play-lh.googleusercontent.com/OLHlI1s-qAmZfMJKylQMxKbf_n60zyvQX82Db1FBtuHgSe82hr5U15srd3Wq9etcOa4=w526-h296-rw", fit: BoxFit.cover,),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: heightScreen * 0.3,
                                    child: const Text(
                                      "Matrial arts is the antidote to all the poison in your life",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),

                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    // child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMDab2xolruv_cQJJLUAqtEuHMvy2F9dTyRg&usqp=CAU", fit: BoxFit.cover,),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: heightScreen * 0.3,
                                    child: const FittedBox(
                                        child: Text(
                                      "Qigong on the nature",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbhy4B6e6ZPLAKIU6HKCOssCrIevutG3TKuA&usqp=CAU",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      width: heightScreen * 0.3,
                                      child: const FittedBox(
                                          child: Text(
                                        "Tai Chi Online Class",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )))
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    height: heightScreen * 0.2,
                                    width: heightScreen * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amberAccent),
                                    child: Image.network(
                                      "https://yogapractice.com/wp-content/uploads/2021/01/Meditation-Certification-10-Reasons-to-Become-a-Meditation-Teacher.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      width: heightScreen * 0.3,
                                      child: const FittedBox(
                                          child: Text(
                                        "Meditation Online Class",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )))
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // FollowersScreen(uiddd: FirebaseAuth.instance.currentUser!.uid,),
      // FollowingScreen(uiddd: FirebaseAuth.instance.currentUser!.uid,),
    );
  }
}
