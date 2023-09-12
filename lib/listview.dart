import 'package:flutter/material.dart';

void main() {
  runApp(const CardListScreen());
}


class CardListScreen extends StatelessWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const <Widget>[
          CardItem(
            title: 'Card 1',
            description: 'This is the first card.',
          ),
          CardItem(
            title: 'Card 2',
            description: 'This is the second card.',
          ),
          CardItem(
            title: 'Card 3',
            description: 'This is the third card.',
          ),
          // Add more CardItems as needed
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String description;

  const CardItem({super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0, // Card elevation
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18.0)),
        subtitle: Text(description),
        // You can add more content here, like images, buttons, etc.
      ),
    );
  }
}
