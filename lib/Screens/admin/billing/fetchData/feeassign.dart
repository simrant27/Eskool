import 'package:eskool/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../constants/constants.dart';

Future<void> assignFee(
    String studentID, String feeType, double amount, String? dueDate) async {
  final response = await http.post(
    Uri.parse('$url/api/fees/assign'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'studentID':
          studentID, // studentID is passed as a string (must be a valid ObjectId)
      'feeType': feeType,
      'amount': amount,
      'dueDate': dueDate, // Optional dueDate can be null if not provided
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Fee assigned successfully');
  } else {
    print('Failed to assign fee: ${response.statusCode}');
    print('Response: ${response.body}');
    throw Exception('Failed to assign fee');
  }
}
