import 'package:flutter/material.dart';
import 'package:frontend/screens/pantallaPrincipal.dart';
import 'package:provider/provider.dart';
import 'screens/pantallaLogin.dart';
import 'screens/pantallaInicial.dart';
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
        debugShowCheckedModeBanner: false,
        title: 'Gestor de tareas',
        home: PantallaInicial()
      //home: PantallaPrincipal(currentUser: 'user1@gmail.com'),
    );
  }
}
