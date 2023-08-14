import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final educationFormKeyProvider =
    StateProvider.autoDispose<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});
