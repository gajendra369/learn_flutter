// ignore_for_file: deprecated_member_use
import 'package:flutter/foundation.dart';
import 'package:learn_flutter/listview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_flutter/appbar.dart';
import 'package:learn_flutter/drawer.dart';
import 'package:learn_flutter/radio.dart';
import 'package:learn_flutter/splashscreen.dart';
import 'package:learn_flutter/detailpage.dart';
import 'package:learn_flutter/scrollview.dart';
import 'package:learn_flutter/favoritepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(
        duration: 3, //duration of splash screen
        navigateAfterDuration:
            HomePage(), //screen to display after splash screen
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
    "Single Child Scrollview": CardData(
      code: '''
          import 'package:flutter/material.dart';
          
          class MyScrollView extends StatelessWidget {
            const MyScrollView({super.key,});
          
            @override
            Widget build(BuildContext context) {
              return  Scaffold(
              body: SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  for (int i = 0; i < 15; i++) // Replace 10 with the number of items you want
                      Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                          'Item dollar-i',
                        style: const TextStyle(fontSize: 18),
                      ),
                  ),
            ],
          ),
        ),
      ),
    );
            }
          }

      ''',
      imagePath: 'assets/scrollview.png',
      widget: const MyScrollView(),
    ),
    "ListView": CardData(
      code: '''
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

      ''',
      imagePath: 'assets/listview.png',
      widget: const CardListScreen(),
    )
  };

  List<String> favorites= [];
  String searchQuery = '';
  TextEditingController searchcontroller = TextEditingController();
  ScrollController scroll=ScrollController();
  static const String favoriteCardsKey = 'favoriteCards';
  late SharedPreferences _prefs;
  bool isSearch=false,scrolled=false;
  final String contactEmail = 'myextest36@gmail.com';


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
    if(savedFavoriteCards!=null) {
      favorites=savedFavoriteCards;
    }

  }

  void saveFavoriteCards() {
    _prefs.setStringList(favoriteCardsKey, favorites);
    setState(() {
      loadFavoriteCards();
    });
  }

  Widget getWidget(String key) {
    return cardMap[key]!.widget;
  }

  Widget getCode(String key) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5),
        child:
            SingleChildScrollView(child: Text(cardMap[key]!.code.toString())),
      ),
    );
  }

  String getImage(String key) {
    return cardMap[key]!.imagePath;
  }

  @override
  void initState() {
    super.initState();
    // Initialize SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      loadFavoriteCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFD7F6FD),
        appBar: AppBar(
          backgroundColor: const Color(0xFF3199FA),
          title: isSearch? TextField(
            controller: searchcontroller,
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              hintText: 'Search',
              contentPadding: const EdgeInsets.all(12.0),
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.clear, // Clear icon
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    searchcontroller.text = ''; //clear the text
                    searchQuery = '';
                    FocusScope.of(context).unfocus();
                    setState(() {
                      isSearch=!isSearch;
                    });
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
          )
          :const Text("HOME"),
          actions: <Widget>[
            Visibility(
              visible: !isSearch,
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: (){
                  setState(() {
                    isSearch=!isSearch;
                  });
                }
              ),
            ),
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
                      favorites: favorites,
                      callback: getWidget,
                      codeCallback: getCode,
                      imgCallback: getImage,
                      saveFavoriteCards: saveFavoriteCards,
                    ),
                  ),
                );
              },
            ),
          ],

        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text("GAJENDRA"),
                accountEmail: Text("gajendra@gmail.com"),
              ),
              // ListTile for the "Contact" item
              ListTile(
                leading: const Icon(Icons.contact_mail), // You can change the icon
                title: const Text('Contact'),
                onTap: () {

                  String? encodeQueryParameters(Map<String, String> params) {
                    return params.entries
                        .map((MapEntry<String, String> e) =>
                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join('&');
                  }
// ···
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: contactEmail,
                    query: encodeQueryParameters(<String, String>{
                      'subject': 'Feedback',
                    }),
                  );
                  try {
                    launchUrl(emailLaunchUri);
                  }catch(e){
                    if (kDebugMode) {
                      print(e.toString());
                    }
                  }

                },
              ),
            ],
          ),
        ),
        body:NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            // Calculate the scroll offset to determine whether to hide the container
            final scrollOffset = notification.metrics.pixels;
            final shouldHideContainer = scrollOffset > 0; // You can adjust this condition as needed

            // Update the visibility of the container
            if (scrolled != shouldHideContainer) {
              setState(() {
                scrolled = shouldHideContainer;
              });
            }

            return false;
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: searchQuery.isEmpty&&!scrolled, // Hide when there's a search query
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
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                              'LEARN',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    'FLUTTER',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                      saveFavoriteCards: saveFavoriteCards,
                                      favorites:favorites,
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
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                cardText,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              favorites.contains(cardText)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                favorites.contains(cardText)?favorites.remove(cardText):favorites.add(cardText);
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
