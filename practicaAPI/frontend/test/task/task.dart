import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/task/tareaCompuesta.dart';
import 'package:frontend/task/tareaSimple.dart';

void main() {
  group('TareaCompuesta', () {
    test('agregar subtarea', () {
      final compuesta = TareaCompuesta(id: 1, descripcion: 'tareaPrueba', completada: false, usuarios: ['usuario1', 'usuario2']);
      final subtarea = TareaSimple(id: 2, descripcion: 'subtareaPrueba', completada: false, usuarios: ['usuario3']);
      final subtarea2 = TareaSimple(id: 3, descripcion: 'subtareaPrueba2', completada: false, usuarios: ['usuario4']);
      compuesta.agregar(subtarea);
      compuesta.agregar(subtarea2);
      expect(compuesta.getSubcomponentes().length, 2);

    });


    test('completar todas las subtareas marca la tarea como completada', () {
      final compuesta = TareaCompuesta(id: 1, descripcion: 'tareaPrueba', completada: false, usuarios: ['usuario1', 'usuario2']);
      final subtarea = TareaSimple(id: 2, descripcion: 'subtareaPrueba', completada: false, usuarios: ['usuario3']);
      compuesta.agregar(subtarea);
      compuesta.completada = true;
      expect(compuesta.completada, true);
    });
  });
}
