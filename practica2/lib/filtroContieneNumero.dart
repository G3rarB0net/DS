import 'package:tuple/tuple.dart';
import 'filtro.dart';

class FiltroContieneNumero implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    if (!RegExp(r'[0-9]').hasMatch(input)) {
      return const Tuple2(false, 'La contraseña debe contener al menos un número');
    }
    return const Tuple2(true, '');
  }
}
