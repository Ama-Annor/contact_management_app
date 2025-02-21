import 'package:contact_management_app/screens/about.dart';
import 'package:contact_management_app/screens/add_contact.dart';
import 'package:contact_management_app/screens/contacts_list.dart';
import 'package:contact_management_app/screens/edit_contact.dart';
import 'package:flutter/material.dart';

// The main entry point of the app
void main() {
  runApp(const MyApp());
}

// The root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Contacts'),
    );
  }
}

// The main screen of the app with navigation
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// State class for MyHomePage
class _MyHomePageState extends State<MyHomePage> {

  // List of screens for bottom navigation
  List<Widget> _screens = [ContactsList(), AddContactScreen(), AboutScreen()];
  int current_screen = 0;   // Index to track the current selected screen

  // Bottom navigation bar items
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.contacts),  
      label: 'Contact',  // Label for contact list screen
    ),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),   // Label for add contact screen
    BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info')  // Label for about screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[current_screen],  // Displays the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: items,  // Defines the bottom navigation items
        onTap: (value) {
          setState(() {
            current_screen = value;   // Updates the current screen when tapped
          });
        },
        currentIndex: current_screen, // Highlights the selected tab
      ),
    );
  }
}