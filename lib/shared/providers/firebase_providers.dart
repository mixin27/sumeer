import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_providers.g.dart';

// final firebaseAnalyticsObserverProvider =
//     Provider<FirebaseAnalyticsObserver>((ref) {
//   return FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
// });

// final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
//   return FirebaseAuth.instance;
// });

// final cloudFirestoreProvider = Provider<FirebaseFirestore>((ref) {
//   return FirebaseFirestore.instance;
// });
@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

@Riverpod(keepAlive: true)
FirebaseStorage firebaseStorage(FirebaseStorageRef ref) {
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  return FirebaseStorage.instance;
}
