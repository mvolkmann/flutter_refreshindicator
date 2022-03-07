import 'package:flutter/material.dart';
import './extensions/widget_extensions.dart';

const title = 'My App';

void main() => runApp(
      MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final items = ['red', 'orange'];
  final moreItems = [
    'yellow',
    'green',
    'blue',
    'purple',
    'white',
    'gray',
    'black',
    'brown',
    'aqua',
    'teal',
    'amber',
    'turquoise',
    'peach',
  ];

  void addItem() {
    if (moreItems.isEmpty) return;
    setState(() {
      final item = moreItems.removeAt(0);
      items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Text('Pull to refresh.'),
          RefreshIndicator(
            onRefresh: () async {
              addItem();
              addItem();
            },
            //TODO: Fix ability to scroll when there are
            //TODO: more items than will fit on the screen.
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      items[index],
                    ),
                  ),
                );
              },
            ),
          ).expanded,
        ],
      ),
    );
  }
}
