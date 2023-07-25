import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:sumeer/features/auth/core/domain/user_model.dart';
import 'package:sumeer/features/auth/core/infrastructure/auth_repository.dart';
import 'package:sumeer/features/auth/core/infrastructure/auth_service.dart';
import 'package:sumeer/shared/shared.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref.watch(firebaseAuthProvider));
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.read(authServiceProvider));
}

@riverpod
Stream<UserEntity?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

@Riverpod(keepAlive: true)
List<AuthProvider<AuthListener, AuthCredential>> authProviders(
    AuthProvidersRef ref) {
  return [
    EmailAuthProvider(),
    GoogleProvider(
      clientId:
          '604374980802-65ptl7b0u9s863qht7kfmr9dmqqof2v6.apps.googleusercontent.com',
    ),
  ];
}
