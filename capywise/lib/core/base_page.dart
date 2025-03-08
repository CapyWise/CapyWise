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
/// ``'dart
/// BasePage(
///   title: "Dashboard",
///   middleContent: DashboardContentWidget(),
///   rightSidebar: NotificationsWidget(),
///   showRightSidebar: true, // Set to false to hide the right sidebar
/// )
/// 
/// ### More custom usage example:
/// class SettingsPage extends StatelessWidget {
///  @override
///  Widget build(BuildContext context) {
///    return BasePage(
///      title: "Settings",
///      middleContent: const SettingsContentWidget(), // Replace with actual content
///      rightSidebar: const FiltersWidget(), // Replace with actual sidebar widget
///    );
///  }
///}

/// ```
class BasePage extends StatelessWidget {
  /// The title displayed in the header.
  final String title;

  /// The main content displayed in the center of the page.
  final Widget middleContent;

  /// Optional widget for displaying a right sidebar (e.g., notifications, filters).
  final Widget? rightSidebar;

  /// Controls whether the right sidebar is visible.
  final bool showRightSidebar;

  /// Constructs a [BasePage] with required [title] and [middleContent].
  /// The [rightSidebar] is optional and can be hidden by setting [showRightSidebar] to false.
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
      backgroundColor: const Color.fromARGB(255, 250, 232, 232), // Light pink background
      body: Row(
        children: [
          /// **Left Sidebar (Navigation)**
          /// This remains consistent across all pages and contains navigation items.
          const SidebarWidget(),

          /// **Main Page Content**
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Header Section**
                /// Displays the page title, a dropdown menu, and action buttons.
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  color: const Color(0xFFFCE8E8), // Light pink header background
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// **Title & Dropdown**
                      /// Displays the page title and an optional dropdown for user selection.
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
                          /// You can customize this dropdown or replace it with another widget.
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
                              // Handle dropdown selection (Add logic here)
                            },
                            hint: const Text(
                              "Choose something",
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        ],
                      ),

                      /// **Action Buttons**
                      /// Customize these buttons based on page-specific actions.
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Define primary action here
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
                              // Define secondary action here
                            },
                            child: const Text("Default"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// **Main Content Section**
                /// Contains the middle content and an optional right sidebar.
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        /// **Primary Content Area**
                        /// The main content widget passed as a parameter.
                        Expanded(
                          flex: 3, // Takes 3x space relative to the right sidebar
                          child: middleContent,
                        ),

                        /// **Optional Right Sidebar**
                        /// If enabled, it displays additional widgets like notifications.
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