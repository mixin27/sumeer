import 'package:hive_flutter/hive_flutter.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/shared/shared.dart';

class ResumeLocalService {
  Future<void> save(List<ResumeDataDto> items) async {
    final box = await Hive.openBox(AppConsts.keyResumeData);
    // box.put(AppConsts.keyResumeData, items.map((e) => e.toJson()).toList());
  }
}
