import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sumeer/features/features.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
FirebaseFirestore cloudFirestore(CloudFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

final resumeTemplateProvider = StateProvider<ResumeTemplate>((ref) {
  return resumeTemplates[0];
});
