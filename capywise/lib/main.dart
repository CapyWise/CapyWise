import 'package:capywise/views/base_page.dart';
import 'package:flutter/material.dart';
import 'core/base_page.dart';
import 'views/auth/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/settings/settings_screen.dart';


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



      home: const SettingsScreen(),


    );
  }
}
