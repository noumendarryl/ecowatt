part of 'bootstrap_cubit.dart';

@freezed
class BootstrapState with _$BootstrapState {
  const factory BootstrapState.initial() = _Initial;
  const factory BootstrapState.initialized({required bool isLoggedIn}) = _Initialized;
}
