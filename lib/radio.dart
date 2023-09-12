import 'package:flutter/material.dart';

class MyRadio extends StatefulWidget {
  const MyRadio({Key? key}) : super(key: key);

  @override
  MyRadioState createState() => MyRadioState();
}

class MyRadioState extends State<MyRadio> {
  String? selectedOption = 'Option 1';

  void handleRadioValueChanged(String? value) {
    setState(() {
      selectedOption = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Select an option:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              title: const Text('Option 1'),
              value: 'Option 1',
              groupValue: selectedOption,
              onChanged: handleRadioValueChanged,
            ),
            RadioListTile(
              title: const Text('Option 2'),
              value: 'Option 2',
              groupValue: selectedOption,
              onChanged: handleRadioValueChanged,
            ),
            RadioListTile(
              title: const Text('Option 3'),
              value: 'Option 3',
              groupValue: selectedOption,
              onChanged: handleRadioValueChanged,
            ),
            const SizedBox(height: 20),
            Text('Selected Option: $selectedOption'),
          ],
        ),
      ),
    );
  }
}