import 'dart:convert';
import 'package:eskool/constants/constants.dart';
import 'package:eskool/models/ParentMode.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// import '../models/parentModel.dart';

class ParentService {
  final String baseUrl = "$url/api/parent";

  Future<List<Parent>> fetchParents() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // Check if 'Parents' exists in the response
      if (data['parents'] != null) {
        final List<dynamic> parentsJson = data['parents'];
        return parentsJson.map((json) => Parent.fromJson(json)).toList();
      } else {
        return []; // Return an empty list if no Parents are found
      }
    } else {
      throw Exception('Failed to load Parents');
    }
  }

  Future<Parent> fetchParentById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Parent.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load parent');
    }
  }

  Future<void> createParent(
      Map<String, dynamic> parentData, PlatformFile? image) async {
    var uri = Uri.parse("$baseUrl/create");
    var request = http.MultipartRequest('POST', uri);

    // Add the form fields
    request.fields.addAll({
      "fullName": parentData['fullName'],
      "email": parentData['email'],
      "phone": parentData['phone'],
      // "parentID": parentData['parentID'],
      "username": parentData['username'],
      "password": parentData['password'],
      "address": parentData['address'],
    });

    // Add the image file if selected
    if (image != null) {
      String mimeType = '';
      if (image.extension == 'png') {
        mimeType = 'image/png';
      } else if (image.extension == 'jpg' || image.extension == 'jpeg') {
        mimeType = 'image/jpeg';
      }

      request.files.add(
        http.MultipartFile.fromBytes(
          'image', // 'file' should match the key used in your backend
          image.bytes!, // Use the bytes property for web
          filename: image.name,
          contentType: MediaType.parse(mimeType), // Use the MediaType
        ),
      );
    }

    try {
      var response = await request.send();

      if (response.statusCode == 201) {
        print('Parent created successfully');
      } else {
        print('Failed to create Parent');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateParent(String id, Parent parent) async {
    print(id);
    // if (parent.id == null) {
    //   throw Exception('parent ID cannot be null');
    // }
    final response = await http.put(
      Uri.parse('$baseUrl/update/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(parent.toJson()),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update parent');
    }
  }

  Future<void> deleteParent(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      // Extract message from response body for better error feedback
      final body = json.decode(response.body);
      throw Exception(body['message'] ?? 'Failed to delete Parent');
    }
  }
}
