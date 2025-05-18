import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';
import '../models/post.dart';

class SocialRepository {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Post>> fetchPosts() async {
    final res = await http.get(Uri.parse('$baseUrl/posts'));
    return (jsonDecode(res.body) as List).map((e) => Post.fromJson(e)).toList();
  }

  Future<void> createUser(User user) async {
    await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
  }

  Future<void> createPost(Post post, int userId) async {
    await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': post.title,
        'body': post.body,
        'user_id': userId
      }),
    );
  }
}
