import 'package:flutter/material.dart';
import 'package:learn_flutter/detailpage.dart';

class FavoriteCardsPage extends StatefulWidget {
  final List<String> favorites;
  final Widget Function(String) callback;
  final Widget Function(String) codeCallback;
  final String Function(String) imgCallback;
  final VoidCallback saveFavoriteCards;

  const FavoriteCardsPage(
      {super.key,
      required this.favorites,
      required this.callback,
      required this.codeCallback,
      required this.imgCallback,
      required this.saveFavoriteCards,
      });

  @override
  State<FavoriteCardsPage> createState() => _FavoriteCardsPageState();
}

class _FavoriteCardsPageState extends State<FavoriteCardsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7F6FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3199FA),
        title: const Text('Favorite Cards'),
      ),
      body: widget.favorites.isEmpty
          ? const Center(
              child: Text("No favorite elements found"),
            )
          : ListView.builder(
              itemCount: widget.favorites.length,
              itemBuilder: (context, index) {
                final String cardText = widget.favorites[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          appBarText: cardText,
                          callback: widget.callback,
                          codeCallback: widget.codeCallback,
                          saveFavoriteCards: widget.saveFavoriteCards,
                          favorites: widget.favorites,
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
                              IconButton(
                                icon: Icon(
                                  widget.favorites.contains(cardText)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.favorites.contains(cardText)
                                        ? widget.favorites.remove(cardText)
                                        : widget.favorites.add(cardText);
                                    widget.saveFavoriteCards();
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Image.asset(widget.imgCallback(cardText))
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
