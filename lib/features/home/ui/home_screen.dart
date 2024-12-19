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
import '../../../shared/widgets/base_layout.dart';
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
    _fetchData();
  }

  // Method to fetch data for rooms and devices
  Future<void> _fetchData() async {
    await Future.wait([
      context.read<RoomCubit>().fetchRooms(),
      context.read<DeviceCubit>().fetchAllDevices(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        title: 'Home',
        currentIndex: 0,
        child: RefreshIndicator(
          // Customize the color and background color of the refresh indicator
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          color: Theme.of(context).colorScheme.primary,

          // Trigger data refresh when pulled
          onRefresh: () async {
            // Call the method to fetch data
            await _fetchData();
          },

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: smallSize, vertical: mediumSize),
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
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontFamily,
                                    fontSize: 22.0,
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontWeight),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    {context.pushRoute(const RoomListRoute())},
                                child: Text(
                                  "See all",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.tertiary,
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
                                  initial: () => const Center(
                                        child: Text('No rooms found !'),
                                      ),
                                  loading: () => Center(
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                  loaded: (rooms) {
                                    if (rooms.isEmpty) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'No rooms found for now !',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                              fontFamily: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .fontFamily,
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .fontSize,
                                            ),
                                          ),
                                          verticalSpaceSmall,
                                          GestureDetector(
                                            onTap: () => {
                                              context.pushRoute(
                                                  const RoomListRoute())
                                            },
                                            child: Text(
                                              'Add a room',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .fontFamily,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }
          
                                    return ListView(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: smallSize,
                                            mainAxisSpacing: smallSize,
                                            childAspectRatio:
                                                1.0, // Adjust this to control card shape
                                          ),
                                          itemCount:
                                              rooms.length > 4 ? 4 : rooms.length,
                                          itemBuilder: (context, index) {
                                            final room = rooms[index];
                                            return GestureDetector(
                                              onTap: () {
                                                context.pushRoute(
                                                    RoomDetailsRoute(room: room));
                                              },
                                              child: FutureBuilder<Color>(
                                                  future: RoomUtils()
                                                      .getCardBackgroundColor(
                                                          room.name),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Card(
                                                        color: snapshot.data,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16.0),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 50,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                RoomUtils()
                                                                    .getCardIcon(
                                                                        room.name),
                                                                color:
                                                                    snapshot.data,
                                                                size: mediumSize,
                                                              ),
                                                            ),
                                                            verticalSpaceSmall,
                                                            Text(
                                                              room.name,
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                                fontFamily: Theme
                                                                        .of(context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .fontFamily,
                                                                fontSize: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .fontSize,
                                                                fontWeight: Theme
                                                                        .of(context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .fontWeight,
                                                              ),
                                                              textAlign: TextAlign
                                                                  .center,
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                    );
                                                  }),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                  detailsLoaded: (RoomModel room) =>
                                      RoomDetailsScreen(room: room),
                                  error: (error) => Center(
                                          child: Text(
                                        "Can't load rooms for an unexpected reason !",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .fontSize),
                                        textAlign: TextAlign.center,
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
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontFamily,
                                    fontSize: 22.0,
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontWeight),
                              ),
                            ],
                          ),
                          verticalSpaceMedium,
                          BlocBuilder<DeviceCubit, DeviceState>(
                            builder: (context, state) {
                              return state.when(
                                  initial: () => const SizedBox.shrink(),
                                  loading: () => Center(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                  loaded: (devices) {
                                    if (devices.isEmpty) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'No accessory(ies) found for now !',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                              fontFamily: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .fontFamily,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          verticalSpaceSmall,
                                          GestureDetector(
                                            onTap: () => {
                                              context.pushRoute(AddDeviceRoute())
                                            },
                                            child: Text(
                                              'Add an accessory',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .fontFamily,
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .fontSize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }
          
                                    return ListView(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: smallSize,
                                            mainAxisSpacing: smallSize,
                                            childAspectRatio:
                                                1.0, // Adjust this to control card shape
                                          ),
                                          itemCount: devices.length > 4
                                              ? 4
                                              : devices.length,
                                          itemBuilder: (context, index) {
                                            final device = devices[index];
                                            return DeviceCard(
                                              device: DeviceModel(
                                                did: device.did,
                                                name: device.name,
                                                type: device.type,
                                                rid: device.rid,
                                                uid: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                isActive: device.isActive,
                                                isSmartDevice:
                                                    device.isSmartDevice,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                  error: (error) => Center(
                                      child: Center(
                                        child: Text(
                                          'Can\'t load accessories for an unexpected reason !',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .fontSize,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )));
                            },
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
