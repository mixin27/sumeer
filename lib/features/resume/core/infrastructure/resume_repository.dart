import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/utils/logger/logger.dart';

class ResumeRepository {
  final ResumeRemoteService _remoteService;

  ResumeRepository(this._remoteService);

  Future<Either<String, String>> addResumeData({
    required String userId,
    required ResumeData resumeData,
  }) async {
    try {
      final result = await _remoteService.addResumeData(
        userId: userId,
        resumeData: ResumeDataDto.fromDomain(resumeData),
      );
      tLog("Resume document id: $result");
      return right(result);
    } on FirebaseException catch (e) {
      return left(e.message ?? e.toString());
    }
  }

  Future<Either<String, String>> updateOrInsertResumeData({
    required String userId,
    required ResumeData resumeData,
    String? resumeDocId,
  }) async {
    try {
      final result = await _remoteService.updateOrInsertResumeData(
        userId: userId,
        resumeData: ResumeDataDto.fromDomain(resumeData),
        resumeDocId: resumeDocId,
      );
      tLog("Resume document id: $result");
      return right(result);
    } on FirebaseException catch (e) {
      return left(e.message ?? e.toString());
    }
  }

  Future<Either<String, Unit>> removeResumeData({
    required String userId,
    required String resumeDocId,
  }) async {
    try {
      await _remoteService.removeResumeData(
        userId: userId,
        resumeDocId: resumeDocId,
      );
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e.message ?? e.toString());
    }
  }

  Stream<List<ResumeData>> getAllResumeDataStream({
    required String userId,
  }) async* {
    yield* _remoteService
        .getAllResumeDataStream(userId: userId)
        .map((event) => event.map((e) => e.toDomain()).toList());
  }
}
