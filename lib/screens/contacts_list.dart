import 'package:contact_management_app/services/api.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  late Future<List<Map<String, dynamic>>> contacts;

  @override
  void initState() {
    super.initState();
    contacts = ApiService().getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: contacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No contacts found.'));
          } else {
            var contactsData = snapshot.data!;
            return ListView.builder(
              itemCount: contactsData.length,
              itemBuilder: (context, index) {
                var contact = contactsData[index];
                return ListTile(
                  title: Text(contact['pname']),
                  subtitle: Text(contact['pphone']),
                );
              },
            );
          }
        },
      ),
    );
  }
}