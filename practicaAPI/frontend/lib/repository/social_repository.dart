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

  Future<bool> userExists(String email) async{
    final url = Uri.parse(baseUrl + '/users/get_by_email?email=$email');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return true; // Usuario encontrado
    } else if (response.statusCode == 404) {
      return false; // Usuario no existe
    } else {
      throw Exception('Error al verificar si el usuario existe');
    }
  }

  Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
