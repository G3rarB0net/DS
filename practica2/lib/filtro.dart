import 'package:tuple/tuple.dart';

abstract class Filtro {
  Tuple2<bool, String> validar(String input);
}



