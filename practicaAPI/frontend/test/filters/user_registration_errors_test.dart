import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/filters/email_filter.dart';
import 'package:frontend/filters/password_filter.dart';
import 'package:frontend/filters/account_checker.dart';

void main() {
  group('Validación de usuario', () {
    test('Email válido y contraseña válida -> no devuelve error', () {
      final result = validateUser('usuario@ejemplo.com', 'Passw0rd!');
      expect(result, null);
    });

    test('Email inválido -> devuelve error de email', () {
      final result = validateUser('usuario.com', 'Passw0rd!');
      expect(result, 'Formato de email inválido. Por favor compruebe que su email tiene el formato correcto');
    });

    test('Contraseña corta -> error de longitud', () {
      final result = validateUser('usuario@ejemplo.com', 'Pw0!');
      expect(result, 'La contraseña debe tener al menos 8 caracteres.');
    });

    test('Contraseña sin mayúscula -> error', () {
      final result = validateUser('usuario@ejemplo.com', 'password1!');
      expect(result, 'Falta al menos una letra mayúscula.');
    });

    test('Contraseña sin minúscula -> error', () {
      final result = validateUser('usuario@ejemplo.com', 'PASSWORD1!');
      expect(result, 'Falta al menos una letra minúscula.');
    });

    test('Contraseña sin número -> error', () {
      final result = validateUser('usuario@ejemplo.com', 'Password!');
      expect(result, 'Falta al menos un número.');
    });

    test('Contraseña sin carácter especial -> error', () {
      final result = validateUser('usuario@ejemplo.com', 'Password1');
      expect(result, 'Falta al menos un carácter especial.');
    });
  });
}
