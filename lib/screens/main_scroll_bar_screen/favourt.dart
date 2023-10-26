import 'package:flutter/material.dart';

class FavourtScreen extends StatefulWidget {
  const FavourtScreen({super.key});

  @override
  State<FavourtScreen> createState() => _FavourtScreenState();
}

class _FavourtScreenState extends State<FavourtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: Text("Favours Screen")),
    );
  }
}
