import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(
        duration: 3, //duration of splash screen
        navigateAfterDuration:
            HomePage(), //screen to display after splash screen
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final int duration;
  final Widget navigateAfterDuration;

  const SplashScreen({
    Key? key,
    required this.duration,
    required this.navigateAfterDuration,
  }) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.duration), () {
      //set timer for splash screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => widget.navigateAfterDuration,
        ),
      );
    });
    _controller = AnimationController(
      //animate the text
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 0.0), // Slide from left to right
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully opaque
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5793ED),
      body: SafeArea(
        child: Center(
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SvgPicture.asset(
                'assets/entryPage.svg',
                width: 250,
                height: 300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> cardNames = [
    'Card 0',
    'Card 1',
    'Card 2',
    // Add more card names as needed
  ];

  List<bool> isFavorite = [];

  List<String> getFavoriteCards() {
    List<String> favoriteCards = [];

    for (int i = 0; i < cardNames.length; i++) {
      if (isFavorite[i]) {
        favoriteCards.add(cardNames[i]);
      }
    }

    return favoriteCards;
  }

  @override
  void initState() {
    super.initState();
    isFavorite = List.generate(
      cardNames.length,
      (index) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7F6FD),
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF3199FA), // Set background color to #3199FA
        title: const Text('Home'), // Set title text to "Home"
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      FavoriteCardsPage(favoriteCards: getFavoriteCards()),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF61B5F2), // Set background color to #61B5F2
                hintText: 'Search',
                contentPadding: EdgeInsets.all(12.0),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Set corner radius to 20
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(
                  Icons.search, // Use the search icon as the suffix icon
                  color: Colors.black, // Icon color
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFF63D0FF), // Set background color to #63D0FF
                borderRadius:
                    BorderRadius.circular(10), // Set corner radius to 10
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/home.svg', // Replace with your SVG image path
                        width: 200,
                        height: 180,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'LEARN',
                                  textStyle: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  speed: const Duration(milliseconds: 200),
                                ),
                              ],
                              totalRepeatCount: 1,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      'FLUTTER',
                                      textStyle: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      speed: const Duration(milliseconds: 200),
                                    ),
                                  ],
                                  totalRepeatCount: 1,
                                ),
                              ],
                            ),
                          ]),
                    ]),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cardNames
                    .length, // Change this to the number of cards you want
                itemBuilder: (context, index) {
                  final cardText = cardNames[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailPage(appBarText: cardText),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '$cardText',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isFavorite[index]
                                    ? Icons.favorite
                                    : Icons.favorite_border, // Heart icon
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isFavorite[index]) {
                                    isFavorite[index] = !isFavorite[index];
                                  } else {
                                    isFavorite[index] = !isFavorite[index];
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class DetailPage extends StatelessWidget {
  final String appBarText;

  DetailPage({required this.appBarText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7F6FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3199FA),
        title: Text(appBarText), // Set the app bar title based on the card text
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite, // Example icon
              size: 100,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              'This is the detail page for $appBarText',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteCardsPage extends StatelessWidget {
  final List<String> favoriteCards;

  FavoriteCardsPage({required this.favoriteCards});

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
                  builder: (_) => DetailPage(appBarText: cardText),
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
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$cardText',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
