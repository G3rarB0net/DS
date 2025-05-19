import 'tarea.dart';

class TareaSimple implements Tarea {
  @override final int? id;
  @override final String descripcion;
  bool _completada;
  @override final String usuario;
  @override final int? tareaPadreId;

  TareaSimple({
    required this.id,
    required this.descripcion,
    required bool completada,
    required this.usuario,
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
    print("- $descripcion");
  }

  @override
  List<Tarea> getSubcomponentes() => [];

  factory TareaSimple.fromJson(Map<String, dynamic> json) {
    return TareaSimple(
      id: json['id'],
      descripcion: json['descripcion'],
      completada: json['completada'],
      usuario: json['usuario'],
      tareaPadreId: json['tarea_padre_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'descripcion': descripcion,
      'completada': completada,
      'usuario': usuario,
      'tarea_padre_id': tareaPadreId,
    };
  }

}
