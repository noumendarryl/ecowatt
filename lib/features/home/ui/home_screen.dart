import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/features/device/logic/device_cubit.dart';
import 'package:ecowatt/features/device/logic/device_state.dart';
import 'package:ecowatt/features/home/logic/room_cubit.dart';
import 'package:ecowatt/features/home/logic/room_state.dart';
import 'package:ecowatt/features/home/ui/room_details_screen.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:ecowatt/shared/utils/room_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routing/app_router.gr.dart';
import '../../../shared/widgets/BaseLayout.dart';
import '../../../shared/widgets/device_card.dart';
import '../../device/models/device_model.dart';
import '../models/room_model.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomCubit>().fetchRooms();
    context.read<DeviceCubit>().fetchAllDevices();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        title: 'HOME',

        currentIndex:0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: smallSize),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(mediumSize),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(smallSize)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rooms",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.scrim,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {context.pushRoute(RoomListRoute())},
                              child: Text(
                                "See all rooms",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onTertiary,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .fontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        BlocBuilder<RoomCubit, RoomState>(
                          builder: (context, state) {
                            return state.when(
                                initial: () => const Text('Hello'),
                                loading: () => Center(
                                      child: CircularProgressIndicator(
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                loaded: (rooms) => SizedBox(
                                  height: 350.0,
                                  child: GridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: smallSize,
                                      mainAxisSpacing: smallSize,
                                      children: List.generate(4, (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            context.pushRoute(RoomDetailsRoute(roomModel: rooms[index]));
                                          },
                                          child: Card(
                                              color: RoomUtils()
                                                  .getCardBackgroundColor(
                                                  context, rooms[index].name),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 50,
                                                  // Diameter of the circular background
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    // Background color
                                                    shape: BoxShape
                                                        .circle, // Makes the background circular
                                                  ),
                                                  child: Icon(
                                                    RoomUtils().getCardIcon(
                                                        rooms[index].name),
                                                    color: RoomUtils()
                                                        .getCardBackgroundColor(
                                                            context,
                                                            rooms[index].name),
                                                    size: mediumSize,
                                                  ),
                                                ),
                                                verticalSpaceSmall,
                                                Text(
                                                  rooms[index].name,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontFamily: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .fontFamily,
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .fontSize,
                                                    fontWeight: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .fontWeight,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      })),
                                ),
                                detailsLoaded: (RoomModel room) =>
                                    RoomDetailsScreen(roomModel: room),
                                error: (error) => Center(
                                        child: Text(
                                      error,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).colorScheme.error,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .fontSize),
                                    )));
                          },
                        )
                      ],
                    )),
                verticalSpaceMedium,
                Container(
                    padding: const EdgeInsets.all(mediumSize),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(smallSize)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Accessories",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.scrim,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        BlocBuilder<DeviceCubit, DeviceState>(
                          builder: (context, state) {
                            return state.when(
                                initial: () => const Text(''),
                                loading: () => Center(
                                      child: CircularProgressIndicator(
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                loaded: (devices) => SizedBox(
                                  height: 400.0,
                                  child: GridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: smallSize,
                                      mainAxisSpacing: smallSize,
                                      children: List.generate(4, (index) {
                                        return DeviceCard(
                                            device: DeviceModel(
                                              did: devices[index].did,
                                                name: devices[index].name,
                                                type: devices[index].type,
                                                rid: devices[index].rid,
                                                uid: FirebaseAuth.instance.currentUser!.uid,
                                                isActive: devices[index].isActive,
                                                isSmartDevice:
                                                    devices[index].isSmartDevice),
                                            );
                                      })),
                                ),
                                error: (error) => Center(
                                        child: Text(
                                      error,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).colorScheme.error,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .fontSize),
                                    )));
                          },
                        )
                      ],
                    )),

              ],
            ),
          ),
        ));
  }
}
