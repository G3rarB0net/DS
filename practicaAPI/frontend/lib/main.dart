import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'repository/social_repository.dart';
import 'notifiers/post_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final repository = SocialRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostNotifier(repository)..loadPosts(),
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
