import 'email_filter.dart';
import 'password_filter.dart';

String? validateUser(String email, String password) {
  final emailFilter = EmailFilter();
  final passwordFilter = PasswordFilter();

  emailFilter.linkWith(passwordFilter);
  return emailFilter.check(email, password);
}
