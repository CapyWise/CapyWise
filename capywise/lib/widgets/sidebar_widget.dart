import 'package:flutter/material.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  SidebarWidgetState createState() {
    return SidebarWidgetState();
  }
}

class SidebarWidgetState extends State<SidebarWidget> {
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isCollapsed ? 60 : 200, // Sidebar width toggle
      color: Color(0xFFF4D7DA), // Muted pink sidebar background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Header with Collapse Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Aligns arrow to the right
              children: [
                // Profile Icon + CapyWise Text (Only in Expanded State)
                if (!isCollapsed)
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              Colors.grey[300], // Placeholder color
                          child: Icon(Icons.pets, color: Colors.black54),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "CapyWise",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),

                // Custom Collapse Button (No Implicit Hover Effect)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isCollapsed
                            ? Icons.arrow_forward_ios
                            : Icons.arrow_back_ios,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Navigation Items with Hover Effects
          SidebarItem(
            icon: Icons.dashboard,
            title: "Dashboard",
            isCollapsed: isCollapsed,
            hasHoverEffect: true,
          ),
          SidebarItem(
            icon: Icons.calendar_today,
            title: "Calendars",
            isCollapsed: isCollapsed,
            hasHoverEffect: true,
          ),
          SidebarItem(
            icon: Icons.schedule,
            title: "Exam Scheduler",
            isCollapsed: isCollapsed,
            hasHoverEffect: true,
          ),
          SidebarItem(
            icon: Icons.notifications,
            title: "Reminders",
            isCollapsed: isCollapsed,
            hasHoverEffect: true,
          ),
          SidebarItem(
            icon: Icons.help,
            title: "Copy Assist",
            isCollapsed: isCollapsed,
            hasHoverEffect: true,
          ),
          SidebarItem(
            icon: Icons.settings,
            title: "Settings",
            isCollapsed: isCollapsed,
            hasHoverEffect: true,
          ),

          Spacer(),

          // User Profile & Logout (No Hover Effect)
          Column(
            children: [
              SidebarItem(
                icon: Icons.pets,
                title: "capy",
                isCollapsed: isCollapsed,
                hasHoverEffect: false,
              ),
              SidebarItem(
                icon: Icons.logout,
                title: "Logout",
                isCollapsed: isCollapsed,
                hasHoverEffect: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Sidebar Item Widget with Smooth Hover Effect (No Gray Background)
class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isCollapsed;
  final bool hasHoverEffect; // Control hover effect

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
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, // Ensure no implicit hover effects
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
          duration: Duration(milliseconds: 150), // Fast & smooth transition
          color:
              isHovered
                  ? Color(0xFFFCE8E8)
                  : Colors.transparent, // Light pink hover
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 15,
          ), // Keeps spacing consistent
          child: Row(
            children: [
              Icon(
                widget.icon,
                color:
                    isHovered
                        ? Colors.white
                        : Colors.black54, // Icon turns white when hovered
              ),
              if (!widget.isCollapsed) ...[
                SizedBox(width: 10),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color:
                        isHovered
                            ? Colors.white
                            : Colors.black54, // Text turns white when hovered
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

/*
import 'package:flutter/material.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  SidebarWidgetState createState() {
    return SidebarWidgetState();
  }
}

class SidebarWidgetState extends State<SidebarWidget> {
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isCollapsed ? 60 : 200, // Sidebar width toggle
      color: Colors.brown[100], // Background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Header with Collapse Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Aligns arrow to the right
              children: [
                // Profile Icon + CapyWise Text (Only in Expanded State)
                if (!isCollapsed)
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              Colors.grey[300], // Placeholder color
                          child: Icon(Icons.person, color: Colors.black54),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "CapyWise",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Collapse Button (Always Visible)
                IconButton(
                  icon: Icon(
                    isCollapsed
                        ? Icons.arrow_forward_ios
                        : Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    setState(() {
                      isCollapsed = !isCollapsed;
                    });
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Navigation Items with Hover Effects
          SidebarItem(
            icon: Icons.dashboard,
            title: "Dashboard",
            isCollapsed: isCollapsed,
          ),
          SidebarItem(
            icon: Icons.calendar_today,
            title: "Calendars",
            isCollapsed: isCollapsed,
          ),
          SidebarItem(
            icon: Icons.schedule,
            title: "Exam Scheduler",
            isCollapsed: isCollapsed,
          ),
          SidebarItem(
            icon: Icons.notifications,
            title: "Reminders",
            isCollapsed: isCollapsed,
          ),
          SidebarItem(
            icon: Icons.help,
            title: "Copy Assist",
            isCollapsed: isCollapsed,
          ),
          SidebarItem(
            icon: Icons.settings,
            title: "Settings",
            isCollapsed: isCollapsed,
          ),

          Spacer(),

          // User Profile & Logout
          Column(
            children: [
              SidebarItem(
                icon: Icons.pets,
                title: "capy",
                isCollapsed: isCollapsed,
              ),
              SidebarItem(
                icon: Icons.logout,
                title: "Logout",
                isCollapsed: isCollapsed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Sidebar Item Widget with Hover Effect
class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isCollapsed;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isCollapsed,
  });

  @override
  SidebarItemState createState() {
    return SidebarItemState();
  }
}

class SidebarItemState extends State<SidebarItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isHovered ? Colors.brown[300] : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
            widget.icon,
            color: isHovered ? Colors.white : Colors.black54,
          ),
          title:
              widget.isCollapsed
                  ? null // Completely hide text when sidebar is collapsed
                  : Text(
                    widget.title,
                    style: TextStyle(
                      color: isHovered ? Colors.white : Colors.black54,
                    ),
                  ),
          onTap: () {
            // Handle navigation logic
          },
        ),
      ),
    );
  }
}
*/
