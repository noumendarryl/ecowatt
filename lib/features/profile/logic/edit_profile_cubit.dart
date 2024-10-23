import 'dart:io';

import 'package:bloc/bloc.dart';

import '../../auth/repositories/auth_repository.dart';
import '../models/user_model.dart';

import '../repository/user_repository.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  EditProfileCubit(this._userRepository, this._authRepository)
      : super(const EditProfileState.initial());

  Future<void> loadUser() async {
    final user = _authRepository.currentUser;
    if (user != null) {
      emit(const EditProfileState.loading());
      try {
        final userProfile = await _userRepository.getUser(user.uid);
        if (userProfile != null) {
          emit(EditProfileState.loaded(userProfile));
        } else {
          emit(const EditProfileState.error('User not found'));
        }
      } catch (e) {
        emit(EditProfileState.error(e.toString()));
      }
    }
  }

  Future<void> updateUser(UserModel user, {File? image}) async {
    emit(const EditProfileState.updating());
    try {
      String? imageUrl;
      //emit(EditProfileLoading());
      if (image != null) {
        imageUrl = await _userRepository.uploadProfilePhoto(user.uid, image);
      }
      final updatedUser = user.copyWith(photoURL: imageUrl ?? user.photoURL);
      await _userRepository.updateUser(updatedUser);
      emit(EditProfileState.updated(updatedUser));
    } catch (e) {
      emit(EditProfileState.error(e.toString()));
    }
  }

// Future<void> uploadProfilePicture(
//     UserProfileModel user, File profileImage) async {
//   emit(EditProfileLoading());
//   try {
//     String fileName =
//         'profile_pictures/${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
//     UploadTask uploadTask =
//         FirebaseStorage.instance.ref().child(fileName).putFile(profileImage);
//     TaskSnapshot taskSnapshot = await uploadTask;
//     String downloadURL = await taskSnapshot.ref.getDownloadURL();

//     // Update the user's photoURL in Firestore
//     user = user.copyWith(photoURL: downloadURL);
//    await updateUser(user);

//     emit(EditProfileUpdated(user));
//   } catch (e) {
//     emit(EditProfileError(e.toString()));
//   }
// }
}
