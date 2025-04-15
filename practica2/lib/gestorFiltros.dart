import 'package:tuple/tuple.dart';
import 'cadenaFiltros.dart';
import 'filtro.dart';

class GestorFiltros {
  final CadenaFiltros _cadenaFiltros = CadenaFiltros();

  void agregarFiltro(Filtro filtro) {
    _cadenaFiltros.agregarFiltro(filtro);
  }

  Tuple2<bool, String> ejecutarCadena(String dato) {
    return _cadenaFiltros.ejecutarCadena(dato);
  }
}
