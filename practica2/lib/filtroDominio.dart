import 'package:tuple/tuple.dart';
import 'filtro.dart';

class FiltroDominioCorreo implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    final partes = input.split('@');
    if (partes.length != 2) {
      return const Tuple2(false, 'Formato de correo inválido');
    }

    final dominioCompleto = partes[1];
    if (dominioCompleto.isEmpty) {
      return const Tuple2(false, 'El dominio no puede estar vacío');
    }
    final subPartes = dominioCompleto.split('.');

    final dominio = subPartes[0];
    if (!RegExp(r'^[a-zA-Z0-9.-]+$').hasMatch(dominio)) {
      return const Tuple2(false, 'Dominio del correo inválido');
    }

    return const Tuple2(true, '');
  }
}
