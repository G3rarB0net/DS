import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class SocialRepository {
  final String baseUrl = 'http://localhost:3000';

  Future<void> createUser(User user) async {
    await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
  }

}
