import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget getContainer(String txt, String txt1, IconData icond) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 3),
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
      //      border: Border.all(color: Colors.black, width: 1.0)),
      child: TextField(
        obscureText: true, // Added for password field
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 2, color: Colors.black),
          ),
          // icon:  Icon(icond),
          labelText: txt,
          labelStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          hintText: txt1,
          hintStyle: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        leading: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.more_vert,
              size: 30,
            ),
            Icon(Icons.fullscreen_sharp, size: 25),
          ],
        ),
        // flexibleSpace: ,
        title: const Text(
          'Login design',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Expanded( flex: 2,
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(top: 120, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white70,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.pink,
                size: 50,
              ),
            ),
            const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                // alignment: ,
                padding: const EdgeInsets.only(top: 60),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),

                // height: 300,
                child: Column(
                  children: [
                    getContainer(
                        'E-mail', 'Enter your Email', Icons.alternate_email),
                    const SizedBox(height: 10),
                    getContainer('Password', 'Enter your password', Icons.lock),
                    const SizedBox(height: 100),
                    FloatingActionButton(
                      onPressed: () {
                        // AboutDialog(applicationIcon: Icon(Icons.ice_skating),);
                      },backgroundColor: Colors.pink,
                      child: const Icon(
                        Icons.keyboard_backspace,textDirection: TextDirection.rtl,
                        color: Colors.white,
                        size: 50,
                        weight: 10,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
