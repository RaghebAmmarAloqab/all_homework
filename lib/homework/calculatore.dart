import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class Calculatore extends StatefulWidget {
  const Calculatore({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatoreState createState() => _CalculatoreState();
}

class _CalculatoreState extends State<Calculatore> {
  String userInput = '';
  String answer = '';

  final List<String> btnText = [
    '1',
    '2',
    '3',
    '/',
    '4',
    '5',
    '6',
    '*',
    '7',
    '8',
    '9',
    '-',
    '.',
    '0',
    '00',
    '+',
    'Clear',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.more_vert),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text(
          "Calculator",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  userInput,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  answer,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: btnText.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 4,
                crossAxisSpacing: 7,
                childAspectRatio: 1,
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    if (btnText[index] == 'Clear') {
                      setState(() {
                        userInput = '';
                        answer = '';
                      });
                    } else if (btnText[index] == '=') {
                      Expression exp = Parser().parse(userInput);
                      double result =
                      exp.evaluate(EvaluationType.REAL, ContextModel());
                      setState(() {
                        answer = result.toString();
                      });
                    } else if (btnText[index] == '*' ||
                        btnText[index] == '/' ||
                        btnText[index] == '+' ||
                        btnText[index] == '.' ||
                        btnText[index] == '-') {
                      if (userInput.endsWith('*') ||
                          userInput.endsWith('/') ||
                          userInput.endsWith('+') ||
                          userInput.endsWith('.') ||
                          userInput.endsWith('-')) {
                      } else {
                        setState(() {
                          userInput += btnText[index];
                        });
                      }
                    } else {
                      setState(() {
                        userInput += btnText[index];
                      });
                    }
                  },
                  child: Text(
                    btnText[index],
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}