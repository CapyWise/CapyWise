import 'package:flutter/material.dart';
import '../widgets/sidebar_widget.dart';

/// A reusable base layout for all pages in the app.
/// 
/// This layout consists of:
/// - A **left sidebar** for navigation.
/// - A **header** with a title, customizable action buttons, and a bottom bar for additional widgets.
/// - A **main content area** in the center.
/// - An **optional right sidebar** for additional widgets.
///
/// ### Example Usage:
/// ```dart
/// BasePage(
///   title: "Dashboard",
///   middleContent: DashboardContentWidget(),
///   rightSidebar: NotificationsWidget(),
///   showRightSidebar: true, // Set to false to hide the right sidebar
/// )
/// ```
///
/// ### More custom usage example:
/// ```dart
/// class SettingsPage extends StatelessWidget
/// {
///  @override
///  Widget build(BuildContext context)
///  {
///    return BasePage(
///      title: "Settings",
///      middleContent: const SettingsContentWidget(), // Replace with actual content
///      rightSidebar: const FiltersWidget(), // Replace with actual sidebar widget
///      actionButtons: [
///        ElevatedButton(
///          onPressed: () {},
///          child: const Text("Save"),
///        ),
///        OutlinedButton(
///          onPressed: () {},
///          child: const Text("Cancel"),
///        ),
///      ],
///      bottomHeaderBar: [
///        DropdownButton<String>(
///          items: const [
///            DropdownMenuItem(value: "Profile", child: Text("Profile Settings")),
///            DropdownMenuItem(value: "Privacy", child: Text("Privacy Settings")),
///          ],
///          onChanged: (String? value) {},
///          hint: const Text("Choose a setting"),
///        ),
///      ],
///    );
///  }
/// }
/// ```
class BasePage extends StatelessWidget
{
  /// The title displayed in the header.
  final String title;

  /// The main content displayed in the center of the page.
  final Widget middleContent;

  /// Optional widget for displaying a right sidebar (e.g., notifications, filters).
  final Widget? rightSidebar;

  /// Controls whether the right sidebar is visible.
  final bool showRightSidebar;

  /// **Action Buttons Area** (Top-right section of the header).
  /// This can include any widgets such as buttons, icons, or dropdown menus.
  final List<Widget>? actionButtons;

  /// **Bottom Header Bar** (Below the title).
  /// This can include additional buttons, filters, dropdowns, or any widget.
  final List<Widget>? bottomHeaderBar;

  /// Constructs a [BasePage] with customizable action buttons and bottom header bar.
  const BasePage({
    super.key,
    required this.title,
    required this.middleContent,
    this.rightSidebar,
    this.showRightSidebar = true,
    this.actionButtons,
    this.bottomHeaderBar,
  });

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 232, 232), // Light pink background
      body: Row(
        children: [
          /// **Left Sidebar (Navigation)**
          const SidebarWidget(),

          /// **Main Page Content**
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Header Section**
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  color: const Color(0xFFFCE8E8), // Light pink header background
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// **Title & Action Buttons**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// **Title Section**
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),

                          /// **Action Buttons Area (Top Right)**
                          if (actionButtons != null && actionButtons!.isNotEmpty)
                          Row(
                            children: actionButtons!,
                          )
                        ],
                      ),

                      /// **Bottom Header Bar**
                      if (bottomHeaderBar != null && bottomHeaderBar!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: bottomHeaderBar!,
                        ),
                      )
                    ],
                  ),
                ),

                /// **Main Content Section**
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        /// **Primary Content Area**
                        Expanded(
                          flex: 3,
                          child: middleContent,
                        ),

                        /// **Optional Right Sidebar**
                        if (showRightSidebar && rightSidebar != null)
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: rightSidebar!,
                        ),
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
