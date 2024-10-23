import 'package:bloc/bloc.dart';
import 'package:ecowatt/features/profile/logic/user_state.dart';

import '../repository/user_repository.dart';

// Cette partie est générée par Freezed

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserState.initial());

  Future<void> fetchUser(String userId) async {

    try {
      emit(const UserState.loading());
      final user = await _userRepository.getUser(userId);
      if (user != null) {
        emit(UserState.success(user));
      } else {
        emit(const UserState.failure("Utilisateur non trouvé"));
      }
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }
}



