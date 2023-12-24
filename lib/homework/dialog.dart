import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LAWidget extends StatelessWidget {
const LAWidget({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return const MaterialApp(
home: LAlertWidget(),
);
}
}

class LAlertWidget extends StatelessWidget {
const LAlertWidget({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
//Function to Show SnackBar on dialog dismiss

void showSnackBar(String text, String ans) {
final SnackBar snackBar = SnackBar(
duration: const Duration(milliseconds: 500),
backgroundColor:
ans.compareTo('Yes') == 0 ? Colors.green : Colors.red,
content: Row(
children: <Widget>[
Icon(
ans.compareTo('Yes') == 0 ? Icons.favorite : Icons.watch_later,
color: ans.compareTo('Yes') == 0 ? Colors.pink : Colors.yellow,
size: 24.0,
semanticLabel: text,
),
Text(text)
],
));
ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Simple Dialog

Future<void> simpleDialog() async {
switch (await showDialog(
context: context,
builder: (BuildContext context) {
return SimpleDialog(
title: const Text('Simple Dialog, Is it nice?'),
children: <Widget>[
SimpleDialogOption(
onPressed: () {
Navigator.pop(context, 'Yes');
},
child: const Text('Yes'),
),
SimpleDialogOption(
onPressed: () {
Navigator.pop(context, 'No');
},
child: const Text('No'),
),
],
);
})) {
case 'Yes':
showSnackBar('Thanks!', 'Yes');
break;
case 'No':
showSnackBar('Oh! No... Try to provide you best', 'No');
break;
}
}

Future<void> alertDialog() async {
switch (await showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
content: const Text('Is it nice?'),
title: const Text('Alert Dialog'),
actions: <Widget>[
TextButton(
onPressed: () {
Navigator.pop(context, 'Yes');
},
child: const Text('Yes'),
),
TextButton(
onPressed: () {
Navigator.pop(context, 'No');
},
child: const Text('No'),
),
],
);
})) {
case 'Yes':
showSnackBar('Thanks!', 'Yes');
break;
case 'No':
showSnackBar('Oh! No... Try to provide you best', 'No');
break;
}
}

void timerDialog() {
final DateTime now = DateTime.now();
showTimePicker(
context: context,
initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
    .then((TimeOfDay? onValue) {
showSnackBar(onValue?.format(context) ?? '', 'ok');
});
}

void datePickerDialog() {
final DateTime now = DateTime.now();
showDatePicker(
context: context,
initialDate: now,
firstDate: DateTime(2000),
lastDate: DateTime(2050))
    .then((DateTime? onValue) {
showSnackBar('$onValue', 'ok');
});
}

Future<void> cupertinoDialog() async {

  switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Welcome'),
          content: const Text('Cupertino Dialog, Is it nice?'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, 'Yes');
              },
              child: const Text('Yes'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, 'No');
              },
              child: const Text('No'),
            ),
          ],
        );
      })) {
    case 'Yes':
      showSnackBar('Thanks!', 'Yes');
      break;
    case 'No':
      showSnackBar('Oh! No... Try to provide you best', 'No');
      break;
  }
}

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ElevatedButton(
          onPressed: simpleDialog,
          child: const Text('Simple Dialog'),
        ),
        ElevatedButton(
          onPressed: alertDialog,
          child: const Text('Alert Dialog'),
        ),
        ElevatedButton(
          onPressed: datePickerDialog,
          child: const Text('Date Picker Dialog'),
        ),
        ElevatedButton(
          onPressed: timerDialog,
          child: const Text('Timer Picker Dialog'),
        ),
        ElevatedButton(
          onPressed: cupertinoDialog,
          child: const Text('Cupertino Dialog'),
        )
      ],
    ),
  );
}
}