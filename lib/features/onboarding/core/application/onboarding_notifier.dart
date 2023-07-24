import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/onboarding_repository.dart';

part 'onboarding_notifier.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial() = _Initial;
  const factory OnboardingState.progress() = _Progress;
  const factory OnboardingState.done({bool? toMain}) = _Done;
  const factory OnboardingState.notYet() = _NotYet;
  const factory OnboardingState.failure(String message) = _Failure;
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final OnboardingRepository _repository;

  OnboardingNotifier(this._repository) : super(const OnboardingState.initial());

  Future<void> checkOnboardingStatus({bool toMain = true}) async {
    final status = await _repository.isDoneOnboarding();
    state = status
        ? OnboardingState.done(toMain: toMain)
        : const OnboardingState.notYet();
  }

  Future<void> markAsShown({bool toMain = true}) async {
    state = const OnboardingState.progress();

    final failureOrSuccess = await _repository.onboardingShownOrNot();
    state = failureOrSuccess.fold(
      (l) => OnboardingState.failure(l),
      (r) => OnboardingState.done(toMain: toMain),
    );
  }
}
