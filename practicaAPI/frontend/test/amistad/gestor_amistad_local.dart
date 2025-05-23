import 'package:frontend/friend/amistad.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/friend/GestorDeAmistades.dart';

void main() {
  group('GestorDeAmistades (estructura)', () {
    test('Agregar amistad localmente', () {
      final gestor = GestorDeAmistades();
      final amistad = Amistad(id: 1, usuario: 'ana', amistadCon: 'juan');
      gestor.agregarAmistad(amistad );

      expect(gestor.amistades.length, 1);
      expect(gestor.amistades.first.usuario, 'ana');
    });

    test('Eliminar amistad localmente por ID', () {
      final gestor = GestorDeAmistades();
      final amistad = Amistad(id: 2, usuario: 'roberto', amistadCon: 'nora');
      gestor.agregarAmistad(amistad);
      gestor.eliminarAmistad(amistad);

      expect(gestor.amistades.length, 0);
    });

    test('Limpiar lista de amistades', () {
      final gestor = GestorDeAmistades();
      gestor.amistades.addAll([
        Amistad(id: 1, usuario: 'uno', amistadCon: 'dos'),
        Amistad(id: 2, usuario: 'tres', amistadCon: 'cuatro'),
      ]);

      gestor.amistades.clear();
      expect(gestor.amistades.isEmpty, true);
    });
  });
}
