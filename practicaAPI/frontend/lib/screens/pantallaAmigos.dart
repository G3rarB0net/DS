import 'package:flutter/material.dart';
import 'package:frontend/friend/GestorDeAmistades.dart';
import 'package:frontend/friend/amistad.dart';
import '../repository/social_repository.dart';
import 'pantallaPrincipal.dart';
import 'pantallaInicial.dart';

class PantallaAmigos extends StatefulWidget {
  final String currentUser;

  PantallaAmigos({required this.currentUser});
  @override
  _PantallaAmigosState createState() => _PantallaAmigosState();
}

class WidgetMostrarAmigo extends StatefulWidget {
  final Amistad amistad;
  final GestorDeAmistades gestor;
  final String currentUser;
  final Function() onUpdate;

  WidgetMostrarAmigo({
    required this.amistad,
    required this.gestor,
    required this.currentUser,
    required this.onUpdate,
  });

  @override
  _WidgetMostrarAmigoState createState() => _WidgetMostrarAmigoState();
}

class _WidgetMostrarAmigoState extends State<WidgetMostrarAmigo> {
  void _deleteFriendship() async {
    try {
      await widget.gestor.eliminarAmistad(widget.amistad);
      widget.onUpdate();
    } catch (e) {
      print("Error eliminando amistad: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(
          widget.amistad.amistadCon ?? "Amigo sin nombre",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: _deleteFriendship,
        ),
      ),
    );
  }
}

class _PantallaAmigosState extends State<PantallaAmigos> {
  final TextEditingController _controller = TextEditingController();
  final GestorDeAmistades _gestordeamistades = GestorDeAmistades();
  final SocialRepository repository = SocialRepository();

  @override
  void initState() {
    super.initState();
    _cargarAmistadesIniciales();
  }

  void _cargarAmistadesIniciales() async {
    try {
      await _gestordeamistades.cargarAmistades(widget.currentUser);
      setState(() {});
    } catch (e) {
      print("Error loading friendships: $e");
    }
  }

  void _addFriendship() async {
    final text = _controller.text;
    if (text.isNotEmpty) {
      try {
        await _gestordeamistades.agregarAmistad(Amistad(id: null, usuario: widget.currentUser, amistadCon: text));
        _controller.clear();
      } catch (e) {
        print("Error adding friendship: $e");
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestor de Amigos'),
        actions: [
          IconButton(
            icon: Icon(Icons.task),
            tooltip: 'Tareas',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PantallaPrincipal(currentUser: widget.currentUser)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PantallaInicial()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter new friendship',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    final amigo = _controller.text;

                    final existeAmigo = await repository.userExists(amigo);
                    if(!existeAmigo || amigo == widget.currentUser){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Correo no existente')),
                      );
                      return;
                    }

                    _addFriendship();
                  }
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _gestordeamistades.amistades
                  .map((amistad) => Card(
                child: WidgetMostrarAmigo(
                  amistad: amistad,
                  gestor: _gestordeamistades,
                  currentUser: widget.currentUser,
                  onUpdate: () => setState(() {}),
                ),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}