import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../../../../models/parentModel.dart';

class ParentService {
  // For Web
  static Future<http.Response> createParentWeb(
      Parent parent, Uint8List imageBytes, String fileName) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://localhost:3000/parents'));

    // Add text fields
    request.fields['fullName'] = parent.fullName;
    request.fields['email'] = parent.email;
    request.fields['phone'] = parent.phone;
    request.fields['address'] = parent.address;
    request.fields['username'] = parent.username;
    request.fields['password'] = parent.password!;

    // Add image file as bytes (web)
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: fileName,
    ));

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  // For Mobile
  static Future<http.Response> createParentMobile(
      Parent parent, File imageFile) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://localhost:3000/parents'));

    // Add text fields
    request.fields['fullName'] = parent.fullName;
    request.fields['email'] = parent.email;
    request.fields['phone'] = parent.phone;
    request.fields['address'] = parent.address;
    request.fields['username'] = parent.username;
    request.fields['password'] = parent.password!;

    // Add image file (mobile)
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
    ));

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}
