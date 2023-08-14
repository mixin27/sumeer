import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/utils/logger/logger.dart';
import 'package:uuid/uuid.dart';

class ResumeRemoteService {
  final FirebaseFirestore _firestore;

  ResumeRemoteService(this._firestore);

  Stream<List<ResumeDataDto>> getAllResumeDataStream({
    required String userId,
  }) async* {
    yield* _firestore
        .collection(FirestoreConsts.resumes)
        .doc(userId)
        .collection(FirestoreConsts.files)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return ResumeDataDto.fromJson(e.data());
      }).toList();
    });
  }

  Future<String> addResumeData({
    required String userId,
    required ResumeDataDto resumeData,
  }) async {
    try {
      // resumes -> userId -> files -> record
      final response = await _firestore
          .collection(FirestoreConsts.resumes)
          .doc(userId)
          .collection(FirestoreConsts.files)
          .add(resumeData.toJson());
      return response.id;
    } on FirebaseException catch (e) {
      eLog(e.toString());
      rethrow;
    }
  }

  Future<String> updateOrInsertResumeData({
    required String userId,
    String? resumeDocId,
    required ResumeDataDto resumeData,
  }) async {
    String id;
    ResumeDataDto data;
    if (resumeDocId == null) {
      id = const Uuid().v4();
      data = resumeData.copyWith(resumeId: id);
    } else {
      id = resumeDocId;
      data = resumeData;
    }

    try {
      // resumes -> userId -> files -> record
      await _firestore
          .collection(FirestoreConsts.resumes)
          .doc(userId)
          .collection(FirestoreConsts.files)
          .doc(id)
          .set(data.toJson());
      return id;
    } on FirebaseException catch (e) {
      eLog(e.toString());
      rethrow;
    }
  }

  Future<void> removeResumeData({
    required String userId,
    required String resumeDocId,
  }) async {
    try {
      // resumes -> userId -> files -> record
      await _firestore
          .collection(FirestoreConsts.resumes)
          .doc(userId)
          .collection(FirestoreConsts.files)
          .doc(resumeDocId)
          .delete();
    } on FirebaseException catch (e) {
      eLog(e.toString());
      rethrow;
    }
  }
}
