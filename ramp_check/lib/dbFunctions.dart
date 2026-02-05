import 'dart:convert';
import 'package:http/http.dart' as http;

class WarehouseApi {
  WarehouseApi();

  String baseUrl = "http://localhost:5000";

  static const apiKey = 'api_warehouse_student_key_1234567890abcdef';

  Map<String, String> _jsonHeaders() => {
        'Content-Type': 'application/json',
      };

  Map<String, String> _authHeaders() => {
        ..._jsonHeaders(),
        'X-API-Key': apiKey,
      };

  Future<Map<String, dynamic>> createLog({
    required String title,
    required String comment,
    required String status,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sync/jobs'),
      headers: _authHeaders(),
      body: jsonEncode({
        'title': title,
        'comment': comment,
        'status': status,
      }),
    );
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}