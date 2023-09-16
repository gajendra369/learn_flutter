import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String appBarText;
  final Widget Function(String) callback;
  final Widget Function(String) codeCallback;
  final VoidCallback saveFavoriteCards;
  final List<String> favorites;

  const DetailPage({
    super.key,
    required this.appBarText,
    required this.callback,
    required this.codeCallback,
    required this.saveFavoriteCards,
    required this.favorites,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isCode = false;


  final int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7F6FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3199FA),
        title: Text(
            widget.appBarText), // Set the app bar title based on the card text
        actions: [
          IconButton(
            icon: Icon(
              widget.favorites.contains(widget.appBarText)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              setState(() {
                widget.favorites.contains(widget.appBarText)
                    ? widget.favorites.remove(widget.appBarText)
                    : widget.favorites.add(widget.appBarText);
                widget.saveFavoriteCards();
              });

            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isCode
            ? widget.codeCallback(widget.appBarText)
            : widget.callback(widget.appBarText),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(color: Colors.blue),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        items: [
          BottomNavigationBarItem(
              label: 'Results',
              icon: Icon(
                Icons.phone_android_rounded,
                color: isCode ? Colors.grey : Colors.blue,
              )),
          BottomNavigationBarItem(
              label: 'Code',
              icon: Icon(
                Icons.code,
                color: !isCode ? Colors.grey : Colors.blue,
              ))
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            isCode = (index != 0);
          });
        },
      ),
    );
  }
}
