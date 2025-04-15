import 'package:tuple/tuple.dart';
import 'filtro.dart';

class FiltroLetraMayuscula implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    if (!RegExp(r'[A-Z]').hasMatch(input)) {
      return const Tuple2(false, 'La contraseña debe tener al menos una letra mayúscula');
    }
    return const Tuple2(true, '');
  }
}
