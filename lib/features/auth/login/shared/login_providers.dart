import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/feat_auth.dart';

final passwordVisibleProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final signInNotifierProvider =
    StateNotifierProvider.autoDispose<SignInNotifier, SignInState>((ref) {
  return SignInNotifier(ref.watch(authRepositoryProvider));
});
