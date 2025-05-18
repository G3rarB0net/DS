import 'filter.dart';

class PasswordFilter extends Filter {
  @override
  bool check(String email, String password) {
    if (password.length < 6) return false;
    return next?.check(email, password) ?? true;
  }
}
