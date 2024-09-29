import 'dart:convert';
import 'package:eskool/constants/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/parentModel.dart';

class ParentService {
  static const String baseUrl = '$url/api/parent';

  // Fetch all parents
  // static Future<List<Parent>> fetchParents() async {
  //   final response = await http.get(Uri.parse(baseUrl));
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((parent) => Parent.fromJson(parent)).toList();
  //   } else {
  //     throw Exception('Failed to load parents');
  //   }
  // }

  // // Fetch a single parent by ID
  // static Future<Parent> fetchParentById(String id) async {
  //   final response = await http.get(Uri.parse('$baseUrl/$id'));
  //   if (response.statusCode == 200) {
  //     return Parent.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load parent');
  //   }
  // }

  // Create a parent
  static Future<void> createParent(Parent parent, PlatformFile? image) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/create'));

    request.fields['parent'] =
        json.encode(parent.toJson()); // Pass parent data as JSON string

    // Add image if available
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromBytes(
          'image',
          image.bytes!,
          filename: image.name,
          contentType: MediaType('image', 'jpeg'), // Adjust MIME type
        ),
      );
    }

    // Send the request
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 201) {
      print('Parent created successfully');
    } else {
      print('Failed to create: ${response.statusCode}');
      print('Response body: ${await response.stream.bytesToString()}');
    }
  }
}

  // Update a parent
//   static Future<http.Response> updateParent(String id, Parent parent) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/$id'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(parent.toJson()),
//     );
//     return response;
//   }

//   // Delete a parent
//   static Future<http.Response> deleteParent(String id) async {
//     final response = await http.delete(Uri.parse('$baseUrl/$id'));
//     return response;
//   }
// }

