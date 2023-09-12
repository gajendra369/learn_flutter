import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppBar"), // Set the title of the AppBar
      ),
      body: const Center(child: Text("An example of appbar")),
    );
  }
}