import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 223, 106, 247), // Adjust color as needed
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Contact Management App',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Divider(thickness: 1, height: 30),
            Text(
              'Developed by:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Name: Ama Aseda Annor',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Student ID: 58352026',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'About the App:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'This Contact Management App allows users to add, update, and delete contacts efficiently. '
              'It provides a simple interface for managing contact information with real-time API integration.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            
          ],
        ),
      ),
    );
  }
}
