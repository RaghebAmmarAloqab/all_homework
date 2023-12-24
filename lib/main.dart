import 'package:flutter/material.dart';

import 'homework/calculatore.dart';
import 'homework/dialog.dart';
import 'homework/image_picker.dart';
import 'homework/lab11.dart';
import 'homework/login_page.dart';
import 'homework/navbar.dart';
import 'homework/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/pageSelector': (context) => const PageSelectorExample(),
        '/imagePicker': (context) => const ImagePickerExample(),
        '/laWidget': (context) => const LAWidget(),
        '/bottomNavBar': (context) => const BottomNavigationBarExample(),
        '/calculator': (context) => const Calculatore(),
        '/login': (context) => const LoginPage(),
        '/lab11': (context) =>  const StudentRegistrationUI(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getlisttile(String txt, IconData icon, String txt2) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        txt,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        Navigator.of(context).pushNamed(txt2);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Main Screen Home Work",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Column(
        children: <Widget>[
          Center(
            child: Text("Welcome to my Home work "),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          children: <Widget>[
            getlisttile('Calculator', Icons.calculate, '/calculator'),
            getlisttile('Login Page', Icons.login, '/login'),
            getlisttile('Image Packer', Icons.image, '/imagePicker'),
            getlisttile('NavBar Page', Icons.navigation_sharp, '/bottomNavBar'),
            getlisttile(
                'Selector Page ', Icons.pages, '/pageSelector'),
            getlisttile('Dialog Page', Icons.info, '/laWidget'),
            getlisttile('Lecture 11 Page', Icons.info, '/lab11'),
          ],
        ),
      ),
    );
  }
}

