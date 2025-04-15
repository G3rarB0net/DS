import 'package:tuple/tuple.dart';
import 'filtro.dart';

class FiltroTLDCorreo implements Filtro {
  @override
  Tuple2<bool, String> validar(String input) {
    final partes = input.split('@');
    if (partes.length != 2) {
      return const Tuple2(false, 'Formato de correo inválido');
    }

    final dominioCompleto = partes[1];
    final subPartes = dominioCompleto.split('.');
    if (subPartes.length < 2) {
      return const Tuple2(false, 'El dominio debe contener un TLD');
    }

    final tld = subPartes.last;
    if (!RegExp(r'^[a-zA-Z]{2,}$').hasMatch(tld)) {
      return const Tuple2(false, 'TLD del correo inválido');
    }

    return const Tuple2(true, '');
  }
}
