import 'package:flutter/material.dart';
import 'gestorFiltros.dart';
import 'filtros.dart';
import 'package:tuple/tuple.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Filtros',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Validador de Email y Contraseña'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GestorFiltros _gestorCorreo = GestorFiltros();
  final GestorFiltros _gestorContrasena = GestorFiltros();

  @override
  void initState() {
    super.initState();
    _gestorCorreo.agregarFiltro(FiltroCorreo());
    _gestorContrasena.agregarFiltro(FiltroContrasena());
  }

  void _validar() {
    final correo = _emailController.text;
    final contrasena = _passwordController.text;

    Tuple2<bool, String> resultadoCorreo = _gestorCorreo.ejecutarCadena(correo);
    Tuple2<bool, String> resultadoContrasena = _gestorContrasena.ejecutarCadena(contrasena);

    bool todoBien = resultadoCorreo.item1 && resultadoContrasena.item1;

    String mensaje = "${resultadoCorreo.item2}\n${resultadoContrasena.item2}";

    final snackBar = SnackBar(
      content: Text(mensaje),
      backgroundColor: todoBien ? Colors.green : Colors.red,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo electrónico'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _validar,
              child: const Text('Validar'),
            ),
          ],
        ),
      ),
    );
  }
}
