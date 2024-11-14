import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
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
  final RoomModel room;

  const RoomDetailsScreen({super.key, required this.room});

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
      backgroundColor: Theme.of(context).colorScheme.onTertiary.withOpacity(0.3),
      appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .onSurface,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme
                  .of(context)
                  .colorScheme
                  .onTertiary,
              size: mediumSize,
            ),
            onPressed: () {
              context.router.maybePop();
            },
          ),
          title: Column(children: [
            Text(
              widget.room.name,
              style: TextStyle(
                color: Theme
                    .of(context)
                    .colorScheme
                    .scrim,
                fontFamily: Theme
                    .of(context)
                    .textTheme
                    .titleSmall!
                    .fontFamily,
                fontSize: Theme
                    .of(context)
                    .textTheme
                    .titleSmall!
                    .fontSize,
                fontWeight: Theme
                    .of(context)
                    .textTheme
                    .titleSmall!
                    .fontWeight,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpaceTiny,
            Text(
              "${widget.room.totalDevices} Device(s)",
              style: TextStyle(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onTertiary,
                fontFamily: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .fontFamily,
                fontSize: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .fontSize,
                fontWeight: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .fontWeight,
              ),
              textAlign: TextAlign.center,
            ),
          ],),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                CupertinoIcons.ellipsis_vertical,
                color: Theme
                    .of(context)
                    .colorScheme
                    .onTertiary,
                size: mediumSize,
              ),
              onPressed: () {}
            ),
          ],
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: smallSize),
        child: Column(children: [
          BlocBuilder<RoomCubit, RoomState>(
            builder: (context, state) {
              return state.when(
                  initial: () => const Text(''),
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  loaded: (rooms) => BlocBuilder<DeviceCubit, DeviceState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const Center(child: Text('')),
                          loading: () => Center(
                            child: CircularProgressIndicator(
                              color:
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          loaded: (devices) => SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height,
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: mediumSize,
                              mainAxisSpacing: mediumSize,
                              children: List.generate(devices.length, (index) {
                                  return DeviceCard(
                                      device: DeviceModel(
                                        did:devices[index].did,
                                          name: devices[index].name,
                                          type: devices[index].type,
                                          rid: devices[index].rid,
                                          uid: FirebaseAuth.instance.currentUser!.uid,
                                          isActive: devices[index].isActive,
                                          isSmartDevice:
                                          devices[index].isSmartDevice),
                                      );
                                },
                              ),
                            ),
                          ),
                          error: (error) => Center(child: Text(error)),
                        );
                      }),
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
      ),
    );
  }
}
