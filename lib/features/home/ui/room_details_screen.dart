import 'package:auto_route/annotations.dart';
import 'package:ecowatt/features/home/models/room_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/constants/ui_helpers.dart';
import '../../../shared/widgets/device_card.dart';
import '../../device/logic/device_cubit.dart';
import '../../device/logic/device_state.dart';
import '../../device/models/device_model.dart';
import '../logic/room_cubit.dart';
import '../logic/room_state.dart';

@RoutePage()
class RoomDetailsScreen extends StatefulWidget {
  final RoomModel roomModel;

  const RoomDetailsScreen({super.key, required this.roomModel});

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DeviceCubit>().fetchAllDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            return state.when(
                initial: () => const Text(''),
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                loaded: (rooms) => SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: mediumSize,
                      mainAxisSpacing: mediumSize,
                      children: [
                        BlocBuilder<DeviceCubit, DeviceState>(
                            builder: (context, state) {
                              return state.when(
                                initial: () => const Center(child: Text('')),
                                loading: () => Center(
                                  child: CircularProgressIndicator(
                                    color:
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                loaded: (devices) => GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: mediumSize,
                                  mainAxisSpacing: mediumSize,
                                  children: List.generate(devices.length, (index) {
                                      return DeviceCard(
                                          device: DeviceModel(
                                              name: devices[index].name,
                                              type: devices[index].type,
                                              rid: devices[index].rid,
                                              uid: FirebaseAuth.instance.currentUser!.uid,
                                              isActive: devices[index].isActive,
                                              isSmartDevice:
                                              devices[index].isSmartDevice));
                                    },
                                  ),
                                ),
                                error: (error) => Center(child: Text(error)),
                              );
                            }),
                      ]),
                ),
                detailsLoaded: (RoomModel room) => Container(),
                error: (error) => Center(
                    child: Text(
                      error,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .fontSize),
                    )));
          },
        )
      ],),
    );
  }
}
