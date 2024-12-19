import 'package:ecowatt/features/voice_command/logic/voice_command_strategy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecowatt/features/device/models/device_model.dart';

import '../models/voice_command_model.dart';
import '../repositories/voice_command_repository.dart';

import 'voice_command_state.dart';

class VoiceCommandCubit extends Cubit<VoiceCommandState> {
  final VoiceCommandRepository _repository;
  final SpeechToTextVoiceCommandStrategy _commandStrategy;

  VoiceCommandCubit(this._repository, this._commandStrategy)
      : super(const VoiceCommandState.initial());

  Future<void> startVoiceCommand() async {
    emit(const VoiceCommandState.listening());

    try {
      VoiceCommandModel? command = await _commandStrategy.listenForCommand();

      if (command != null) {
        emit(VoiceCommandState.processing(command));

        DeviceModel? updatedDevice =
            await _repository.processVoiceCommand(command);

        if (updatedDevice != null) {
          emit(VoiceCommandState.success(updatedDevice));
        } else {
          emit(
              const VoiceCommandState.error('Could not process voice command'));
        }
      } else {
        emit(const VoiceCommandState.error('No valid command recognized'));
      }
    } catch (e) {
      emit(VoiceCommandState.error('Voice command error: ${e.toString()}'));
    }
  }

  void resetState() {
    emit(const VoiceCommandState.initial());
  }
}
