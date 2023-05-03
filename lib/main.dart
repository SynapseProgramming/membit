import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:membit/deckscreen.dart';
import 'package:membit/isardb.dart';
import 'package:membit/homescreen.dart';
import 'package:membit/router.dart';
import 'package:membit/router.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DbAccess(
      dbinstance: IsarDb(),
      child: MaterialApp.router(
        title: 'Membit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: _appRouter.config(),
      ),
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

@RoutePage()
class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final String title = "membit";

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [HomeRoute(), DeckRouterRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Decks'),
          ],
        );
      },
    );
  }
}
