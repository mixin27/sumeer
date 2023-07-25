import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/feat_auth.dart';

final signUpPasswordVisibleProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final signUpNotifierProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, SignUpState>((ref) {
  return SignUpNotifier(ref.watch(authRepositoryProvider));
});
