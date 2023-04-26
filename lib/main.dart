import 'package:flutter/material.dart';
import 'package:membit/maindeck.dart';
import 'package:membit/isardb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DbAccess(
      dbinstance: IsarDb(),
      child: MaterialApp(
          title: 'Membit',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Membit')),
    );
  }
}

class DbAccess extends InheritedWidget {
  const DbAccess({super.key, required this.dbinstance, required super.child});

  final IsarDb dbinstance;

  static DbAccess? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DbAccess>();
  }

  static DbAccess of(BuildContext context) {
    final DbAccess? res = maybeOf(context);
    assert(res != null, 'no isarDB instance found');
    return res!;
  }

  @override
  bool updateShouldNotify(DbAccess oldWidget) => true;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedindex = 0;

  final db = IsarDb();

  void _onItemTapped(int index) {
    setState(() {
      selectedindex = index;
    });
    print(selectedindex);
  }

  final List<Widget> pages = [
    Container(
        child: Text(
      "hello dudes!",
      maxLines: 2,
    )),
    Maindeck(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[selectedindex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Decks'),
        ],
        currentIndex: selectedindex,
        onTap: _onItemTapped,
      ),
    );
  }
}
