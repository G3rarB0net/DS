import 'email_filter.dart';
import 'password_filter.dart';

bool validateUser(String email, String password) {
  final emailFilter = EmailFilter();
  final passwordFilter = PasswordFilter();

  emailFilter.linkWith(passwordFilter);
  return emailFilter.check(email, password);
}
