import 'package:contact_management_app/screens/about.dart';
import 'package:contact_management_app/screens/add_contact.dart';
import 'package:contact_management_app/screens/contacts_list.dart';
import 'package:contact_management_app/screens/edit_contact.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> _screens = [ContactsList(), AddContactScreen(), AboutScreen()];
  int current_screen = 0;

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.contacts),
      label: 'Contact',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
    BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[current_screen],
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        onTap: (value) {
          setState(() {
            current_screen = value;
          });
        },
        currentIndex: current_screen,
      ),
    );
  }
}