part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.authenticated(User user) = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.signUpFailed(String error) = _SignUpFailed;
  const factory AuthState.signUpSuccess() = _SignUpSuccess;
   const factory AuthState.passwordResetEmailSent() = PasswordResetEmailSent;
  const factory AuthState.passwordResetEmailFailed(String error) = PasswordResetEmailFailed;
}
