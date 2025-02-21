import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://apps.ashesi.edu.gh/contactmgt/actions";

  // Function to get a single contact
  Future<Map<String, dynamic>> getSingleContact(int contid) async {
    final response = await http.get(
      Uri.parse('$baseUrl/get_a_contact_mob?contid=$contid')
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Get single contact response: $data'); // Debug print
      return data;
    } else {
      throw Exception('Failed to load contact');
    }
  }

  // Function to get all contacts
  Future<List<Map<String, dynamic>>> getAllContacts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get_all_contact_mob')
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print('Get all contacts response: $data'); // Debug print
      return data.map((contact) => Map<String, dynamic>.from(contact)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  // Function to add a new contact
  Future<String> addNewContact(String fullname, String phone) async {
    var formData = {
      'ufullname': fullname,
      'uphonename': phone,
    };

    print('Adding contact with data: $formData'); // Debug print

    final response = await http.post(
      Uri.parse('$baseUrl/add_contact_mob'),
      body: formData, // Send as form data
    );

    print('Add contact response: ${response.body}'); // Debug print

    if (response.statusCode == 200) {
      return response.body; // Returns success/failed string
    } else {
      throw Exception('Failed to add contact: ${response.body}');
    }
  }

  // Function to update an existing contact
  Future<String> updateContact(int cid, String fullname, String phone) async {
    var formData = {
      'cname': fullname,
      'cnum': phone,
      'cid': cid.toString(),
    };

    print('Updating contact with data: $formData'); // Debug print

    final response = await http.post(
      Uri.parse('$baseUrl/update_contact'),
      body: formData,
    );

    print('Update contact response: ${response.body}'); // Debug print

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update contact: ${response.body}');
    }
  }

  // Function to delete a contact
  Future<bool> deleteContact(int contactId) async {
    var formData = {
      'cid': contactId.toString(),
    };

    print('Deleting contact with data: $formData'); // Debug print

    final response = await http.post(
      Uri.parse('$baseUrl/delete_contact'),
      body: formData,
    );

    print('Delete contact response: ${response.body}'); // Debug print

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete contact: ${response.body}');
    }
  }
}