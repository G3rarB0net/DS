
import 'filtros.dart';
import 'package:tuple/tuple.dart';

class CadenaFiltros {
  final List<Filtro> _filtros = [];

  void agregarFiltro(Filtro filtro) {
    _filtros.add(filtro);
  }

  Tuple2<bool, String> ejecutarCadena(String input) {
    for (var filtro in _filtros) {
      final resultado = filtro.validar(input);
      if (!resultado.item1) {
        return resultado;
      }
    }
    return const Tuple2(true, 'Todo correcto');
  }
}