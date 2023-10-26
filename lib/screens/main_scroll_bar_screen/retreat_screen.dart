import 'package:flutter/material.dart';

class RetreatScreen extends StatefulWidget {
  const RetreatScreen({super.key});

  @override
  State<RetreatScreen> createState() => _RetreatScreenState();
}

class _RetreatScreenState extends State<RetreatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text("Retreat Screen"),
      ),
    );
  }
}
