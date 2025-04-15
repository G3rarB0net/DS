import 'package:tuple/tuple.dart';
import 'filtro.dart';

class FiltroLongitudMinima implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    if (input.length < 8) {
      return const Tuple2(false, 'La contraseña debe tener al menos 8 caracteres');
    }
    return const Tuple2(true, '');
  }
}