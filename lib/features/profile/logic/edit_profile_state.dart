import 'package:freezed_annotation/freezed_annotation.dart';


import '../models/user_model.dart';

part 'edit_profile_state.freezed.dart';

@freezed

class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial() = EditProfileInitial;
  const factory EditProfileState.loading() = EditProfileLoading;
  const factory EditProfileState.loaded(UserModel user) = EditProfileLoaded;
  const factory EditProfileState.updating() = EditProfileUpdating;
  const factory EditProfileState.updated(UserModel user) = EditProfileUpdated;
  const factory EditProfileState.error(String message) = EditProfileError;
  
}

