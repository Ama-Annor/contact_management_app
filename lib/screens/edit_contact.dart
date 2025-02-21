import 'package:flutter/material.dart';
import 'package:contact_management_app/services/api.dart';

class EditContact extends StatefulWidget {
  final int contactId; // Contact ID to edit
  
  const EditContact({super.key, required this.contactId});

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _nameController = TextEditingController(); // Controller for name input
  final TextEditingController _phoneController = TextEditingController(); // Controller for phone input
  final ApiService apiService = ApiService(); // API service instance
  bool _isLoading = true; // Loading state indicator

  @override
  void initState() {
    super.initState();
    _loadContactData(); // Load contact data when screen initializes
  }

  // Fetch contact details from API and populate the form fields
  Future<void> _loadContactData() async {
    try {
      final contact = await apiService.getSingleContact(widget.contactId);
      setState(() {
        _nameController.text = contact['pname']; // Set name field
        _phoneController.text = contact['pphone']; // Set phone field
        _isLoading = false; // Stop loading
      });
    } catch (e) {
      // Show error message if fetching contact fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading contact: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Update contact details through API
  Future<void> _updateContact() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });
      try {
        // Call API to update contact
        String message = await apiService.updateContact(
          widget.contactId,
          _nameController.text.trim(), // Trimmed name input
          _phoneController.text.trim(), // Trimmed phone input
        );
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        Navigator.of(context).pop(true); // Close screen and return success
      } catch (e) {
        // Show error message if update fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
      setState(() {
        _isLoading = false; // Stop loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), // Navigate back
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name input field
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                    ),
                    // Phone input field
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ? 'Enter a phone number' : null,
                    ),
                    const SizedBox(height: 20),
                    // Button to update contact
                    ElevatedButton(
                      onPressed: _updateContact,
                      child: const Text('Update Contact'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
