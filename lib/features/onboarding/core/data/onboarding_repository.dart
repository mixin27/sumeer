import 'package:sumeer/features/onboarding/core/data/onboarding_local_service.dart';
import 'package:dartz/dartz.dart';

class OnboardingRepository {
  final OnboardingLocalService _localService;

  OnboardingRepository(this._localService);

  Future<String?> getOnboardingLocalData() async {
    return _localService.read();
  }

  Future<bool> isDoneOnboarding() async {
    return getOnboardingLocalData().then((value) => value != null);
  }

  Future<Either<String, Unit>> onboardingShownOrNot() async {
    final isShown = await _localService.save();
    if (isShown) {
      return right(unit);
    } else {
      return left('Cannot save onboarding status to prefs');
    }
  }
}
