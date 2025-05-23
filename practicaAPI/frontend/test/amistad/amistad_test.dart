import 'package:frontend/friend/amistad.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Amistad', () {
    test('Crear un objeto de Amistad', () {
      final amistad = Amistad(id: 1, usuario: 'juan', amistadCon: 'ana');
      expect(amistad.id, 1);
      expect(amistad.usuario, 'juan');
      expect(amistad.amistadCon, 'ana');
    });

    test('Convertir Amistad a JSON', () {
      final amistad = Amistad(id: 5, usuario: 'luis', amistadCon: 'maria');
      final json = amistad.toJson();

      expect(json['id'], 5);
      expect(json['usuario'], 'luis');
      expect(json['amistadCon'], 'maria');
    });

    test('Convertir Amistad desde JSON', () {
      final json = {
        'id': 10,
        'usuario': 'sofia',
        'amistadCon': 'carlos'
      };

      final amistad = Amistad.fromJson(json);
      expect(amistad.id, 10);
      expect(amistad.usuario, 'sofia');
      expect(amistad.amistadCon, 'carlos');
    });

    test('Mostrar amistad imprime correctamente', () {
      final amistad = Amistad(id: 3, usuario: 'leo', amistadCon: 'nina');
      expect(() => amistad.mostrar(), returnsNormally);
    });

    test('toJson no incluye id si es null', () {
      final amistad = Amistad(id: null, usuario: 'andres', amistadCon: 'lucia');
      final json = amistad.toJson();

      expect(json.containsKey('id'), false);
      expect(json['usuario'], 'andres');
      expect(json['amistadCon'], 'lucia');
    });
  });
}
