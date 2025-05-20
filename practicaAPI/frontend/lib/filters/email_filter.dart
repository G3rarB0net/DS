import 'filter.dart';

class EmailFilter extends Filter {
  @override
  String? check(String email, String password) {
    // Patrón: texto@dominio.extensión
    final regex = RegExp(r'^[^@]+@[^@]+\.(com|net|org|es|edu|gov|io)$');

    if (!regex.hasMatch(email)){
      return "Formato de email inválido. Por favor compruebe que su email tiene el formato correcto";
    }

    return next?.check(email, password);
  }
}
