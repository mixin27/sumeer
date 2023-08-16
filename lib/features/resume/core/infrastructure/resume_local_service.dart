import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/shared/shared.dart';

class ResumeLocalService {
  Future<void> save(List<ResumeDataDto> items) async {
    final box = await Hive.openBox(AppConsts.keyResumeData);

    var jsonData = jsonEncode(items);

    // await box.clear();
    await box.put(AppConsts.keyResumeData, jsonData);

    await box.close();
  }

  Future<List<ResumeDataDto>> getData() async {
    final box = await Hive.openBox(AppConsts.keyResumeData);

    String data = box.get(AppConsts.keyResumeData, defaultValue: '');
    if (data.isEmpty) return [];

    var decoded = jsonDecode(data) as List<dynamic>;
    var items = decoded.map((e) => ResumeDataDto.fromJson(e)).toList();

    await box.close();

    return items;
  }

  Future<void> clearLocalData() async {
    final box = await Hive.openBox(AppConsts.keyResumeData);
    await box.clear();
    await box.close();
  }
}
