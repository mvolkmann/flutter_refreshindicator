import 'package:flutter/material.dart';
import './extensions/widget_extensions.dart';

const title = 'My App';

void main() => runApp(
      MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final itemsToLoad = [
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
  final itemsToShow = <String>[];
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    // Wait for the build method to complete and then
    // trigger a call to the onRefresh function of the RefreshIndicator
    // which causes the indicator to display.
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => keyRefresh.currentState?.show());
  }

  void addItem() {
    if (itemsToLoad.isNotEmpty) {
      itemsToShow.insert(0, itemsToLoad.removeAt(0));
    }
  }

  Future<void> loadItems() async {
    await Future.delayed(Duration(seconds: 5)); // simulates API call
    setState(() {
      // Items are added to the beginning of the list.
      // Another approach is to completely replace the list with new data.
      addItem();
      addItem();
      addItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
                itemCount: itemsToShow.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(title: Text(itemsToShow[index])),
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
