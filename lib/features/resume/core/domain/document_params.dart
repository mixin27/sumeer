import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_params.freezed.dart';

@freezed
class GenerateDocParams with _$GenerateDocParams {
  const factory GenerateDocParams({
    String? title,
    String? author,
    String? creator,
    String? subject,
    String? keywords,
    String? producer,
  }) = _GenerateDocParams;
}
