import 'package:assignment_mobile_app/productsPage.dart';
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


  postProduct(String endpoint, Map data) async {
    try {
      var response = await http.post(
        Uri.parse('$baseURL/$endpoint'),
        body: data,
        // headers: {'Content-Type': 'application/json'},
      );
      print('http.post =>success');
      if (response.statusCode == 200) {
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

  Future<List<Product>> getUserProducts(String endpoint) async {
    try {
      var response = await http.get(
        Uri.parse('$baseURL/$endpoint'),
        // headers: {'Authorization': 'Bearer $authToken'},
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((data) => Product(
          name: data['name'],
          image: data['image'],
          description: data['description'],
          price: double.parse(data['price'].toString()),
        )).toList();
      } else {
        throw Exception('Failed to load user products');
      }
    } catch (e) {
      throw Exception('Error fetching user products: $e');
    }
  }
}



