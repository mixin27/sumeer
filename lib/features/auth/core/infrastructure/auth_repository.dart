import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:sumeer/features/auth/core/domain/user_model.dart';
import 'package:sumeer/features/auth/core/infrastructure/auth_service.dart';
import 'package:sumeer/utils/logger/logger.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Stream<UserEntity?> authStateChanges() =>
      _authService.authStateChanges().map((event) => event != null
          ? UserEntity(uid: event.uid, email: event.email ?? '')
          : null);

  Future<void> signInAnonymously() => _authService.signInAnonymously();

  Future<Either<String, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authService.signInWithEmailAndPassword(
          email: email, password: password);
      dLog('UserCredential: $result');

      if (result.user == null) return left('User is not logged in.');

      final user =
          UserEntity(uid: result.user!.uid, email: result.user!.email ?? '');

      return right(user);
    } on FirebaseException catch (e) {
      return left(e.message ?? e.toString());
    }
  }

  Future<Either<String, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authService.signUpWithEmailAndPassword(
          email: email, password: password);
      dLog('UserCredential: $result');

      if (result.user == null) return left('User is not created');

      final user =
          UserEntity(uid: result.user!.uid, email: result.user!.email ?? '');

      return right(user);
    } on FirebaseException catch (e) {
      return left(e.message ?? e.toString());
    }
  }
}
