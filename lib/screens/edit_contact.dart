import 'package:flutter/material.dart';
import 'package:contact_management_app/services/api.dart';

class EditContact extends StatefulWidget {
  final int contactId;
  
  const EditContact({super.key, required this.contactId});

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ApiService apiService = ApiService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContactData();
  }

  Future<void> _loadContactData() async {
    try {
      final contact = await apiService.getSingleContact(widget.contactId);
      setState(() {
        _nameController.text = contact['pname'];
        _phoneController.text = contact['pphone'];
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading contact: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateContact() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        String message = await apiService.updateContact(
          widget.contactId,
          _nameController.text.trim(),
          _phoneController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ? 'Enter a phone number' : null,
                    ),
                    const SizedBox(height: 20),
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
