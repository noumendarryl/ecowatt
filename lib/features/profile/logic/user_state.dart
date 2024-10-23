import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/user_model.dart';


part 'user_state.freezed.dart'; // Freezed va générer ce fichier

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.success(UserModel user) = _Success;
  const factory UserState.failure(String error) = _Failure;
}
