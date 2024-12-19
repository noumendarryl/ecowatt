import 'package:auto_route/auto_route.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../exceptions/custom_dialog.dart';
import '../../../shared/constants/ui_helpers.dart';
import '../../../shared/widgets/device_card.dart';
import '../logic/voice_command_cubit.dart';
import '../logic/voice_command_state.dart';

@RoutePage()
class VoiceCommandScreen extends StatelessWidget {
  const VoiceCommandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onTertiary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.tertiary,
            size: smallSize + 10,
          ),
          onPressed: () {
            context.router.maybePop();
          },
        ),
        title: Text(
          "Voice Command",
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<VoiceCommandCubit, VoiceCommandState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              showCustomSnackbar(
                context,
                title: "Voice Command Failed",
                message: message,
                type: SnackbarType.error,
              );
            },
          );
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state.whenOrNull(
                      success: (device) => DeviceCard(device: device),
                      processing: (command) => Column(
                        children: [
                          Text('Command: ${command.command}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .fontSize,
                              )),
                          CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                      listening: () => Text('Listening...',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          )),
                    ) ??
                    Text(
                      'Tap to start voice command',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
                      ),
                    ),
                verticalSpaceMedium,
                GestureDetector(
                  onTap: () =>
                      context.read<VoiceCommandCubit>().startVoiceCommand(),
                  child: AvatarGlow(
                    animate: true,
                    glowColor: Theme.of(context).colorScheme.primary,
                    child: Container(
                      width: largeSize + 20,
                      height: largeSize + 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mic,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: mediumSize,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
