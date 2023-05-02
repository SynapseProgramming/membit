import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:membit/deckscreen.dart';
import 'package:membit/isardb.dart';
import 'package:membit/homescreen.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      selectedindex = index;
    });
    print(selectedindex);
  }

  final List<Widget> pages = [
    HomeScreen(),
    DeckScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: IndexedStack(
        index: selectedindex,
        children: pages,
      )),
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

  // @override
  // Widget build(BuildContext context) {

  // return AutoTabsScaffold(routes: [

  // ],);
}
