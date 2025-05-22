import 'tarea.dart';

class TareaCompuesta implements Tarea {
  @override final int? id;
  @override final String descripcion;
  bool _completada;
  @override final List<String> usuarios;
  @override final int? tareaPadreId;

  final List<Tarea> _subtareas;

  TareaCompuesta({
    required this.id,
    required this.descripcion,
    required bool completada,
    required this.usuarios,
    this.tareaPadreId,
    List<Tarea>? subtareas,
  }) : _completada = completada,
        _subtareas = subtareas ?? [];


  @override
  bool get completada => _completada;

  @override
  set completada(bool value) {
    _completada = value;
  }


  void agregar(Tarea componente) {
    _subtareas.add(componente);
  }

  void eliminar(Tarea componente) {
    _subtareas.remove(componente);
  }

  @override
  void mostrar() {
    print("+ $descripcion (Usuarios: ${usuarios.join(', ')})");
    for (var sub in _subtareas) {
      sub.mostrar();
    }
  }

  @override
  List<Tarea> getSubcomponentes() => _subtareas;

  factory TareaCompuesta.fromJson(Map<String, dynamic> json) {
    List<String> usuariosList = [];

    if (json['users'] != null) {
      usuariosList = (json['users'] as List)
          .map((usuario) => usuario['email'] as String)
          .toList();
    }

    return TareaCompuesta(
      id: json['id'],
      descripcion: json['descripcion'],
      completada: json['completada'],
      usuarios:usuariosList,
      tareaPadreId: json['tarea_padre_id'],
      subtareas: (json['subtareas'] as List<dynamic>?)
          ?.map((e) => Tarea.fromJson(e))
          .toList() ??
          [],
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
      'subtareas': _subtareas.map((e) => e.toJson()).toList(),
    };
  }

}
