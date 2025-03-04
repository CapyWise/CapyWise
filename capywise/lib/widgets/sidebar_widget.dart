import 'package:flutter/material.dart';

class SidebarWidget extends StatefulWidget
{
  const SidebarWidget({super.key});

  @override
  SidebarWidgetState createState()
  {
    return SidebarWidgetState();
  }
}

class SidebarWidgetState extends State<SidebarWidget>
{
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context)
  {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isCollapsed ? 60 : 200,
      color: Color.fromARGB(255, 200, 162, 165),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:
              [
                if (!isCollapsed)
                  Expanded(
                    child: Row(
                      children:
                      [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.pets, color: Colors.black54),
                        ),
                        SizedBox(width: 10),
                        Text(
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
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: ()
                    {
                      setState(()
                      {
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
                        isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          SidebarItem(icon: Icons.dashboard, title: "Dashboard", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.calendar_today, title: "Calendars", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.schedule, title: "Exam Scheduler", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.notifications, title: "Reminders", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.help, title: "Capy Assist", isCollapsed: isCollapsed, hasHoverEffect: true),
          SidebarItem(icon: Icons.settings, title: "Settings", isCollapsed: isCollapsed, hasHoverEffect: true),

          Spacer(),
          Divider(color: Colors.white54, thickness: 1, indent: 10, endIndent: 10),
          
          GestureDetector(
            onTap: () {
              print("Profile clicked");
            },
            child: SidebarItem(icon: Icons.pets, title: "capy", isCollapsed: isCollapsed, hasHoverEffect: false),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextButton(
              onPressed: () {
                print("Logout clicked");
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white24,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  Icon(Icons.logout, color: Colors.white),
                  if (!isCollapsed)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
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

class SidebarItem extends StatefulWidget
{
  final IconData icon;
  final String title;
  final bool isCollapsed;
  final bool hasHoverEffect;

  const SidebarItem(
    {
      super.key,
      required this.icon,
      required this.title,
      required this.isCollapsed,
      required this.hasHoverEffect,
    }
  );

  @override
  SidebarItemState createState()
  {
    return SidebarItemState();
  }
}

class SidebarItemState extends State<SidebarItem>
{
  bool isHovered = false;

  @override
  Widget build(BuildContext context)
  {
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
          duration: Duration(milliseconds: 150),
          color: isHovered ? Color.fromARGB(255, 250, 232, 232) : Color.fromARGB(255, 200, 162, 165),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Row(
            children: [
              Icon(widget.icon, color: isHovered ? Colors.black54 : Colors.white),
              if (!widget.isCollapsed) ...[
                SizedBox(width: 10),
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