import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class APIRequest {
  final String baseURL;

  APIRequest({required this.baseURL});

  postRequest(String endpoint, Map data) async {
    try {
      var response = await http.post(
        Uri.parse('$baseURL/$endpoint'),
        body: data,
        // headers: {'Content-Type': 'application/json'},
      );
      print('http.post =>success');
      if (response.statusCode == 200) {
        // print(response.statusCode);
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('status code not 200 ${response.statusCode}');
        
        // throw Exception('Failed to load data');
      }
    } catch (e) {
      print('http.post =>error $e');
      // throw Exception('Failed to connect to the server');
    }
  }
}
