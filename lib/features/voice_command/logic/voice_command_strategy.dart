import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart';

import '../models/voice_command_model.dart';

abstract class VoiceCommandStrategy {
  Future<VoiceCommandModel?> listenForCommand();

  void stopListening();
}

class SpeechToTextVoiceCommandStrategy implements VoiceCommandStrategy {
  final SpeechToText _speechToText = SpeechToText();
  String currentTranscription = ''; // Track current transcription

  Future<bool> initializeSpeech() async {
    try {
      if (await _speechToText.hasPermission == false) {
        print('Speech recognition permission not granted');
        return false;
      }

      bool hasSpeechPermission = await _speechToText.initialize(
        onError: (errorNotification) {
          print(
              'Detailed speech recognition error: ${errorNotification.errorMsg}');
          // print('Error code: ${errorNotification.errorCode}');
        },
        onStatus: (status) {
          print('Detailed speech recognition status: $status');
        },
      );

      if (!hasSpeechPermission) {
        print('Speech recognition initialization failed');
        return false;
      }

      return true;
    } catch (e) {
      print('Comprehensive error initializing speech: $e');
      return false;
    }
  }

  @override
  Future<VoiceCommandModel?> listenForCommand() async {
    bool isInitialized = await initializeSpeech();
    if (!isInitialized) {
      print('Speech recognition could not be initialized');
      return null;
    }

    Completer<VoiceCommandModel?> completer = Completer();

    try {
      currentTranscription = '';

      _speechToText.listen(
        onResult: (result) {
          print('Speech recognition result: ${result.recognizedWords}');
          print('Is final result: ${result.finalResult}');

          currentTranscription = result.recognizedWords;

          if (result.finalResult) {
            VoiceCommandModel? command = _parseCommand(result.recognizedWords);

            print('Parsed command: $command');

            if (!completer.isCompleted) {
              completer.complete(command);
            }
          }
        },
        onSoundLevelChange: (level) {
          // Optional: Log sound levels for debugging
          print('Sound level: $level');
        },
        listenFor: const Duration(seconds: 5),
        pauseFor: const Duration(seconds: 3),
        cancelOnError: true,
        partialResults: true,
      );

      Future.delayed(const Duration(seconds: 6), () {
        if (!completer.isCompleted) {
          print('No command recognized within timeout');
          completer.complete(null);
        }
      });
    } catch (e) {
      print('Detailed error during voice listening: $e');
      completer.complete(null);
    }

    return completer.future;
  }

  VoiceCommandModel? _parseCommand(String command) {
    command = command.toLowerCase().trim();

    // More flexible command mappings with partial matching and multiple variations
    final List<Map<String, dynamic>> commandMappings = [
      {
        'patterns': ['turn on ac', 'activate ac', 'ac on', 'turn ac on'],
        'command': VoiceCommandModel(
            command: command, deviceName: 'AC-9300', isActive: true)
      },
      {
        'patterns': ['turn off ac', 'deactivate ac', 'ac off', 'turn ac off'],
        'command': VoiceCommandModel(
            command: command, deviceName: 'AC-9300', isActive: false)
      },
      {
        'patterns': [
          'turn on light',
          'activate light',
          'light on',
          'turn light on'
        ],
        'command': VoiceCommandModel(
            command: command, deviceName: 'Light', isActive: true)
      },
      {
        'patterns': [
          'turn off light',
          'deactivate light',
          'light off',
          'turn light off'
        ],
        'command': VoiceCommandModel(
            command: command, deviceName: 'Light', isActive: false)
      },
    ];

    // More flexible matching with multiple pattern variations
    for (var mapping in commandMappings) {
      for (var pattern in mapping['patterns']) {
        if (command.contains(pattern)) {
          return mapping['command'];
        }
      }
    }

    return null;
  }

  @override
  void stopListening() {
    _speechToText.stop();
  }
}
