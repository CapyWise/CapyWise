
import 'package:flutter/material.dart';
import '../widgets/sidebar_widget.dart';

/// BasePage is a reusable layout widget that provides a structured UI
/// with a sidebar, a header, and a configurable middle and right sidebar content.
///
/// Usage:
/// - For pages that need both middle content and right sidebar (e.g., Dashboard, Calendar):
///   ```dart
///   BasePage(
///     title: "Dashboard",
///     middleContent: DashboardContent(),
///     rightSidebar: DashboardSidebar(),
///     showRightSidebar: true,
///   );
///   ```
///
/// - For pages that only need the middle content (e.g., Exam Scheduler, Reminders):
///   ```dart
///   BasePage(
///     title: "Exam Scheduler",
///     middleContent: ExamSchedulerContent(),
///     showRightSidebar: false,
///   );
///   ```
class BasePage extends StatelessWidget {
  final String title; // The title displayed in the header
  final Widget middleContent; // The main content displayed in the middle section
  final Widget? rightSidebar; // Optional widget for the right sidebar content
  final bool showRightSidebar; // Controls whether the right sidebar is displayed

  const BasePage({
    super.key,
    required this.title,
    required this.middleContent,
    this.rightSidebar,
    this.showRightSidebar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 232, 232), // Background color of the page
      body: Row(
        children: [
          const SidebarWidget(), // Permanent sidebar navigation menu
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section containing the title and action buttons
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  color: const Color(0xFFFCE8E8), // Light pink header background
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 5),
                          DropdownButton<String>(
                            items: const [
                              DropdownMenuItem(
                                value: "Option 1",
                                child: Text("Option 1"),
                              ),
                              DropdownMenuItem(
                                value: "Option 2",
                                child: Text("Option 2"),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              // Handle dropdown selection
                            },
                            hint: const Text(
                              "Choose something",
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        ],
                      ),
                      // Action buttons on the right side of the header
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 43, 10, 48),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Primary Action"),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text("Default"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Main content area with an optional right sidebar
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3, // Main content takes 3x space relative to sidebar
                          child: middleContent,
                        ),
                        if (showRightSidebar && rightSidebar != null) ...[
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1, // Right sidebar takes 1x space
                            child: rightSidebar!,
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
