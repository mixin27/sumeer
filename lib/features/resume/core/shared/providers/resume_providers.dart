import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/shared.dart';

part 'resume_providers.g.dart';

@Riverpod(keepAlive: true)
ResumeRemoteService resumeRemoteService(ResumeRemoteServiceRef ref) {
  return ResumeRemoteService(ref.watch(firebaseFirestoreProvider));
}

@Riverpod(keepAlive: true)
ResumeRepository resumeRepository(ResumeRepositoryRef ref) {
  return ResumeRepository(ref.watch(resumeRemoteServiceProvider));
}

final addResumeDataNotifierProvider =
    StateNotifierProvider<AddResumeDataNotifier, AddResumeDataState>((ref) {
  return AddResumeDataNotifier(ref.watch(resumeRepositoryProvider));
});

final upsertResumeDataNotifierProvider =
    StateNotifierProvider<UpsertResumeDataNotifier, UpsertResumeDataState>(
        (ref) {
  return UpsertResumeDataNotifier(ref.watch(resumeRepositoryProvider));
});

@riverpod
Stream<List<ResumeData>> resumeDataList(ResumeDataListRef ref,
    {required String userId}) async* {
  final repository = ref.read(resumeRepositoryProvider);
  yield* repository.getAllResumeDataStream(userId: userId);
}
