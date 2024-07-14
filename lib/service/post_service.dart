import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app.dart';

class PostService {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<dynamic> fetchPosts() async {
    final response = await get(
      Uri.parse('$API_URL/api/post'),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);
    return jsonDecode(response.body);
  }

  static Future<dynamic> fetchPost(String id) async {
    final response = await get(
      Uri.parse('$API_URL/api/post/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);
    return jsonDecode(response.body);
  }
}
