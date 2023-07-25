import 'package:hooks_riverpod/hooks_riverpod.dart';

final signUpPasswordVisibleProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
