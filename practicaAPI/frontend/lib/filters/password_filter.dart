import 'filter.dart';

class PasswordFilter extends Filter {
  @override
  String? check(String email, String password) {
    if (password.length < 8) return 'La contraseña debe tener al menos 8 caracteres.';
    if (!RegExp(r'[A-Z]').hasMatch(password)) return 'Falta al menos una letra mayúscula.';
    if (!RegExp(r'[a-z]').hasMatch(password)) return 'Falta al menos una letra minúscula.';
    if (!RegExp(r'[0-9]').hasMatch(password)) return 'Falta al menos un número.';
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_]').hasMatch(password)) {
      return 'Falta al menos un carácter especial.';
    }

    return next?.check(email, password);
  }
}
