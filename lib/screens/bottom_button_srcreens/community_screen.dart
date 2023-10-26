import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:bls/bars/top_bar.dart';

import '../../shared/post_design.dart';
import '../../widget/story_scroll_view.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        // color: mobileBackgroundColor,
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 38, 43, 116),
          Color.fromARGB(255, 13, 14, 31)
        ], begin: Alignment.topCenter),
      ),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: widthScreen > 600
                        ? widthScreen * 0.2
                        : widthScreen * 0.35,
                    child: const FittedBox(child: TopIconsBar())),
                const StoryScrollView(),
                Divider(
                  color: Colors.redAccent.withAlpha(100),
                  thickness: 1,
                ),
                Expanded(
                  child: SizedBox(
                    // color: Colors.amber,

                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('postSSS')
                          .orderBy("datePublished", descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          ));
                        }

                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return PostDesign(
                              data: data,
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}
