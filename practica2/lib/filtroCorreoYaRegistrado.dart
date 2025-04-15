import 'package:tuple/tuple.dart';
import 'filtro.dart';

class FiltroCorreoYaRegistrado implements Filtro {
  final List<String> _correosExistentes;

  FiltroCorreoYaRegistrado(this._correosExistentes);

  @override
  Tuple2<bool, String> validar(String input) {
    if (_correosExistentes.contains(input.trim())) {
      return const Tuple2(false, 'El correo ya está registrado');
    }
    return const Tuple2(true, '');
  }
}
