import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobiledev/api/const_api.dart';

class Httplar {
  // Method for POST requests
  static Future<http.Response> httpPost({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    var bodyEncoded = json.encode(data);
    var url = Uri.https(
      URLHTTP,
      path,
      query,
    );
    return await http.post(url, body: bodyEncoded, headers: {
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer $TOKEN'
    });
  }

  // Method for GET requests
  static Future<http.Response> httpGet({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    var url = Uri.https(URLHTTP, path, query);
    return await http.get(url, headers: {
      'Accept': 'application/json',
      "Content-Type": "application/json",
      'Authorization': 'Bearer $TOKEN'
    });
  }

  // Method for DELETE requests
  static Future<http.Response> httpDelete({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    var url = Uri.https(
      URLHTTP,
      path,
      query,
    );
    return await http.delete(url, body: data, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
  }

  // Method for PUT requests
  static Future<http.Response> httpPut({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    var bodyEncoded = json.encode(data);
    var url = Uri.https(
      URLHTTP,
      path,
      query,
    );
    return await http.put(url, body: bodyEncoded, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
  }

  // Method for PATCH requests
  static Future<http.Response> httpPatch({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    var url = Uri.https(
      URLHTTP,
      path,
      query,
    );
    return await http.patch(url, body: data, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
  }

  // New method for user signup
  static Future<Map<String, dynamic>> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final response = await httpPost(
      path: '/signup', // Replace with your actual signup endpoint
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Return parsed user data
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }
}
