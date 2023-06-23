import 'package:auto_route/auto_route.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
    );
  }
}
