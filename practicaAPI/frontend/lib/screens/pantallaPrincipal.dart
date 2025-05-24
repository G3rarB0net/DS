import 'package:flutter/material.dart';
import 'package:frontend/task/tarea.dart';
import '../task/GestorDeTareas.dart';
import '../task/tareaSimple.dart';
import 'package:frontend/friend/GestorDeAmistades.dart';
import 'pantallaInicial.dart';
import 'pantallaAmigos.dart';

class PantallaPrincipal extends StatefulWidget {
  final String currentUser;

  PantallaPrincipal({required this.currentUser});
  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}


class WidgetMostrarTarea extends StatefulWidget {
  final Tarea tarea;
  final GestorDeTareas gestor;
  final String currentUser;
  final Function() onUpdate;

  WidgetMostrarTarea({
    required this.tarea,
    required this.gestor,
    required this.currentUser,
    required this.onUpdate,
  });

  @override
  _WidgetMostrarTareaState createState() => _WidgetMostrarTareaState();
}

class _WidgetMostrarTareaState extends State<WidgetMostrarTarea> {
  bool showSubtaskField = false;
  final TextEditingController _subtaskController = TextEditingController();

  List<Tarea> get subtareas => widget.gestor.tareas
      .where((t) => t.tareaPadreId == widget.tarea.id)
      .toList();

  void _addSubtask() async {
    List<String> eliminaresto = [];
    final texto = _subtaskController.text;
    if (texto.isNotEmpty && widget.tarea.id != null) {
      List<String>usuarios = widget.tarea.usuarios ?? [];
      print(usuarios);
      print(widget.tarea.usuarios);
      final usuariosParaTarea = <String>{
        widget.currentUser,
        ...usuarios,
      }.toList();

      await widget.gestor.agregarTarea(TareaSimple(
        id: null,
        descripcion: texto,
        completada: false,
        usuarios: usuariosParaTarea,
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
            ...subtareas.map((sub) => WidgetMostrarTarea(
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


class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final TextEditingController _controller = TextEditingController();
  final GestorDeTareas _gestorDeTareas = GestorDeTareas();
  final GestorDeAmistades _gestordeamistades = GestorDeAmistades();

  List<String> colaboradoresSeleccionados = [];

  void _mostrarPopupSeleccionAmigos() async {
    List<String> seleccionTemp = List.from(colaboradoresSeleccionados);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar colaboradores'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialogState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: _gestordeamistades.amistades.map((amigo) {
                    return CheckboxListTile(
                      title: Text(amigo.amistadCon),
                      value: seleccionTemp.contains(amigo.amistadCon),
                      onChanged: (bool? seleccionado) {
                        setDialogState(() {
                          if (seleccionado == true) {
                            seleccionTemp.add(amigo.amistadCon);
                          } else {
                            seleccionTemp.remove(amigo.amistadCon);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  colaboradoresSeleccionados = List.from(seleccionTemp);
                });
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _cargarTareasIniciales();
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
      final usuariosParaTarea = <String>{
        widget.currentUser,
        ...colaboradoresSeleccionados,
      }.toList();
      try {
        await _gestorDeTareas.agregarTarea(
            TareaSimple(
              id: null,
              descripcion: text,
              completada: false,
              usuarios: usuariosParaTarea,
              tareaPadreId: null
            )
        );
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
        title: Text('Bienvenido ${widget.currentUser}'),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            tooltip: 'Amistades',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PantallaAmigos(currentUser: widget.currentUser)),
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
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descripción nueva tarea',
                  ),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: _mostrarPopupSeleccionAmigos,
                  child: Text('Seleccionar colaboradores (${colaboradoresSeleccionados.length})'),
                ),


                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Crear tarea principal'),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: _gestorDeTareas.tareas
                  .where((t) => t.tareaPadreId == null)
                  .map((tarea) => Card(
                child: WidgetMostrarTarea(
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
