import 'tareaCompuesta.dart';
import 'tareaSimple.dart';

abstract class Tarea {
  int? get id;
  String get descripcion;
  bool get completada;
  List<String> get usuarios;
  int? get tareaPadreId;


  void mostrar();
  void set completada(bool value);
  List<Tarea> getSubcomponentes();

  Map<String, dynamic> toJson();

  factory Tarea.fromJson(Map<String, dynamic> json) {
    List<dynamic>? subtareasJson = json['subtareas'];

    if (subtareasJson == null || subtareasJson.isEmpty) {
      return TareaSimple.fromJson(json);
    } else {
      return TareaCompuesta.fromJson(json);
    }
  }
}
