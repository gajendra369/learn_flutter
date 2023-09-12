
import 'package:flutter/material.dart';
import 'package:learn_flutter/detailpage.dart';

class FavoriteCardsPage extends StatelessWidget {
  final List<String> favoriteCards;
  final Widget Function(String) callback;
  final Widget Function(String) codeCallback;
  final String Function(String) imgCallback;

  const FavoriteCardsPage(
      {super.key,
        required this.favoriteCards,
        required this.callback,
        required this.codeCallback,
        required this.imgCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7F6FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3199FA),
        title: const Text('Favorite Cards'),
      ),
      body: ListView.builder(
        itemCount: favoriteCards.length,
        itemBuilder: (context, index) {
          final String cardText = favoriteCards[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    appBarText: cardText,
                    callback: callback,
                    codeCallback: codeCallback,
                  ),
                ),
              );
            },
            child: Card(
              color: const Color(0xFF63D0FF), // Card background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            cardText,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Image.asset(
                        imgCallback(cardText)
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}