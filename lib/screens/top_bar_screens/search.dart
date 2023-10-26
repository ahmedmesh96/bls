import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bls/screens/bottom_button_srcreens/profile.dart';
import 'package:bls/shared/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final myController = TextEditingController();

  // @override
  // void initState() {

  //   super.initState();
  //   myController.addListener(ddddd);
  // }

  // ddddd() {
  //   setState(() {

  //   });
  // }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    return Container(
      // height: heightScreen,
      // width: widthScreen,
      decoration: const BoxDecoration(
        gradient: RadialGradient(colors: [
          Color.fromARGB(255, 38, 43, 116),
          Color.fromARGB(255, 14, 15, 34)
        ], radius: 0.7),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.white.withOpacity(0.1),
              title: SizedBox(
                height: 40,
                child: Center(
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                      // hintText: 'Search for a user...',
                      // helperText: 'write user name...',

                      labelText: 'Search for a user-name...',
                      // label: Text("gdhd"),
                    ),
                  ),
                ),
              )),
          body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('userSSS')
                .where("username", isEqualTo: myController.text)
                .get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.3)),
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(255, 14, 15, 34),
                                Color.fromARGB(255, 38, 43, 116),
                              ]),
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile(
                                            uiddd: snapshot.data!.docs[index]
                                                ["uid"],
                                          )));
                            },
                            title: Text(snapshot.data!.docs[index]["username"]),
                            leading: Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              child: CircleAvatar(
                                  radius: 33,
                                  backgroundImage: NetworkImage(
                                      snapshot.data!.docs[index]["profileImg"]
                                      // "https://dvyvvujm9h0uq.cloudfront.net/com/articles/1515135672-shutterstock_284581649.jpg"

                                      )),
                            ),
                          ),
                        ),
                      );
                    });
              }

              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            },
          ),
        ),
      ),
    );
  }
}
