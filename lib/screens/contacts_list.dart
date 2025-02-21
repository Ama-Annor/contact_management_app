import 'package:flutter/material.dart';
import 'package:contact_management_app/services/api.dart';
import 'package:contact_management_app/screens/edit_contact.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ApiService apiService = ApiService();
  late Future<List<Map<String, dynamic>>> _contactsFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() {
    _contactsFuture = apiService.getAllContacts();
  }

  Future<void> _refreshContacts() async {
    setState(() {
      _loadContacts();
    });
  }

  Future<void> _deleteContact(int contactId) async {
    try {
      setState(() => _isLoading = true);
      final success = await apiService.deleteContact(contactId);
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contact deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        _refreshContacts();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting contact: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _editContact(BuildContext context, int contactId) async {
    print('Editing contact with ID: $contactId'); // Debug print
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditContact(contactId: contactId),
      ),
    );

    if (result == true) {
      _refreshContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 223, 106, 247),
        title: const Text('Contacts List'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshContacts,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _contactsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting || _isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    TextButton(
                      onPressed: _refreshContacts,
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No contacts found.\nPull down to refresh.',
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final contact = snapshot.data![index];
                // Debug print to see contact data
                print('Contact data: $contact');
                final contactId = int.tryParse(contact['pid'].toString()) ?? 0;
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        contact['pname']?[0]?.toUpperCase() ?? 'U',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      contact['pname'] ?? 'Unknown',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contact['pphone'] ?? 'No phone'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            print('Edit button pressed for ID: $contactId'); // Debug print
                            _editContact(context, contactId);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Contact'),
                              content: const Text(
                                'Are you sure you want to delete this contact?'
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    print('Deleting contact with ID: $contactId'); // Debug print
                                    _deleteContact(contactId);
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}