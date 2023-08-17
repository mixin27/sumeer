import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

part 'upsert_resume_data_notifier.freezed.dart';

@freezed
class UpsertResumeDataState with _$UpsertResumeDataState {
  const factory UpsertResumeDataState.initial() = _Initial;
  const factory UpsertResumeDataState.loading() = _loading;
  const factory UpsertResumeDataState.success(String resumeId) = _Success;
  const factory UpsertResumeDataState.error(String error) = _Error;
}

class UpsertResumeDataNotifier extends StateNotifier<UpsertResumeDataState> {
  final ResumeRepository _repository;

  UpsertResumeDataNotifier(this._repository)
      : super(const UpsertResumeDataState.initial());

  Future<void> upsertResumeData({
    required String userId,
    required ResumeData resumeData,
    String? resumeDocId,
  }) async {
    state = const UpsertResumeDataState.loading();

    final result = await _repository.updateOrInsertResumeData(
      userId: userId,
      resumeData: resumeData,
      resumeDocId: resumeDocId,
    );

    state = result.fold(
      (l) => UpsertResumeDataState.error(l),
      (r) => UpsertResumeDataState.success(r),
    );
  }
}
