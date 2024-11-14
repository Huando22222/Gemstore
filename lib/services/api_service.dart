import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() {
    return _instance;
  }
  ApiService._internal();

  static const String baseUrl = 'https://dummyjson.com';

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  void removeAuthToken() {
    _headers.remove('Authorization');
  }

  Future<http.Response> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      return response;
    } catch (e) {
      debugPrint('GET Error: $e');
      rethrow;
    }
  }

  Future<http.Response> post(String endpoint, {dynamic body}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(body),
      );

      return response;
    } catch (e) {
      debugPrint('POST Error: $e');
      rethrow;
    }
  }

  Future<http.Response> put(String endpoint, {dynamic body}) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(body),
      );
      return response;
    } catch (e) {
      debugPrint('PUT Error: $e');
      rethrow;
    }
  }

  Future<http.Response> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      return response;
    } catch (e) {
      debugPrint('DELETE Error: $e');
      rethrow;
    }
  }
}
