import 'package:flutter/material.dart';

/// **SidebarWidget**
/// 
/// This widget represents a collapsible sidebar used for navigation.
/// 
/// Features:
/// - **Expands and collapses** on button press.
/// - **Navigation items with hover effects** for better UI feedback.
/// - **Profile section** displayed at the bottom.
/// - **Logout button** with proper spacing and alignment.
/// 
/// This sidebar is designed to be used across multiple pages in an app.
class SidebarWidget extends StatefulWidget 
{
    const SidebarWidget({super.key});

    @override
    SidebarWidgetState createState() => SidebarWidgetState();
}

class SidebarWidgetState extends State<SidebarWidget> 
{
    bool isCollapsed = true; // Default state: collapsed
    int selectedIndex = 0; // Tracks which navigation item is selected
    int? hoveredIndex; // Tracks which navigation item is hovered

    @override
    Widget build(BuildContext context) {
        return AnimatedContainer(
            duration: const Duration(milliseconds: 250), // Smooth expansion/collapse transition
            width: isCollapsed ? 60 : 200, // Adjusts width based on collapse state
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 200, 162, 165), // Sidebar background color
            ),
            child: Column(
                children: [
                    /// **App Logo & Sidebar Toggle Button**
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                            children: [
                                /// **Capybara Logo**
                                SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                        '../assets/images/capybara.png', // Replace with the correct asset path
                                    ),
                                ),
                                const SizedBox(height: 10),
                                
                                /// **App Name (Visible only in expanded mode)**
                                if (!isCollapsed)
                                    const Text(
                                        "CapyWise",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                    ),
                            ],
                        ),
                    ),

                    /// **Expand/Collapse Toggle Button**
                    IconButton(
                        onPressed: () {
                            setState(() {
                                isCollapsed = !isCollapsed; // Toggle collapsed state
                            });
                        },
                        icon: Icon(
                            isCollapsed ? Icons.menu : Icons.arrow_back, // Change icon based on state
                            color: Colors.white,
                        ),
                    ),
                    const SizedBox(height: 10),

                    /// **Navigation Items**
                    Expanded(
                        child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                                buildNavItem(Icons.dashboard, "Dashboard", 0),
                                buildNavItem(Icons.calendar_today, "Calendars", 1),
                                buildNavItem(Icons.schedule, "Exam Scheduler", 2),
                                buildNavItem(Icons.notifications, "Reminders", 3),
                                buildNavItem(Icons.help, "Capy Assist", 4),
                                buildNavItem(Icons.settings, "Settings", 5),
                            ],
                        ),
                    ),

                    /// **Profile & Logout Section**
                    Column(
                        children: [
                            const Divider(color: Colors.white54, thickness: 1), // Separator line
                            buildProfileSection(), // Profile widget
                            buildLogoutButton(), // Logout button
                        ],
                    ),
                ],
            ),
        );
    }

    /// **Builds a navigation item with hover effects and click selection**
    Widget buildNavItem(IconData icon, String label, int index) 
    {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2), // Prevents hover effect overlap
            child: MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = index), // Detect when hovered
                onExit: (_) => setState(() => hoveredIndex = null), // Detect when not hovered
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200), // Smooth hover effect transition
                    curve: Curves.easeInOut,
                    height: 50, // Fixed height for hover effect consistency
                    width: isCollapsed ? 50 : 180, // Width adapts to collapse state
                    decoration: BoxDecoration(
                        color: hoveredIndex == index
                            ? const Color.fromARGB(255, 180, 130, 135) // Slightly darker hover color
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: isCollapsed ? 5 : 10), // Centers hover effect
                    child: InkWell(
                        onTap: () {
                            setState(() {
                                selectedIndex = index; // Update selected navigation index
                            });
                            print("Selected index: $index");
                        },
                        borderRadius: BorderRadius.circular(8), // Ensures clicks stay within hover box
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Prevents hover overlap
                            child: Row(
                                mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                                children: [
                                    /// **Navigation Icon**
                                    Icon(icon, color: Colors.white, size: 24),
                                    
                                    /// **Navigation Label (Visible only when expanded)**
                                    if (!isCollapsed)
                                        Expanded(
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 12),
                                                child: Text(
                                                    label,
                                                    overflow: TextOverflow.ellipsis, // Prevents overflow
                                                    softWrap: false,
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                    ),
                                                ),
                                            ),
                                        ),
                                ],
                            ),
                        ),
                    ),
                ),
            ),
        );
    }

    /// **Builds the Profile Section**
    Widget buildProfileSection() 
    {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    /// **Profile Icon (Placeholder)**
                    const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.pets, color: Colors.black54),
                    ),
                    
                    /// **Username (Visible only when expanded)**
                    if (!isCollapsed)
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "capy",
                                    overflow: TextOverflow.ellipsis, // Prevents overflow
                                    softWrap: false,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                    ),
                                ),
                            ),
                        ),
                ],
            ),
        );
    }

    /// **Builds the Logout Button**
    Widget buildLogoutButton() 
    {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: SizedBox(
                width: isCollapsed ? 50 : double.infinity, // Ensures button fits sidebar width
                child: TextButton(
                    onPressed: () {
                        print("Logout clicked"); // Implement logout functionality here
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white24,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                        ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            /// **Logout Icon**
                            const Icon(Icons.logout, color: Colors.white),
                            
                            /// **Logout Label (Visible only when expanded)**
                            if (!isCollapsed)
                                Flexible(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                            "Logout",
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 16,
                                            ),
                                        ),
                                    ),
                                ),
                        ],
                    ),
                ),
            ),
        );
    }
}
