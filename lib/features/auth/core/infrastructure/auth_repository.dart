import 'package:sumeer/features/auth/core/domain/user_model.dart';
import 'package:sumeer/features/auth/core/infrastructure/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Stream<UserEntity?> authStateChanges() =>
      _authService.authStateChanges().map((event) => event != null
          ? UserEntity(uid: event.uid, email: event.email ?? '')
          : null);

  Future<void> signInAnonymously() => _authService.signInAnonymously();
}
