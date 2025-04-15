import 'package:tuple/tuple.dart';
import 'filtro.dart';

class FiltroContieneLetra implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    if (!RegExp(r'[A-Za-z]').hasMatch(input)) {
      return const Tuple2(false, 'La contraseña debe contener al menos una letra');
    }
    return const Tuple2(true, '');
  }
}