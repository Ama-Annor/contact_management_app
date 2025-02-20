import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL
  final String baseUrl = "https://apps.ashesi.edu.gh/contactmgt/actions/";

  // Function to get a single contact
  Future<Map<String, dynamic>> getSingleContact(int contid) async {
    final response = await http.get(Uri.parse('$baseUrl/get_a_contact_mob?contid=$contid'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load contact');
    }
  }

  // Function to get all contacts
  Future<List<Map<String, dynamic>>> getAllContacts() async {
    final response = await http.get(Uri.parse('$baseUrl/get_all_contact_mob'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((contact) => Map<String, dynamic>.from(contact)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  // Function to add a new contact
  Future<String> addNewContact(String fullname, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_contact_mob'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'ufullname': fullname,
        'uphonename': phone,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['message']; // Assuming response contains a message field
    } else {
      throw Exception('Failed to add contact');
    }
  }

  // Function to update an existing contact
  Future<String> updateContact(int cid, String fullname, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update_contact'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'ufullname': fullname,
        'uphonename': phone,
        'cid': cid,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['message']; // Assuming response contains a message field
    } else {
      throw Exception('Failed to update contact');
    }
  }

  // Function to delete a contact
  Future<bool> deleteContact(int cid) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete_contact'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'cid': cid,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['success']; // Assuming response contains a 'success' field
    } else {
      throw Exception('Failed to delete contact');
    }
  }
}