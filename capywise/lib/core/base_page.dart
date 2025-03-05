import 'package:flutter/material.dart';
import '../widgets/sidebar_widget.dart';

/// A base layout class with a sidebar and top area.
/// Child classes (e.g., Dashboard) override [buildMainArea] to show their own content.
class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 232, 232),
      body: Row(
        children: [
          // LEFT SIDEBAR
          const SidebarWidget(),

          // MAIN COLUMN (Top bar + center content)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TOP BAR
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  color: const Color(0xFFFCE8E8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Example Title + Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Title",
                            style: TextStyle(
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

                      // Example Buttons
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

                // MAIN AREA (child classes override here)
                Expanded(
                  child: buildMainArea(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Override this method in child classes to display your custom content.
  @protected
  Widget buildMainArea(BuildContext context) {
    return const Center(
      child: Text("BasePage: No content here yet!"),
    );
  }
}
