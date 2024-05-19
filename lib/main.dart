// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final String username = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return HomePage(username: username);
            },
          );
        }
        return null;
      },
      routes: {
        '/page1': (context) => const Page1(),
        '/page2': (context) => const Page2(),
        '/page3': (context) => const Page3(),
      },
    );
  }
}

class SignInPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();


  SignInPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sign In to Your Apocalypse Tracker',
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _usernameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String username = _usernameController.text;
                    Navigator.pushReplacementNamed(
                      context,
                      '/home',
                      arguments: username,
                    );
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  final String username;


  const HomePage({super.key, required this.username});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome back to Your Apocalypse Tracker, $username',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'What would you like to do today?',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/page1');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: const Text(
                        'Motion Sensor',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/page2');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: const Text(
                        'Map',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/page3');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: const Text(
                        'Zombie Dex',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Page1 extends StatefulWidget {
  const Page1({super.key});




  @override
  _Page1State createState() => _Page1State();
}




class _Page1State extends State<Page1> {
  int _triggerCount = 0;
  String _lastTriggerTime = '';
  String _motionStatus = 'No motion detected';
  String _appMotionStatus = ''; // App's motion status




  @override
  void initState() {
    super.initState();
    _initCommunication();
  }




  void _initCommunication() {
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      // Simulate alternating between "Motion detected" and "No motion detected"
      setState(() {
        _motionStatus = _motionStatus == 'Motion detected' ? 'No motion detected' : 'Motion detected';
        _updateMotionStatus(_motionStatus);
      });
    });
  }




  void _updateMotionStatus(String motionStatus) {
    if (_appMotionStatus == 'No motion detected' && motionStatus == 'Motion detected') {
      setState(() {
        _triggerCount++;
        _lastTriggerTime = DateTime.now().toString();
      });
    }
    _appMotionStatus = motionStatus;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motion Sensor Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              // Perform sign out action
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Trigger Count: $_triggerCount'),
            const SizedBox(height: 10),
            Text('Last Trigger Time: $_lastTriggerTime'),
            const SizedBox(height: 10),
            Text('Motion Status: $_motionStatus'),
          ],
        ),
      ),
    );
  }
}


class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  _Page2State createState() => _Page2State();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking Map'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: const Center(child: Text('This is Page 2')),
    );
  }
}

class _Page2State extends State<Page2> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(43.644422, -79.401695);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
          elevation: 2,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.0,
          ),
        ),
      ),
    );
  }
}



class Page3 extends StatefulWidget {
  const Page3({super.key});


  @override
  _Page3State createState() => _Page3State();
}


class _Page3State extends State<Page3> {
  final List<bool> _isFlipped = List<bool>.generate(8, (index) => false);
  final List<String> _imagePaths = [
    'images/Aegyo Zombie.png',
    'images/Corporate Zombie.png',
    'images/Doctor Zombie.png',
    'images/OddOneOut Zombie.png',
    'images/Princess Zombie.png',
    'images/Locked Zombie.png',
    'images/Locked Zombie.png',
    'images/Locked Zombie.png',
  ];


  final List<String> _cardTexts = [
    'Combat rating: 8/10\nEat streak: 7\nStrength: Cutness overload\nWeakness: Large crowds',
    'Combat rating: 7/10\nEat streak: 5\nStrength: Night owl\nWeakness: Fuels off caffeine',
    'Combat rating: 9/10\nEat streak: 8\nStrength: Smart\nWeakness: Bad stamina',
    'Combat rating: 7/10\nEat streak: 5\nStrength: Sneaky\nWeakness: Emotional',
    'Combat rating: 6/10\nEat streak: 10\n Strenth: Pretty\nWeakness: Money',
    'You have not discovered this zombie species yet',
    'You have not discovered this zombie species yet',
    'You have not discovered this zombie species yet',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zombie Dex'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Back',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _imagePaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _isFlipped[index] = !_isFlipped[index];
              });
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 50),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return RotationTransition(
                  turns: child.key == const ValueKey('image')
                      ? Tween<double>(begin: 0, end: 1).animate(animation)
                      : Tween<double>(begin: 1, end: 0).animate(animation),
                  child: child,
                );
              },
              child: _isFlipped[index]
                  ? Container(
                      key: const ValueKey('text'),
                      color: const Color.fromARGB(255, 249, 252, 255),
                      alignment: Alignment.center,
                      child: Text(
                        _cardTexts[index],
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(
                      key: const ValueKey('image'),
                      color: const Color.fromARGB(255, 86, 115, 194),
                      alignment: Alignment.center,
                      child: Image.asset(
                        _imagePaths[index],
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}


