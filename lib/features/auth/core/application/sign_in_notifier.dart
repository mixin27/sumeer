import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/feat_auth.dart';

part 'sign_in_notifier.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;
  const factory SignInState.loading() = _Loading;
  const factory SignInState.success(UserEntity user) = _Success;
  const factory SignInState.error(String error) = _Error;
}

class SignInNotifier extends StateNotifier<SignInState> {
  final AuthRepository _repository;

  SignInNotifier(this._repository) : super(const SignInState.initial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const SignInState.loading();

    final result = await _repository.signInWithEmailAndPassword(
        email: email, password: password);

    state = result.fold(
      (l) => SignInState.error(l),
      (r) => SignInState.success(r),
    );
  }
}
