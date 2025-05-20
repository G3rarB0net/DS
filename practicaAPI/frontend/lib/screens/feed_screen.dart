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


class TaskWidget extends StatefulWidget {
  final Tarea tarea;
  final GestorDeTareas gestor;
  final String currentUser;
  final Function() onUpdate;

  TaskWidget({
    required this.tarea,
    required this.gestor,
    required this.currentUser,
    required this.onUpdate,
  });

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool showSubtaskField = false;
  final TextEditingController _subtaskController = TextEditingController();

  List<Tarea> get subtareas => widget.gestor.tareas
      .where((t) => t.tareaPadreId == widget.tarea.id)
      .toList();

  void _addSubtask() async {
    final texto = _subtaskController.text;
    if (texto.isNotEmpty && widget.tarea.id != null) {
      await widget.gestor.agregarTarea(TareaSimple(
        id: null,
        descripcion: texto,
        completada: false,
        usuario: widget.currentUser,
        tareaPadreId: widget.tarea.id,
      ));
      _subtaskController.clear();
      widget.onUpdate();
    }
  }

  void _toggleCompleted() async {
    await widget.gestor.marcarCompletada(widget.tarea);
    widget.onUpdate();
  }

  void _deleteTask() async {
    await widget.gestor.eliminarTarea(widget.tarea);
    widget.onUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0 * (widget.tarea.tareaPadreId != null ? 1 : 0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

               ListTile(
                title: Text(
                  widget.tarea.descripcion ?? "Sin descripción",
                  style: TextStyle(
                    fontStyle: widget.tarea.tareaPadreId != null ? FontStyle.italic : null,
                    decoration: widget.tarea.completada == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: _toggleCompleted,
                      color: widget.tarea.completada == true ? Colors.green : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: _deleteTask,
                      color: Colors.red,
                    ),
                    IconButton(
                      icon: Icon(showSubtaskField ? Icons.close : Icons.add),
                      onPressed: () {
                        setState(() {
                          showSubtaskField = !showSubtaskField;
                        });
                      },
                      tooltip: "Añadir subtarea",
                    ),
                  ],
                ),
              ),

            if (showSubtaskField)
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _subtaskController,
                        decoration: InputDecoration(
                          labelText: 'Nueva subtarea',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _addSubtask,
                    )
                  ],
                ),
              ),
            // Recursivamente mostrar subtareas
            ...subtareas.map((sub) => TaskWidget(
              tarea: sub,
              gestor: widget.gestor,
              currentUser: widget.currentUser,
              onUpdate: widget.onUpdate,
            )),
          ],
        ),

    );
  }
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
            child: ListView(
              children: _gestorDeTareas.tareas
                  .where((t) => t.tareaPadreId == null)
                  .map((tarea) => Card(
                    child: TaskWidget(
                    tarea: tarea,
                    gestor: _gestorDeTareas,
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
