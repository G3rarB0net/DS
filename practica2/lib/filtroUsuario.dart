import 'package:tuple/tuple.dart';
import 'filtro.dart';

class FiltroUsuarioCorreo implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    final partes = input.split('@');
    if (partes.length != 2) {
      return const Tuple2(false, 'El correo debe contener un "@"');
    }

    final usuario = partes[0];
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+$').hasMatch(usuario)) {
      return const Tuple2(false, 'Parte antes del @ inválido');
    }

    return const Tuple2(true, '');
  }
}