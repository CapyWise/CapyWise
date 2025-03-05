import 'package:flutter/material.dart';
import '../../core/base_page.dart';

class Dashboard extends BasePage {
  const Dashboard({Key? key}) : super(key: key);

  /// Override the main content area to display your cards
  @override
  Widget buildMainArea(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // LEFT COLUMN (the big cards list)
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildExpandableCard(
                    context,
                    title: "TODAY",
                    color: Colors.green[200]!,
                    description: "All day, Sunday, January 8",
                    routineLabel: "Routine",
                    statusLabel: "Busy",
                  ),
                  const SizedBox(height: 16),
                  _buildExpandableCard(
                    context,
                    title: "10 JAN, TUE",
                    color: Colors.pink[200]!,
                    description: "3PM to 6PM • Great Alternative",
                    tag: "ASTR132",
                  ),
                  const SizedBox(height: 16),
                  // Add more cards as needed...
                ],
              ),
            ),
          ),

          const SizedBox(width: 20),

          // RIGHT COLUMN (like a small summary or sidebar)
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              // For example, upcoming exams or mini-calendar
              child: const Center(
                child: Text(
                  "Right column content (exams, etc.)",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Example of a custom "expandable card" from the Figma design
  Widget _buildExpandableCard(
    BuildContext context, {
    required String title,
    required Color color,
    required String description,
    String? tag,
    String? routineLabel,
    String? statusLabel,
  }) {
    // You could use ExpansionPanelList, AnimatedContainer, or
    // a custom show/hide approach for expand/collapse.
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Icons or badges on the top right
              Row(
                children: [
                  if (routineLabel != null) ...[
                    Chip(
                      label: Text(routineLabel),
                      backgroundColor: Colors.black.withOpacity(0.1),
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (statusLabel != null)
                    Chip(
                      label: Text(statusLabel),
                      backgroundColor: Colors.black.withOpacity(0.1),
                    ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Description row
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),

          const SizedBox(height: 8),

          // Tag row (optional)
          if (tag != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(tag),
                ),
                // Example icons: edit, delete, share, etc.
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.email),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {},
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: 'Option 1',
                            child: Text('Option 1'),
                          ),
                          const PopupMenuItem(
                            value: 'Option 2',
                            child: Text('Option 2'),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
