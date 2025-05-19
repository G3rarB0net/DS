import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/social_repository.dart';
import 'package:frontend/task/tarea.dart';

import '../task/GestorDeTareas.dart';
import '../task/tareaSimple.dart';

class FeedScreen extends StatefulWidget {
  final String currentUser;

  FeedScreen({required this.currentUser});
  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<FeedScreen> {
  final TextEditingController _controller = TextEditingController();
  final GestorDeTareas _gestorDeTareas = GestorDeTareas();


  @override
  void initState() {
    super.initState();
    _cargarTareasIniciales();
  }

  void _cargarTareasIniciales() async {
    try {
      await _gestorDeTareas.cargarTareas(widget.currentUser);
      setState(() {});
    } catch (e) {
      print("Error loading tasks: $e");
    }
  }


  void _addTask() async {
    final text = _controller.text;
    if (text.isNotEmpty) {
      try {
        await _gestorDeTareas.agregarTarea(TareaSimple(id: null, descripcion: text, completada: false, usuario: widget.currentUser, tareaPadreId: null));
        _controller.clear();
      } catch (e) {
        print("Error adding task: $e");
      }
      setState(() {});
    }
  }

  void _markTaskCompleted(Tarea tarea) async {
    try {
      await _gestorDeTareas.marcarCompletada(tarea);
    } catch (e) {
      print("Error marking task completed: $e");
    }
    setState(() {});
  }

  void _deleteTask(Tarea tarea) async {
    try {
      await _gestorDeTareas.eliminarTarea(tarea);
    } catch (e) {
      print("Error deleting task: $e");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter new task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _gestorDeTareas.tareas.length,
              itemBuilder: (context, index) {
                final tarea = _gestorDeTareas.tareas[index];
                return ListTile(
                  title: Text(
                    tarea.descripcion ?? "No description",
                    style: TextStyle(
                      decoration: tarea.completada ?? false ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () => _markTaskCompleted(tarea),
                        color: tarea.completada ?? false ? Colors.green : null,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTask(tarea),
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
