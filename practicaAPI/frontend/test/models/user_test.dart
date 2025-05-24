import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/user.dart';

void main() {
  group('User model', () {
    test('User es creado correctamente', () {
      final user = User( email: 'manu@gmail.com', password: 'Manu123');
      expect(user.email, 'manu@gmail.com');
      expect(user.password, 'Manu123');
    });

    test('User toJson devuelve correcto map', () {
      final user = User( email: 'manu@gmail.com', password: 'Manu123');
      final json = user.toJson();
      expect(json['email'], 'manu@gmail.com');
      expect(json['password'], 'Manu123');
    });
  });
}
