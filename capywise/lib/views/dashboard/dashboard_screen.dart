import 'package:flutter/material.dart';
import '../../core/base_page.dart';
import '../../core/expandable_card.dart'; // Or rename to compact_expandable_card if you prefer

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Dashboard',
      // Tighter scrolling area
      middleContent: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            // Card #1
            ExpandableCard(
              dayLabel: "TODAY",
              timeLabel: "All day",
              eventTitle: "TIRADENTES",
              isChecked: true,
              backgroundColor: const Color(0xFFD9F7BE),
              expandedDetails: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "All day, Sunday, January 8",
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(Icons.person, size: 18),
                      SizedBox(width: 4),
                      Text("ROUTINE", style: TextStyle(fontSize: 13)),
                      SizedBox(width: 10),
                      Icon(Icons.remove, size: 18),
                      SizedBox(width: 4),
                      Text("BUSY", style: TextStyle(fontSize: 13)),
                      Spacer(),
                      Icon(Icons.edit, size: 18),
                      SizedBox(width: 6),
                      Icon(Icons.delete, size: 18),
                      SizedBox(width: 6),
                      Icon(Icons.email, size: 18),
                      SizedBox(width: 6),
                      Icon(Icons.more_vert, size: 18),
                    ],
                  ),
                ],
              ),
            ),

            // Card #2
            ExpandableCard(
              dayLabel: "10 JAN, TUE",
              timeLabel: "3PM - 6PM",
              eventTitle: "GREAT ALTERNATIVE",
              tag: "ASTR132",
              backgroundColor: const Color(0xFFFFF4E1),
              expandedDetails: const Text(
                "3PM - 6PM, Tuesday, January 10",
                style: TextStyle(fontSize: 13),
              ),
            ),

            // Card #3
            ExpandableCard(
              dayLabel: "11 JAN, WED",
              timeLabel: "9AM - 11AM",
              eventTitle: "SHOOTING STARS",
              backgroundColor: const Color(0xFFFDD3F8),
              expandedDetails: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "9AM - 11AM, Wednesday, January 11",
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(Icons.person, size: 18),
                      SizedBox(width: 4),
                      Text("OPTIONAL STATUS", style: TextStyle(fontSize: 13)),
                      Spacer(),
                      Icon(Icons.edit, size: 18),
                      SizedBox(width: 6),
                      Icon(Icons.delete, size: 18),
                    ],
                  ),
                ],
              ),
            ),

            // ... Repeat for other events ...
          ],
        ),
      ),
      // Right sidebar is optional
      rightSidebar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Center(
          child: Text("Right sidebar content"),
        ),
      ),
      showRightSidebar: true,
    );
  }
}
