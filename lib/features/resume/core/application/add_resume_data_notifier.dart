import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/features.dart';

part 'add_resume_data_notifier.freezed.dart';

@freezed
class AddResumeDataState with _$AddResumeDataState {
  const factory AddResumeDataState.initial() = _Initial;
  const factory AddResumeDataState.loading() = _Loading;
  const factory AddResumeDataState.success(String resumeId) = _Success;
  const factory AddResumeDataState.error(String error) = _Error;
}

class AddResumeDataNotifier extends StateNotifier<AddResumeDataState> {
  final ResumeRepository _repository;

  AddResumeDataNotifier(this._repository)
      : super(const AddResumeDataState.initial());

  Future<void> addResume({
    required String userId,
    required ResumeData resumeData,
  }) async {
    state = const AddResumeDataState.loading();

    final result =
        await _repository.addResumeData(userId: userId, resumeData: resumeData);

    state = result.fold(
      (l) => AddResumeDataState.error(l),
      (r) => AddResumeDataState.success(r),
    );
  }
}
