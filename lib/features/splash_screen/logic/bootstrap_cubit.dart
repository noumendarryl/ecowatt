import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bootstrap_state.dart';
part 'bootstrap_cubit.freezed.dart';

class BootstrapCubit extends Cubit<BootstrapState> {
  BootstrapCubit() : super(const BootstrapState.initial());

  Future<void> init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? state = sharedPreferences.getBool('isLoggedIn');
    
    state ??= false;
    if (state){
      Future.delayed(
        const Duration(seconds: 5),
            () => emit(const BootstrapState.initialized(isLoggedIn: true)),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 5),
            () => emit(const BootstrapState.initialized(isLoggedIn: false)),
      );
    }
  }
}
