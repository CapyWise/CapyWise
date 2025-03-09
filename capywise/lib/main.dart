import 'package:capywise/views/base_page.dart';
import 'package:flutter/material.dart';
import 'core/base_page.dart';
import 'views/auth/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/settings/settings_screen.dart';
import 'widgets/new_event_widget.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CapyWise',
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

/*
      home: BasePage(
        title: "Title", // Generic title for the page
        middleContent: Container(
          color: Colors.white,
          child: const Center(
            child: Text("Main Content"),
          ),
        ),

        /// **Right Sidebar (Matching UI Design)**
        rightSidebar: Container(
          color: Colors.white,
          child: const Center(
            child: Text("Sidebar Content"),
          ),
        ),

        /// **Header Action Buttons (Top Right)**
        actionButtons: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text("Primary Action"),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: () {},
            child: const Text("Default"),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],

        /// **Bottom Header Bar (Dropdown & Input Field)**
        bottomHeaderBar: [
          SizedBox(
            width: 200,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Placeholder",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          DropdownButton<String>(
            items: const [
              DropdownMenuItem(value: "Option 1", child: Text("Choose something")),
              DropdownMenuItem(value: "Option 2", child: Text("Option 1")),
            ],
            onChanged: (String? value) {},
            hint: const Text("Choose something"),
          ),
        ],
      ),
      */
      //home: const LandingPageFinal(),
      home: EventFormWidget(),
    );
  }
}
