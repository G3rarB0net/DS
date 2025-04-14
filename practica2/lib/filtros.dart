import 'package:tuple/tuple.dart';

abstract class Filtro {
  Tuple2<bool, String> validar(String input);
}

class FiltroCorreo implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    // Validación simple del correo electrónico
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(input)) {
      return const Tuple2(false, 'Correo electrónico inválido');
    }
    return const Tuple2(true, 'Correo electrónico válido');
  }
}

class FiltroContrasena implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    if (input.length < 8) {
      return const Tuple2(false, 'La contraseña debe tener al menos 8 caracteres');
    }

    if (!RegExp(r'[A-Za-z]').hasMatch(input)) {
      return const Tuple2(false, 'Debe contener al menos una letra');
    }


    if (!RegExp(r'[0-9]').hasMatch(input)) {
      return const Tuple2(false, 'Debe contener al menos un número');
    }

    if (!RegExp(r'[A-Z]').hasMatch(input)) {
      return const Tuple2(false, 'Debe tener al menos una letra mayúscula');
    }

    return const Tuple2(true, 'Contraseña válida');
  }
}
