import 'dart:convert';
import 'package:frontend/task/tarea.dart';
import 'package:http/http.dart' as http;

class GestorDeTareas {
  List<Tarea> tareas = [];
  final String apiUrl = "http://localhost:3000/tareas";

  Future<void> cargarTareas(String usuario) async {
    final response = await http.get(Uri.parse('$apiUrl?usuario=$usuario'));

    if (response.statusCode == 200) {
      List<dynamic> tareasJson = json.decode(response.body);
      tareas.clear();
      tareas = tareasJson.map((json) => Tarea.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar tareas');
    }
  }

  Future<void> agregarTarea(Tarea tarea) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(tarea.toJson()),
    );

    if (response.statusCode == 201) {
      tareas.add(Tarea.fromJson(json.decode(response.body)));
    } else {
      throw Exception('Error al agregar tarea: ${response.body}');
    }
  }

  Future<void> eliminarTarea(Tarea tarea) async {
    if (tarea.id == null) return;
    final response = await http.delete(Uri.parse('$apiUrl/${tarea.id}'));

    if (response.statusCode == 200) {
      tareas.removeWhere((t) => t.id == tarea.id);
      //se buscan las taeas con idPadre = id de la tarea actual y de manera recursiva se eliminan
      List<Tarea> subtareas = tareas.where((t) => t.tareaPadreId == tarea.id).toList();
      for (var sub in subtareas) {
        // Eliminar cada subtarea de manera recursiva
        await eliminarTarea(sub);
      }
    } else {
      throw Exception('Error al eliminar tarea');
    }
  }

  Future<void> marcarCompletada(Tarea tarea) async {
    if (tarea.id == null) return;
    final nuevoEstado = !(tarea.completada ?? false);

    final response = await http.patch(
      Uri.parse('$apiUrl/${tarea.id}'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'completada': nuevoEstado}),
    );

    if (response.statusCode == 200) {
      tarea.completada = nuevoEstado;

      //Se buscan las tareas con idPadre = id de la tareac actual y de manera recursiva se marcan como completadas
      List<Tarea> subtareas = tareas.where((t) => t.tareaPadreId == tarea.id).toList();
      for (var sub in subtareas) {
        // Marcar cada subtarea con el nuevo estado (recursivo)
        await marcarCompletada(sub);
      }
    } else {
      throw Exception('Error al marcar tarea como completada');
    }
  }
}
