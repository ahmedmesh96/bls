import 'package:flutter/material.dart';
import 'package:bls/responsive/mobile.dart';
import 'package:bls/responsive/web.dart';

import '../../responsive/responsive.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({super.key});

  @override
  State<WellnessScreen> createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  int selectedIndex = 0;
  bool isShowKungFu = false;
  bool isShowYoga = false;
  bool isShowAyurveda = false;
  bool isAlternative = false;

  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    final double widthScreen = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {
      //         setState(() {
      //           Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const Responsive(
      //                   myMobileScreen: MobileScreen(),
      //                   myWebScreen: WebScreen(),
      //                 ),
      //               ));
      //         });
      //       },
      //       icon: const Icon(Icons.arrow_back_ios)),
      //   title: SizedBox(
      //       width: widthScreen > 600 ? widthScreen * 0.4 : widthScreen * 0.7,
      //       child: const FittedBox(
      //           child: Text(
      //         "CHOOSE YOUR PATH",
      //         style: TextStyle(fontWeight: FontWeight.bold),
      //       ))),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      // extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isShowKungFu = !isShowKungFu;
                });
              },
              child: Column(children: [
                SizedBox(
                    width: widthScreen * 0.96,
                    child: FittedBox(
                        child: Image.asset("assets/img/Kung Fu@3x.png"))),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          "Kung Fu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        )),
                    const Expanded(
                      child: Text(
                        "Matrial arts that are practiced especially for self-defense, exercise, and spirtual",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ]),
            ),
            isShowKungFu
                ? SizedBox(
                    width: widthScreen * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ShaolinScreen()));
                              });
                            },
                            child: Container(
                              width: widthScreen * 0.2,
                              height: widthScreen * 0.2,
                              margin: const EdgeInsets.all(5),
                              child: Image.asset("assets/img/shaolin@3x.png"),
                            )),
                        Container(
                          width: widthScreen * 0.2,
                          height: widthScreen * 0.2,
                          margin: const EdgeInsets.all(5),
                          child: Image.asset("assets/img/Taichi@3x.png"),
                        ),
                        Container(
                          width: widthScreen * 0.2,
                          height: widthScreen * 0.2,
                          margin: const EdgeInsets.all(5),
                          child: Image.asset("assets/img/sanda@3x.png"),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            InkWell(
              onTap: () {
                setState(() {
                  isShowYoga = !isShowYoga;
                });
              },
              child: Column(children: [
                SizedBox(
                    width: widthScreen * 0.96,
                    child:
                        FittedBox(child: Image.asset("assets/img/Yoga.png"))),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          "Yoga",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        )),
                    const Expanded(
                      child: Text(
                        "Seek and you shall find, whatever your heart desires, it starts with a simple question.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ]),
            ),
            isShowYoga
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: widthScreen * 0.2,
                          height: widthScreen * 0.2,
                          margin: const EdgeInsets.all(5),
                          child: Image.asset("assets/img/breathe@3x.png"),
                        ),
                        Container(
                          width: widthScreen * 0.2,
                          height: widthScreen * 0.2,
                          margin: const EdgeInsets.all(5),
                          child:
                              Image.asset("assets/img/meditaion kriya@3x.png"),
                        ),
                        Container(
                          width: widthScreen * 0.2,
                          height: widthScreen * 0.2,
                          margin: const EdgeInsets.all(5),
                          child: Image.asset("assets/img/philosoph@3x.png"),
                        ),
                        Container(
                          width: widthScreen * 0.2,
                          height: widthScreen * 0.2,
                          margin: const EdgeInsets.all(5),
                          child: Image.asset("assets/img/step by step@3x.png"),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            InkWell(
              onTap: () {
                setState(() {
                  isShowAyurveda = !isShowAyurveda;
                });
              },
              child: Column(children: [
                SizedBox(
                    width: widthScreen * 0.96,
                    child: FittedBox(
                        child: Image.asset("assets/img/ayurvede@3x.png"))),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          "Ayurveda",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        )),
                    const Expanded(
                      child: Text(
                        "Ayruveda is a healthy eating system originationg from india whit a history...",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ]),
            ),
            isShowAyurveda
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          color: Colors.amberAccent,
                          width: widthScreen * 0.9,
                          height: widthScreen * 0.2,
                          child: const Center(
                              child: Text(
                            "Coming Soon",
                            style: TextStyle(fontSize: 45, color: Colors.teal),
                          )),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            InkWell(
              onTap: () {
                setState(() {
                  isAlternative = !isAlternative;
                });
              },
              child: Column(children: [
                SizedBox(
                    width: widthScreen * 0.96,
                    child: FittedBox(
                        child: Image.asset("assets/img/alternative@3x.png"))),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          "Alternative",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        )),
                    const Expanded(
                      child: Text(
                        "...",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ]),
            ),
            isAlternative
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.amberAccent,
                          width: widthScreen * 0.9,
                          height: widthScreen * 0.2,
                          child: const Center(
                              child: Text(
                            "Coming Soon",
                            style: TextStyle(fontSize: 45, color: Colors.teal),
                          )),
                        ),
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

//_______________________________________________________

class ShaolinScreen extends StatefulWidget {
  const ShaolinScreen({super.key});

  @override
  State<ShaolinScreen> createState() => _ShaolinScreenState();
}

class _ShaolinScreenState extends State<ShaolinScreen> {
  int selectedIndex = 0;
  bool isShowShaolinHistory = false;
  bool isShowShaolinBasics = false;
  bool isShowShaolinCombinations = false;
  bool isShowShaolinForms = false;

  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    final double widthScreen = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Responsive(
                          myMobileScreen: MobileScreen(),
                          myWebScreen: WebScreen(),
                        ),
                      ));
                });
              },
              icon: const Icon(Icons.home_outlined))
        ],
        title: SizedBox(
            width: widthScreen * 0.7,
            child: const FittedBox(
                child: Text(
              "Choose an shaolin",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
              extendBodyBehindAppBar: true,
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isShowShaolinHistory = !isShowShaolinHistory;
                        });
                      },
                      child: Column(children: [
                        SizedBox(
                            width: widthScreen * 0.96,
                            child: FittedBox(
                                child: Image.asset(
                                    "assets/img/shaolin-history@3x.png"))),
                        Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(10),
                                child: const Text(
                                  "Shaolin History",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )),
                            // const Expanded(

                            //   child:  Text(

                            //     "Matrial arts that are practiced especially for self-defense, exercise, and spirtual", maxLines: 2 , overflow: TextOverflow.ellipsis,),
                            // )
                          ],
                        ),
                      ]),
                    ),
                    isShowShaolinHistory
                        ? SizedBox(
                            width: widthScreen * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: widthScreen * 0.2,
                                  height: widthScreen * 0.2,
                                  margin: const EdgeInsets.all(5),
                                  child:
                                      Image.asset("assets/img/shaolin@3x.png"),
                                ),
                                Container(
                                  width: widthScreen * 0.2,
                                  height: widthScreen * 0.2,
                                  margin: const EdgeInsets.all(5),
                                  child:
                                      Image.asset("assets/img/Taichi@3x.png"),
                                ),
                                Container(
                                  width: widthScreen * 0.2,
                                  height: widthScreen * 0.2,
                                  margin: const EdgeInsets.all(5),
                                  child: Image.asset("assets/img/sanda@3x.png"),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isShowShaolinBasics = !isShowShaolinBasics;
                        });
                      },
                      child: Column(children: [
                        SizedBox(
                            width: widthScreen * 0.96,
                            child: FittedBox(
                                child: Image.asset(
                                    "assets/img/shaolin-basic@3x.png"))),
                        Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(10),
                                child: const Text(
                                  "Shaolin Basics",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )),
                            // const Expanded(

                            //   child: Text(

                            //     "Seek and you shall find, whatever your heart desires, it starts with a simple question.", maxLines: 2 , overflow: TextOverflow.ellipsis,),
                            // )
                          ],
                        ),
                      ]),
                    ),
                    isShowShaolinBasics
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: widthScreen * 0.2,
                                  height: widthScreen * 0.2,
                                  margin: const EdgeInsets.all(5),
                                  child:
                                      Image.asset("assets/img/breathe@3x.png"),
                                ),
                                Container(
                                  width: widthScreen * 0.2,
                                  height: widthScreen * 0.2,
                                  margin: const EdgeInsets.all(5),
                                  child: Image.asset(
                                      "assets/img/meditaion kriya@3x.png"),
                                ),
                                Container(
                                  width: widthScreen * 0.2,
                                  height: widthScreen * 0.2,
                                  margin: const EdgeInsets.all(5),
                                  child: Image.asset(
                                      "assets/img/philosoph@3x.png"),
                                ),
                                Container(
                                  width: widthScreen * 0.2,
                                  height: widthScreen * 0.2,
                                  margin: const EdgeInsets.all(5),
                                  child: Image.asset(
                                      "assets/img/step by step@3x.png"),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isShowShaolinCombinations =
                              !isShowShaolinCombinations;
                        });
                      },
                      child: Column(children: [
                        SizedBox(
                            width: widthScreen * 0.96,
                            child: FittedBox(
                                child: Image.asset(
                                    "assets/img/shaolin-combinations@3x.png"))),
                        Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(10),
                                child: const Text(
                                  "Shaolin Combinations",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )),
                            // const Expanded(

                            //   child: Text(

                            //     "Ayruveda is a healthy eating system originationg from india whit a history...", maxLines: 2 , overflow: TextOverflow.ellipsis,),
                            // )
                          ],
                        ),
                      ]),
                    ),
                    isShowShaolinCombinations
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  color: Colors.amberAccent,
                                  width: widthScreen * 0.9,
                                  height: widthScreen * 0.2,
                                  child: const Center(
                                      child: Text(
                                    "Coming Soon",
                                    style: TextStyle(
                                        fontSize: 45, color: Colors.teal),
                                  )),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isShowShaolinForms = !isShowShaolinForms;
                        });
                      },
                      child: Column(children: [
                        SizedBox(
                            width: widthScreen * 0.96,
                            child: FittedBox(
                                child: Image.asset(
                                    "assets/img/shaolin-form@3x.png"))),
                        Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(10),
                                child: const Text(
                                  "Shaolin Forms",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )),
                            const Expanded(
                              child: Text(
                                "...",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ]),
                    ),
                    isShowShaolinForms
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.amberAccent,
                                  width: widthScreen * 0.9,
                                  height: widthScreen * 0.2,
                                  child: const Center(
                                      child: Text(
                                    "Coming Soon",
                                    style: TextStyle(
                                        fontSize: 45, color: Colors.teal),
                                  )),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
