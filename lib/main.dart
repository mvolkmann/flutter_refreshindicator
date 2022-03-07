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
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final items = <String>[];
  final moreItems = [
    'red',
    'orange',
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

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0)).then((_) {
      // This triggers a call on the RefreshIndicator onRefresh function.
      keyRefresh.currentState?.show();
    });
  }

  void addItem() {
    if (moreItems.isNotEmpty) items.insert(0, moreItems.removeAt(0));
  }

  Future<void> loadItems() async {
    await Future.delayed(Duration(seconds: 1)); // simulates API call
    setState(() {
      // In this implementation we add items to the beginning of the list.
      // Another approach is to completely replace the list with new data.
      addItem();
      addItem();
      addItem();
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
          // This can only be used with a vertical scroll view
          RefreshIndicator(
            key: keyRefresh,
            // This function updates the scrollable contents,
            // in this case the items in a ListView.
            // The refresh indicator disappears when
            // the promise returned by this function completes.
            onRefresh: loadItems,
            child: Scrollbar(
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
            ),
          ).expanded,
        ],
      ),
    );
  }
}
