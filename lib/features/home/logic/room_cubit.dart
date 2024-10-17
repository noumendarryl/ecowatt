// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../profile/model/user_profile_model.dart';
// import '../repository/auth_repository.dart';
//
// part 'room_state.dart';
//
// part 'room_cubit.freezed.dart';
//
// class AuthCubit extends Cubit<AuthState> {
//   final AuthRepository _authRepository;
//
//   AuthCubit(this._authRepository) : super(const AuthState.initial()) {
//     _initializeUser();
//   }
//
//   Future<void> _initializeUser() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     bool isLoggedIn = sharedPreferences.getBool('isLoggedIn') ?? false;
//     if (isLoggedIn) {
//       final user = _authRepository.currentUser;
//       if (user != null) {
//         emit(AuthState.authenticated(user));
//       } else {
//         emit(const AuthState.unauthenticated());
//       }
//     } else {
//       emit(const AuthState.unauthenticated());
//     }
//   }
//
//   Future<void> signUpWithEmail(String? displayName, String username, String email, String password) async {
//     emit(const AuthState.loading());
//     try {
//       final user = await _authRepository.signUpWithEmail(email, password);
//       if (user != null) {
//         UserProfileModel userProfile = UserProfileModel(
//           uid: user.uid,
//           photoURL:  '',
//           username: username,
//           displayName: displayName ?? '',
//           email: user.email ?? '',
//         );
//
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .set(userProfile.toMap());
//
//         SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         sharedPreferences.setBool('isLoggedIn', true);
//
//         emit(const AuthState.signUpSuccess());
//         emit(AuthState.authenticated(user));
//       } else {
//         emit(const AuthState.signUpFailed('Signup Failed ! Please try again.'));
//       }
//     } catch (e) {
//       print('Signup failed with error : $e');
//       emit(AuthState.signUpFailed(e.toString()));
//     }
//   }
//
//   Future<void> signInWithEmail(String email, String password) async {
//     try {
//       emit(const AuthState.loading());
//       final user = await _authRepository.signInWithEmail(email, password);
//       if (user != null) {
//         SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         sharedPreferences.setBool('isLoggedIn', true);
//         emit(AuthState.authenticated(user));
//       } else {
//         emit(const AuthState.unauthenticated());
//       }
//     } catch (e) {
//       emit(AuthState.signUpFailed(e.toString()));
//     }
//   }
//
//   Future<void> signInWithGoogle() async {
//     try {
//       emit(const AuthState.loading());
//       final user = await _authRepository.signInWithGoogle();
//       if (user != null) {
//         UserProfileModel userProfile = UserProfileModel(
//           uid: user.uid,
//           photoURL: '',
//           username: '',
//           displayName: '',
//           email: user.email ?? '',
//         );
//
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .set(userProfile.toMap());
//
//         SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         sharedPreferences.setBool('isLoggedIn', true);
//         emit(AuthState.authenticated(user));
//       } else {
//         emit(const AuthState.unauthenticated());
//       }
//     } catch (e) {
//       emit(AuthState.signUpFailed(e.toString()));
//     }
//   }
//
//   Future<void> sendPasswordResetEmail(String email) async {
//     emit(const AuthState.loading());
//     try {
//       await _authRepository.sendPasswordResetEmail(email);
//       emit(const AuthState.passwordResetEmailSent());
//     } catch (e) {
//       emit(AuthState.passwordResetEmailFailed(e.toString()));
//     }
//   }
//
//   Future<void> signOut() async {
//     await _authRepository.signOut();
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setBool('isLoggedIn', false);
//     emit(const AuthState.unauthenticated());
//   }
// }
