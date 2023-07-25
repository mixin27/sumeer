import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/feat_auth.dart';

part 'sign_up_notifier.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.loading() = _Loading;
  const factory SignUpState.success(UserEntity user) = _Success;
  const factory SignUpState.error(String error) = _Error;
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  final AuthRepository _repository;

  SignUpNotifier(this._repository) : super(const SignUpState.initial());

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const SignUpState.loading();

    final result = await _repository.signUpWithEmailAndPassword(
        email: email, password: password);

    state = result.fold(
      (l) => SignUpState.error(l),
      (r) => SignUpState.success(r),
    );
  }
}
