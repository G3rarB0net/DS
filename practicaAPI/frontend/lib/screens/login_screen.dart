import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repository/social_repository.dart';
import '../filters/account_checker.dart';
import 'feed_screen.dart';

class LoginScreen extends StatelessWidget {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final SocialRepository repository = SocialRepository();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
          TextField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
          ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              if (!validateUser(email, password)) {
                ScaffoldMessenger.of(context).showSnackBar(const  SnackBar(content: Text('Invalid email or password')));
                return;
              }

              final user = User(email: email, password: password);
              await repository.createUser(user);
              Navigator.push(context, MaterialPageRoute(builder: (_) => FeedScreen(currentUser: email)));
            },
            child: const Text('Create Account'),
          )
        ]),
      ),
    );
  }
}
