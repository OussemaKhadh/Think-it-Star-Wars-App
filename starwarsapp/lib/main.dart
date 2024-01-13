import 'dart:async';
import 'swapi_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   
    _navigateToMainScreen();
  }

  Future<void> _navigateToMainScreen() async {
    // Simulate a delay of 5 seconds
    await Future.delayed(const Duration(seconds: 5));

    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Image.asset(
                  'assets/star_wars_logo.png', 
                  height: 150.0,
                  width: 150.0,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.0, 
            left: 0.0,
            right: 0.0,
            child: Image.asset(
              'assets/company_logo.png', 
              height: 50.0,
              width: 150.0,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SwapiService swapiService = SwapiService();
  List<Map<String, dynamic>> films = [];

  @override
  void initState() {
    super.initState();
    _loadFilms();
  }

  Future<void> _loadFilms() async {
    try {
      final List<Map<String, dynamic>> fetchedFilms = await swapiService.getFilms();
      setState(() {
        films = fetchedFilms;
      });
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Think-it Star Wars',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 220.0,
          color: const Color(0xFF161615),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/star_wars_logo.png',
                  height: 150.0,
                  width: 150.0,
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      'Total 6 Films',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: films.length,
            itemBuilder: (context, index) {
              final film = films[index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top:Radius.circular(20),
                      )
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppBar(
                              title: Text(
                                film['title'],
                                style: const TextStyle(color: Colors.black),
                              ),
                              backgroundColor: Colors.white,
                              leading: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              centerTitle: true,
                            ),
                            Container(
                              height: 220.0,
                              color: const Color(0xFF161615),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      color: const Color(0xFF161615),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [const SizedBox(height: 40.0),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  film['title'].replaceAll('The Empire Strikes Back','The Empire Strikes\nBack').replaceAll('The Phantom Menace','The Phantom\nMenace'),
                                                  softWrap: true,
                                                  overflow: TextOverflow.fade,
                                                  style: const TextStyle(
                                                    color: Color(0xFFF9F9F9),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40.0,
                                                  ),
                                                ),
                                                
                                              ],
                                            ),
                                            const SizedBox(height: 17.0),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                        'Release date',
                                        style: TextStyle(
                                          color: Color(0xFFF9F9F9),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11.0,
                                        ),
                                      ),
                                      Text(film['release_date'],style: const TextStyle(
                                          color: Color(0xFFF9F9F9),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                        )
                                                  ],
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Director',
                                                      softWrap: true,
                                                      style: TextStyle(
                                                        color: Color(0xFFF9F9F9),
                                                        fontSize: 11.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      film['director'],
                                                      style: const TextStyle(
                                                        color: Color(0xFFF9F9F9),
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 10.0),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Producer',
                                                      style: TextStyle(
                                                        color: Color(0xFFF9F9F9),
                                                        fontSize: 11.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                      Text(
                                                      film['producer'].replaceAll('Howard G. Kazanjian, George Lucas, Rick McCallum','Howard G. Kazanjian\nGeorge Lucas\nRick McCallum'),
                                                      style: TextStyle(
                                                        color: Color(0xFFF9F9F9),
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                
                                              ],
                                            ),
                                            const SizedBox(height: 10.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color:  Colors.white,
                              height: 540,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                                  'Opening crawl',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13.0,
                                                  ),
                                                ),
                                          const SizedBox(height: 8.0),


                                    Text(
                                                  film['opening_crawl'].replaceAll('\n',''),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                SizedBox(height: 12.0),
                                    Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                        'Created',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11.0,
                                        ),
                                      ),
                                      Text(film['created'].substring(0,10),style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                        )
                                                  ],
                                                  ),const SizedBox(width: 10.0),
                                                  Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                        'Edited',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11.0,
                                        ),
                                      ),
                                      Text(film['edited'].substring(0,10),style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                        )

                                              ]
                                    ),
                                  ]
                                  )
                                  ]
                                  )
                            )
                            )
                          ],
                        ),
                      );
                    },
                  );

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Container(
                    height: 136.0,
                    color: const Color(0xFF161615),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            color: const Color(0xFF161615),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        film['title'],
                                        style: const TextStyle(
                                          color: Color(0xFFF9F9F9),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0,
                                        ),
                                      ),
                                      Text(
                                        'release date:\n ${film['release_date']}',
                                        style: const TextStyle(
                                          color: Color(0xFFF9F9F9),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Director',
                                            style: TextStyle(
                                              color: Color(0xFFF9F9F9),
                                              fontSize: 8.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            film['director'],
                                            style: const TextStyle(
                                              color: Color(0xFFF9F9F9),
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 5.0),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Producer',
                                            style: TextStyle(
                                              color: Color(0xFFF9F9F9),
                                              fontSize: 8.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            film['producer'],
                                            style: const TextStyle(
                                              color: Color(0xFFF9F9F9),
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        film['opening_crawl'].replaceAll('\n', ''),
                                        style: const TextStyle(
                                          color: Color(0xFFF9F9F9),
                                          fontSize: 12.0,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}}