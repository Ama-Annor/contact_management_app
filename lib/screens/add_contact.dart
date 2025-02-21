import 'package:flutter/material.dart';
import 'package:contact_management_app/services/api.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>(); // Key to manage form state
  final TextEditingController _nameController = TextEditingController(); // Controller for name input
  final TextEditingController _phoneController = TextEditingController(); // Controller for phone input
  final ApiService apiService = ApiService(); // Instance of API service
  bool _isLoading = false; // Tracks loading state when submitting form

  // Function to handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) { // Check if form is valid
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        // Call API service to add a new contact
        String message = await apiService.addNewContact(
          _nameController.text.trim(),
          _phoneController.text.trim(),
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.green),
        );

        // Reset form and clear text fields
        _formKey.currentState!.reset();
        _nameController.clear();
        _phoneController.clear();
      } catch (e) {
        // Show error message if API call fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }

      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with title and styling
      appBar: AppBar(
        title: const Text('Add Contact'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 223, 106, 247),
      ),

      // Main body with form inputs
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assigning the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input field for full name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name'; // Validation for empty name
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Input field for phone number
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone, // Keyboard optimized for phone input
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a phone number'; // Validation for empty number
                  } else if (!RegExp(r'^0\d{9}$').hasMatch(value)) {
                    return 'Enter a valid 10-digit phone number'; // Validation for correct phone format
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),

              // Submit button
              SizedBox(
                width: double.infinity, // Button takes full width
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm, // Disable button when loading
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white) // Show loading indicator
                      : const Text('Add Contact'), // Show button text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
