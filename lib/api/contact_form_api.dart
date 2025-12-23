// For only Web, is called by ContactFormService. Version with multipart/form-data (text + files).
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/contact_form_request_model.dart';

class ContactFormApi {
  static Future<bool> send(ContactFormRequestModel request) async {
    final backendUrl = request.requestType == null ? dotenv.env['PARTNER_URL'] : dotenv.env['CUSTOMER_URL'];
    http.Response response; // Global variable to unify handling later

    if (backendUrl == null || backendUrl.isEmpty) {
      throw Exception('Missing or invalid backend URL');
    }

    final uri = Uri.parse(backendUrl);

    // CASE n°1 PartnersScreen -> JSON Method (req.body)
    if (request.requestType == null ) {
      // Send request as JSON (no files, only req.body)
      response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );
    } else {
      //  CASE n°2 ContactScreen -> multipart/form-data Method (req.files)
      final httpRequest = http.MultipartRequest("POST", uri); // Create a multipart request (supports text fields + file uploads)

      // Add text fields to multipart request (these go into req.body)
      httpRequest.fields['requestType'] = request.requestType ?? '';
      httpRequest.fields['firstName'] = request.firstName;
      httpRequest.fields['lastName'] = request.lastName;
      httpRequest.fields['company'] = request.company;
      httpRequest.fields['email'] = request.email;
      httpRequest.fields['phone'] = request.phone;
      httpRequest.fields['message'] = request.message;
      if (request.typeWork != null) {
        httpRequest.fields['typeWork'] = request.typeWork!.join(',');
      }
      if (request.startDate != null) {
        httpRequest.fields['startDate'] = request.startDate!;
      }
      if (request.address != null) {
        httpRequest.fields['address'] = request.address!;
      }

      // Add files to multipart request (these go into req.files)
      if (request.files != null && request.files!.isNotEmpty) {
        for (var picked in request.files!) {
          final bytes = await picked.file.readAsBytes();  // On Web: read file bytes directly

          httpRequest.files.add(
            http.MultipartFile.fromBytes(
              'files', // Backend expects this key
              bytes,
              filename: picked.file.name,
            )
          );
        }
      } 

      // Send multipart request and convert StreamedResponse to http.Response
      final streamed = await httpRequest.send();
      final body = await streamed.stream.bytesToString();
      response = http.Response(body, streamed.statusCode);
    }

    // Handle response (Unified response handling)
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




// // Is called by ContactFormService
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import '../models/contact_form_request_model.dart';

// class ContactFormApi {
//   static Future<bool> send(ContactFormRequestModel request) async {
//     final backendUrl = request.requestType == null ? dotenv.env['PARTNER_URL'] : dotenv.env['CUSTOMER_URL'];

//     if (backendUrl == null || backendUrl.isEmpty) {
//       throw Exception('Missing or invalid backend URL');
//     }

//     final uri = Uri.parse(backendUrl);

//     final response = await http.post(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(request.toJson()),
//     );

//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       if (responseData['result'] == true) {
//         return true;
//       } else {
//         // Error message returned by the backend
//         throw Exception(responseData['error'] ?? 'Unknown error on the server side');
//       }
//     } else {
//       // HTTP error (ex: 500, 404…)
//       throw Exception(
//         'Network error (${response.statusCode}) : ${response.reasonPhrase}',
//       );
//     }
//   }
// }
