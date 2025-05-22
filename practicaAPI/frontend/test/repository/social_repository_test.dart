import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repository/social_repository.dart';

void main() {
  group('SocialRepository', () {
    final repo = SocialRepository();

    test('register user', () {
      final user = User( email: 'user@gmail.com', password: 'Password123');
      repo.createUser(user);
      final result = repo.userExists('user@gmail.com');
      expect(result, true);
    });

    test('login user', () {
      final user = User (email: 'login@gmail.com', password: 'Loginpass5');
      repo.createUser(user);
      final loginSuccess = repo.loginUser('login@example.com', 'Loginpass5');
      expect(loginSuccess, true);
    });

    test('login fails with incorrect password', () {
      final user = User( email: 'fail@gmail.com', password: 'Rightpass5');
      repo.createUser(user);
      final loginFail = repo.loginUser('fail@gmail.com', 'Wrongpass5');
      expect(loginFail, false);
    });
  });
}
