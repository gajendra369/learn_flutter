import 'package:flutter/material.dart';

class MyScrollView extends StatelessWidget {
  const MyScrollView({super.key,});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: 200,
        width: 700,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Border color
            width: 2.0, // Border width
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)), // Optional: Rounded corners
        ),
        child: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text("text-1"),
                SizedBox(height: 20),
                Text("text-2"),
                SizedBox(height: 20),
                Text("text-3"),
                SizedBox(height: 20),
                Text("text-4"),
                SizedBox(height: 20),
                Text("text-5"),
                SizedBox(height: 20),
                Text("text-6"),
                SizedBox(height: 20),
                Text("text-7"),
                SizedBox(height: 20),
                Text("text-8"),
                SizedBox(height: 20),
                Text("text-9"),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
