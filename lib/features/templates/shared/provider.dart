import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'provider.g.dart';

@Riverpod(keepAlive: true)
FirebaseFirestore cloudFirestore(CloudFirestoreRef ref) {
  return FirebaseFirestore.instance;
}
