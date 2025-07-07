import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/contact_form_request.dart';

class ContactFormApi {
  static Future<bool> send(ContactFormRequest request) async {
    final backendUrl = dotenv.env['BACKEND_URL'];

    if (backendUrl == null || backendUrl.isEmpty) {
      throw Exception('Missing or invalid backend URL');
    }

    final uri = Uri.parse(backendUrl);

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['result'] == true) {
        return true;
      } else {
        // Error message returned by the backend
        throw Exception(responseData['error'] ?? 'Unknown error on the server side');
      }
    } else {
      // HTTP error (ex: 500, 404…)
      throw Exception(
        'Network error (${response.statusCode}) : ${response.reasonPhrase}',
      );
    }
  }
}
