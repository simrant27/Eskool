
import 'package:http/http.dart' as http;
import 'dart:convert';

// API call to update fee
Future<void> updateFee(
    String studentID, String feeType, double amount, String dueDate) async {
  final response = await http.put(
    Uri.parse('http://localhost:3000/api/fees/update/$studentID/$feeType'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'amount': amount,
      'dueDate': dueDate,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update fee');
  }
}

// API call to delete fee
Future<void> deleteFee(String studentID, String feeType) async {
  final response = await http.delete(
    Uri.parse('http://localhost:3000/api/fees/delete/$studentID/$feeType'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete fee');
  }
}
