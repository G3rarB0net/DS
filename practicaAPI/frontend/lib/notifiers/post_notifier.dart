import 'package:flutter/material.dart';
import '../models/post.dart';
import '../repository/social_repository.dart';

class PostNotifier extends ChangeNotifier {
  final SocialRepository repository;
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  PostNotifier(this.repository);

  Future<void> loadPosts() async {
    _posts = await repository.fetchPosts();
    notifyListeners();
  }

  Future<void> addPost(Post post, int userId) async {
    await repository.createPost(post, userId);
    await loadPosts();
    notifyListeners(); // Observer Pattern
  }
}
