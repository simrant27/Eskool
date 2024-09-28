import 'dart:convert';
import 'package:eskool/users/forBackend/parent_model.dart';
import 'package:http/http.dart' as http;
import '../../constants/constants.dart';

Future<Parent?> fetchParents(String id) async {
  final response = await http.get(Uri.parse('$url/api/parent/find/$id'));
  print("i am calling ,${jsonDecode(response.body)}.");
  if (response.statusCode == 200) {
    final decodeData = jsonDecode(response.body);
    return Parent.fromJson(decodeData["parent"]); // Parse JSON to Parent object
  } else {
    throw Exception('Failed to load parent data');
  }
}
