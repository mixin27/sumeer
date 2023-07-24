import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

typedef UserID = String;

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String uid,
    required String email,
  }) = _UserEntity;
}
