import 'package:flutter/material.dart';
import 'package:capywise/widgets/sidebar_widget.dart';
import 'package:capywise/core/base_page.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return BasePage(
      title: "Calendar",
      //middleContent: CalendarWidget(),
      //rightSidebar: RightUtilityBarWidget(),
    );
  }
}