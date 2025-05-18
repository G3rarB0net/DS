import 'filter.dart';

class EmailFilter extends Filter {
  @override
  bool check(String email, String password) {
    if (!email.contains('@')) return false;
    return next?.check(email, password) ?? true;
  }
}
