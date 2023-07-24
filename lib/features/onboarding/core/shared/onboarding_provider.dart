import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../onboarding_feat.dart';

final onboardingLocalService = Provider(
  (ref) => OnboardingLocalService(),
);

final onboardingRepository = Provider(
  (ref) => OnboardingRepository(
    ref.watch(onboardingLocalService),
  ),
);

final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>(
  (ref) => OnboardingNotifier(
    ref.watch(onboardingRepository),
  ),
);
