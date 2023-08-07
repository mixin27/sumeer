import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

String utcToLocal(
  String value, {
  bool hasTime = true,
}) {
  try {
    DateTime parsed = parseDateTime(value);

    return hasTime
        ? DateFormat.yMd().add_jms().format(parsed)
        : DateFormat.yMd().format(parsed);
  } catch (_) {
    return 'Invalid DateTime';
  }
}

DateTime parseDateTime(String value) {
  return DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(value).toLocal();
}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

String getConcatStringFromArray(List<String> values) {
  return values.join(',');
}
