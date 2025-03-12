import 'package:flutter/material.dart';
import '../widgets/sidebar_widget.dart';

/// A reusable base layout for all pages in the app.
///
/// This layout consists of:
/// - A **left sidebar** for navigation.
/// - A **header** with a title, dropdown, and action buttons.
/// - A **main content area** in the center.
/// - An **optional right sidebar** for additional widgets.
///
/// ### Example Usage:
/// ```dart
/// // A page with both middle content and a right sidebar:
/// BasePage(
///   title: "Dashboard",
///   middleContent: DashboardContent(),
///   rightSidebar: NotificationsWidget(),
///   showRightSidebar: true, // Set to false to hide the sidebar
/// );
///
/// // A page that only needs the middle content:
/// BasePage(
///   title: "Exam Scheduler",
///   middleContent: ExamSchedulerContent(),
///   showRightSidebar: false, // Hide the sidebar entirely
/// );
/// ```
class BasePage extends StatelessWidget {
  /// The title displayed in the header.
  final String title;

  /// The main content displayed in the center of the page.
  final Widget middleContent;

  /// Optional widget for the right sidebar (e.g., notifications, filters).
  final Widget? rightSidebar;

  /// Whether to display the right sidebar.
  final bool showRightSidebar;

  /// Constructs a [BasePage] with:
  ///  - [title]: page title in the header
  ///  - [middleContent]: main widget in the center
  ///  - [rightSidebar]: optional widget on the right
  ///  - [showRightSidebar]: whether to show or hide the right sidebar
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
      // Light pink background
      backgroundColor: const Color.fromARGB(255, 250, 232, 232),
      body: Row(
        children: [
          /// --- Left Sidebar ---
          /// Always displayed for navigation.
          const SidebarWidget(),

          /// --- Main Content Area ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --- Header Section ---
                /// Displays a title, dropdown, and action buttons.
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  color: const Color(0xFFFCE8E8), // Light pink header background
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// **Title & Dropdown**
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

                          /// **Example Dropdown Menu**
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
                              // TODO: Handle dropdown selection
                            },
                            hint: const Text(
                              "Choose something",
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        ],
                      ),

                      /// **Action Buttons**
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Define primary action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 43, 10, 48),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Primary Action"),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: () {
                              // TODO: Define secondary action
                            },
                            child: const Text("Default"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// --- Main + Optional Right Sidebar ---
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        /// **Middle Content**
                        /// Takes up most of the horizontal space (3x).
                        Expanded(
                          flex: 3,
                          child: middleContent,
                        ),

                        /// **Right Sidebar**
                        /// Shown only if [showRightSidebar] is true AND [rightSidebar] is not null.
                        if (showRightSidebar && rightSidebar != null) ...[
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: rightSidebar!,
                          ),
                        ],
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
