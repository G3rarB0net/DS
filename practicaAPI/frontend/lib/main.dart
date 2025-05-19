import 'package:flutter/material.dart';
import 'package:frontend/screens/feed_screen.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'repository/social_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final repository = SocialRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social App',
      home: LoginScreen(),
    );
  }
}
