import 'package:flutter/material.dart';
import 'core/base_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Web App',
      theme: ThemeData(
        fontFamily: 'Poppins', // Apply Poppins font globally
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0xFFF4D7DA), // Muted pink background
        useMaterial3: true,
        // Disable default hover effects
        hoverColor: Colors.transparent, // No hover color
        splashColor: Colors.transparent, // No splash effect
        highlightColor: Colors.transparent, // No highlight effect
      ),
      home: BasePage(
        title: "Dashboard",
        middleContent: Container(
          color: Colors.white,
          child: const Center(
            child: Text("Main Content"),
          ),
        ),
        rightSidebar: Container(
          color: Colors.white,
          child: const Center(
            child: Text("Sidebar Content"),
          ),
        ),
        showRightSidebar: true,
      ),
    );
  }
}
