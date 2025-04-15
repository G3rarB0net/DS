import 'package:tuple/tuple.dart';
import 'filtro.dart';

class FiltroCaracterEspecial implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(input)) {
      return const Tuple2(false, 'La contraseña debe contener al menos un carácter especial');
    }
    return const Tuple2(true, '');
  }
}
