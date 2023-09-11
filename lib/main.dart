import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
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

class CardData {
  final String code;
  final String imagePath;
  final Widget widget;

  CardData({
    required this.code,
    required this.imagePath,
    required this.widget,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Map<String, CardData> cardMap = {
    'AppBar': CardData(
      code: '''class MyAppBar extends StatelessWidget {
        const MyAppBar({Key? key}) : super(key: key);
        @override
          Widget build(BuildContext context) {
          return Scaffold(
              appBar: AppBar(
              title: const Text("AppBar"), // Set the title of the AppBar
          ),
            body: Center(child: const Text("An example of appbar")),
          );
        }
      }''',
      imagePath: 'assets/appbar.png',
      widget: const MyAppBar(),
    ),
    'Drawer': CardData(
      code: '''class MyDrawer extends StatelessWidget {
        const MyDrawer({Key? key}) : super(key: key);
      
        @override
        Widget build(BuildContext context) {
          return Scaffold(
              body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: const <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text('John Doe'), // Display user's name
                      accountEmail: Text('johndoe@example.com'), // Display user's email
                      currentAccountPicture: CircleAvatar(
                        // Display user's profile picture
                        backgroundImage: NetworkImage(
                          'https://example.com/profile.jpg',
                        ),
                      ),
                    ),
                    Divider(), // Add a divider below the header
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }''',
      imagePath: 'assets/drawer.png',
      widget: const MyDrawer(),
    ),
    'Radio Buttons': CardData(
      code: '''class MyRadio extends StatefulWidget {
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
              appBar: AppBar(
                title: const Text('Radio Button Demo'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
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
                    SizedBox(height: 20),
                    Text('Selected Option: (dollar_symbol)selectedOption),//replace dollar_symbol with actual dollar symbol
                  ],
                ),
              ),
            );
          }
        }''',
      imagePath: 'assets/radio.png',
      widget: const MyRadio(),
    ),
  };

  List<bool> isFavorite = [];
  String searchQuery = '';
  TextEditingController searchcontroller = TextEditingController();
  static const String favoriteCardsKey = 'favoriteCards';
  late SharedPreferences _prefs;

  List<String> getFavoriteCards() {
    //list to store the card names which are marked as favorite
    List<String> favoriteCards = [];

    for (int i = 0; i < cardMap.length; i++) {
      if (isFavorite[i]) {
        favoriteCards.add(cardMap.keys.toList()[i]);
      }
    }

    return favoriteCards;
  }

  List<String> getFilteredCards() {
    //filter the searched cards
    return cardMap.keys
        .where((cardName) =>
            cardName.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  // Load favorite cards from SharedPreferences
  void loadFavoriteCards() {
    final List<String>? savedFavoriteCards =
        _prefs.getStringList(favoriteCardsKey);

    if (savedFavoriteCards != null) {
      setState(() {
        for (int i = 0; i < cardMap.length; i++) {
          isFavorite[i] = savedFavoriteCards.contains(cardMap.keys.toList()[i]);
        }
      });
    }
  }

  void saveFavoriteCards() {
    final List<String> favoriteCards = getFavoriteCards();
    _prefs.setStringList(favoriteCardsKey, favoriteCards);
  }

  Widget getWidget(String key) {
    return cardMap[key]!.widget;
  }

  Widget getCode(String key) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(cardMap[key]!.code.toString()),
      ),
    );
  }

  String getImage(String key){
    return cardMap[key]!.imagePath;
  }

  @override
  void initState() {
    super.initState();
    isFavorite = List.generate(
      cardMap.length,
      (index) => false,
    );

    // Initialize SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      loadFavoriteCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7F6FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3199FA),
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  //navigation to the page here only card names chosen as favorite will be there
                  builder: (_) => FavoriteCardsPage(
                    favoriteCards: getFavoriteCards(),
                    callback: getWidget,
                    codeCallback: getCode,
                    imgCallback: getImage,
                  ),
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
              controller: searchcontroller,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF61B5F2),
                hintText: 'Search',
                contentPadding: const EdgeInsets.all(12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear, // Clear icon
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      searchcontroller.text = ''; //clear the text
                      searchQuery = '';
                      FocusScope.of(context).unfocus();
                    });
                  },
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Hide the keyboard when the search icon is tapped
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Visibility(
              visible: searchQuery.isEmpty, // Hide when there's a search query
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF63D0FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/home.svg',
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
                              const SizedBox(
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: getFilteredCards().isEmpty
                  ? const Center(
                      child: Text(
                        'No match found',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchQuery.isEmpty
                          ? cardMap.keys.length
                          : getFilteredCards().length,
                      itemBuilder: (context, index) {
                        final cardText = searchQuery.isEmpty
                            ? cardMap.keys.toList()[index]
                            : getFilteredCards()[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                //navigate to the page that contains the details
                                builder: (_) => DetailPage(
                                  appBarText: cardText,
                                  callback: getWidget,
                                  codeCallback: getCode,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: const Color(0xFF63D0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                                          isFavorite[index]
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isFavorite[index] =
                                                !isFavorite[index];
                                          });
                                          saveFavoriteCards();
                                        },
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    cardMap[cardText]!.imagePath,
                                  )
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
    searchcontroller.dispose();
    super.dispose();
  }
}

class DetailPage extends StatefulWidget {
  final String appBarText;
  final Widget Function(String) callback;
  final Widget Function(String) codeCallback;

  const DetailPage(
      {super.key,
      required this.appBarText,
      required this.callback,
      required this.codeCallback});

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isCode
            ? widget.codeCallback(widget.appBarText)
            : widget.callback(widget.appBarText),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(color: Colors.blue),
        unselectedLabelStyle:const TextStyle(color: Colors.grey),
        items:  [
          BottomNavigationBarItem(
              label: 'Results', icon: Icon(Icons.phone_android_rounded,color: isCode?Colors.grey:Colors.blue,)),
          BottomNavigationBarItem(label: 'Code', icon: Icon(Icons.code,color: !isCode?Colors.grey:Colors.blue,))
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

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('get drawer tapping on top left icon'),
      ),
      drawer: const MyDrawerView(),
    );
  }
}

class MyDrawerView extends StatelessWidget {
  const MyDrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text('John Doe'), // Display user's name
                accountEmail:
                    Text('johndoe@example.com'), // Display user's email
                currentAccountPicture: CircleAvatar(
                  // Display user's profile picture
                  backgroundImage: NetworkImage(
                    'https://example.com/profile.jpg',
                  ),
                ),
              ),
              const Divider(), // Add a divider below the header
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
