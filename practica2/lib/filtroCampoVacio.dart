import 'package:tuple/tuple.dart';
import 'filtro.dart';

class FiltroCampoVacio implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    if (input.trim().isEmpty) {
      return const Tuple2(false, 'El campo no puede estar vacío');
    }
    return const Tuple2(true, '');
  }
}
