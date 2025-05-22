import 'tarea.dart';

class TareaSimple implements Tarea {
  @override final int? id;
  @override final String descripcion;
  @override final List<String> usuarios;
  bool _completada;
  @override final int? tareaPadreId;

  TareaSimple({
    required this.id,
    required this.descripcion,
    required bool completada,
    required this.usuarios,
    this.tareaPadreId,
  }): _completada = completada;

  @override
  bool get completada => _completada;

  @override
  set completada(bool value) {
    _completada = value;
  }

  @override
  void mostrar() {
    print("- $descripcion (Usuarios: ${usuarios.join(', ')})");
  }

  @override
  List<Tarea> getSubcomponentes() => [];

  factory TareaSimple.fromJson(Map<String, dynamic> json) {
    List<String> usuariosList = [];

    if (json['users'] != null && json['users'] is List) {
      usuariosList = (json['users'] as List)
          .where((usuario) => usuario is Map && usuario.containsKey('email'))
          .map((usuario) => usuario['email'] as String)
          .toList();
    }

    return TareaSimple(
      id: json['id'],
      descripcion: json['descripcion'],
      completada: json['completada'],
      usuarios: usuariosList,
      tareaPadreId: json['tarea_padre_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'descripcion': descripcion,
      'completada': completada,
      'users': usuarios,
      'tarea_padre_id': tareaPadreId,
    };
  }

}
