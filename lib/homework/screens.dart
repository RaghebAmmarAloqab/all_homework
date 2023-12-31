import 'package:flutter/material.dart';

class PageSelectorExample extends StatefulWidget {
  const PageSelectorExample({super.key});

  static const kIcons = <Icon>[
    Icon(Icons.event),
    Icon(Icons.home),
    Icon(Icons.android),
    Icon(Icons.alarm),
    Icon(Icons.face),
    Icon(Icons.language),
  ];

  @override
  State<PageSelectorExample> createState() => _PageSelectorExampleState();
}
class _PageSelectorExampleState extends State<PageSelectorExample> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: PageSelectorExample.kIcons.length,
      // Use a Builder here, otherwise DefaultTabController.of(context) below
      // returns null.
      child: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const TabPageSelector(),
              Expanded(
                child: IconTheme(
                  data: IconThemeData(
                    size: 128.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: const TabBarView(children: PageSelectorExample.kIcons),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final TabController controller =
                  DefaultTabController.of(context);
                  if (!controller.indexIsChanging) {
                    controller.animateTo(PageSelectorExample.kIcons.length - 1);
                  }
                },
                child: const Text('SKIP'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// مثال على التنقل بين الصفحات