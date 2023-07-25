import 'package:hooks_riverpod/hooks_riverpod.dart';

final passwordVisibleProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
