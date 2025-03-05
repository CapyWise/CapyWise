
import 'package:flutter/material.dart';

/// SidebarWidget is a collapsible sidebar navigation menu.
/// It provides navigation options and includes a profile section and a logout button.
class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  SidebarWidgetState createState() {
    return SidebarWidgetState();
  }
}

class SidebarWidgetState extends State<SidebarWidget> {
  bool isCollapsed = false; // Tracks the collapsed state of the sidebar

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isCollapsed ? 60 : 200, // Adjusts width based on collapsed state
      color: const Color.fromARGB(255, 200, 162, 165),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Header: Includes profile image and app name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isCollapsed)
                  Expanded(
                    child: Row(
                      children: [
                        // Profile Avatar
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.pets, color: Colors.black54),
                        ),
                        const SizedBox(width: 10),
                        // App Name
                        const Expanded(
                          child: Text(
                            "CapyWise",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis, // Prevent text overflow
                          ),
                        ),
                      ],
                    ),
                  ),
                // Collapse/Expand Button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Sidebar Navigation Items
          SidebarItem(icon: Icons.dashboard, title: "Dashboard", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.calendar_today, title: "Calendars", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.schedule, title: "Exam Scheduler", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.notifications, title: "Reminders", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.help, title: "Capy Assist", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.settings, title: "Settings", isCollapsed: isCollapsed, hasHoverEffect: true),

          const Spacer(),
          const Divider(color: Colors.white54, thickness: 1, indent: 10, endIndent: 10),

          // Profile Section (Selectable)
          GestureDetector(
            onTap: () {
              print("Profile clicked");
            },
            child: SidebarItem(icon: Icons.pets, title: "capy", isCollapsed: isCollapsed, hasHoverEffect: false),
          ),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextButton(
              onPressed: () {
                print("Logout clicked");
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white24,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  const Icon(Icons.logout, color: Colors.white),
                  if (!isCollapsed)
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Logout",
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 16),
                          overflow: TextOverflow.ellipsis, // Prevent text overflow
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// SidebarItem represents an individual item in the sidebar menu.
/// It supports an icon, title, and hover effects.
class SidebarItem extends StatefulWidget {
  final IconData icon; // Icon displayed on the sidebar
  final String title; // Title text
  final bool isCollapsed; // Whether the sidebar is collapsed
  final bool hasHoverEffect; // Determines if hover effect is enabled

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isCollapsed,
    required this.hasHoverEffect,
  });

  @override
  SidebarItemState createState() {
    return SidebarItemState();
  }
}

class SidebarItemState extends State<SidebarItem> {
  bool isHovered = false; // Tracks hover state

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: MouseRegion(
        onEnter: (_) {
          if (widget.hasHoverEffect) {
            setState(() {
              isHovered = true;
            });
          }
        },
        onExit: (_) {
          if (widget.hasHoverEffect) {
            setState(() {
              isHovered = false;
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: isHovered ? const Color.fromARGB(255, 250, 232, 232) : const Color.fromARGB(255, 200, 162, 165),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Row(
            children: [
              Icon(widget.icon, color: isHovered ? Colors.black54 : Colors.white),
              if (!widget.isCollapsed) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: isHovered ? Colors.black54 : Colors.white,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';

/// SidebarWidget is a collapsible sidebar navigation menu.
/// It provides navigation options and includes a profile section and a logout button.
class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  SidebarWidgetState createState() {
    return SidebarWidgetState();
  }
}

class SidebarWidgetState extends State<SidebarWidget> {
  bool isCollapsed = false; // Tracks the collapsed state of the sidebar

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isCollapsed ? 60 : 200, // Adjusts width based on collapsed state
      color: const Color.fromARGB(255, 200, 162, 165),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Header: Includes profile image and app name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isCollapsed)
                  Expanded(
                    child: Row(
                      children: [
                        // Profile Avatar
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.pets, color: Colors.black54),
                        ),
                        const SizedBox(width: 10),
                        // App Name
                        const Text(
                          "CapyWise",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                // Collapse/Expand Button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Sidebar Navigation Items
          SidebarItem(icon: Icons.dashboard, title: "Dashboard", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.calendar_today, title: "Calendars", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.schedule, title: "Exam Scheduler", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.notifications, title: "Reminders", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.help, title: "Capy Assist", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.settings, title: "Settings", isCollapsed: isCollapsed, hasHoverEffect: true),

          const Spacer(),
          const Divider(color: Colors.white54, thickness: 1, indent: 10, endIndent: 10),

          // Profile Section (Selectable)
          GestureDetector(
            onTap: () {
              print("Profile clicked");
            },
            child: SidebarItem(icon: Icons.pets, title: "capy", isCollapsed: isCollapsed, hasHoverEffect: false),
          ),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextButton(
              onPressed: () {
                print("Logout clicked");
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white24,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  const Icon(Icons.logout, color: Colors.white),
                  if (!isCollapsed)
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// SidebarItem represents an individual item in the sidebar menu.
/// It supports an icon, title, and hover effects.
class SidebarItem extends StatefulWidget {
  final IconData icon; // Icon displayed on the sidebar
  final String title; // Title text
  final bool isCollapsed; // Whether the sidebar is collapsed
  final bool hasHoverEffect; // Determines if hover effect is enabled

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isCollapsed,
    required this.hasHoverEffect,
  });

  @override
  SidebarItemState createState() {
    return SidebarItemState();
  }
}

class SidebarItemState extends State<SidebarItem> {
  bool isHovered = false; // Tracks hover state

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: MouseRegion(
        onEnter: (_) {
          if (widget.hasHoverEffect) {
            setState(() {
              isHovered = true;
            });
          }
        },
        onExit: (_) {
          if (widget.hasHoverEffect) {
            setState(() {
              isHovered = false;
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: isHovered ? const Color.fromARGB(255, 250, 232, 232) : const Color.fromARGB(255, 200, 162, 165),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Row(
            children: [
              Icon(widget.icon, color: isHovered ? Colors.black54 : Colors.white),
              if (!widget.isCollapsed) ...[
                const SizedBox(width: 10),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: isHovered ? Colors.black54 : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
*/