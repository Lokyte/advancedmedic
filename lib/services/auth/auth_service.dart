import 'package:advancedmedic/services/auth/auth_user.dart';
import 'package:advancedmedic/services/auth_user.dart';

abstract class AuthProvider {
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<AuthUser> login({required String email, required String password});

  Future<void> logout();

  Future<void> sendEmailVerification();

  AuthUser? get currentUser;
}

class AuthService implements AuthProvider {
  final AuthProvider provider;

  AuthService(this.provider);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      return await provider.createUser(email: email, password: password);
    } catch (e) {
      // Handle or rethrow the exception
      rethrow; // Rethrow the original exception
    }
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      return await provider.login(email: email, password: password);
    } catch (e) {
      // Handle or rethrow the exception
      rethrow; // Rethrow the original exception
    }
  }

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  AuthUser? get currentUser => provider.currentUser;
}
