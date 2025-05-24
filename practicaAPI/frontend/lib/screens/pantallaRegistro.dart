import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repository/social_repository.dart';
import '../filters/account_checker.dart';
import 'pantallaPrincipal.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final SocialRepository repository = SocialRepository();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
          TextField(
            controller: _password,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              final error = validateUser(email, password);

              if (error != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
                return;
              }

              final exists = await repository.userExists(email);
              if (exists) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Este correo ya está registrado.')),
                );
                return;
              }

              final user = User(email: email, password: password);
              await repository.createUser(user);
              Navigator.push(context, MaterialPageRoute(builder: (_) => PantallaPrincipal(currentUser: email)));
            },
            child: const Text('Crear cuenta'),
          )
        ]),
      ),
    );
  }
}