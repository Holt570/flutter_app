import 'dart:convert';
import 'package:http/http.dart' as http;

class WarehouseApi {
  WarehouseApi();

  static const apiKey = 'api_warehouse_student_key_1234567890abcdef';

  static Map<String, String> _jsonHeaders() => {
        'Content-Type': 'application/json',
      };

  static Map<String, String> _authHeaders() => {
        ..._jsonHeaders(),
        'X-API-Key': apiKey,
      };

  static Future<Map<String, dynamic>> createLog({
    required String title,
    required String comment,
    required String status,
  }) async {
    String baseUrl = "http://localhost:5000";
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

  static Future<List<Map<String, dynamic>>> getJobs(
  ) async {
    String baseUrl = "http://localhost:5000";
    final response = await http.get(
      Uri.parse('$baseUrl/sync/jobs'),
      headers: _authHeaders(),
    );
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }
}