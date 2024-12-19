import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/features/device/models/device_model.dart';
import 'package:ecowatt/features/device/repositories/device_repository.dart';
import 'package:ecowatt/features/home/ui/room_details_screen.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routing/app_router.gr.dart';
import '../../../shared/utils/room_utils.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/input.dart';
import '../logic/room_cubit.dart';
import '../logic/room_state.dart';
import '../models/room_model.dart';

@RoutePage()
class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<DeviceModel> devices = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  
  // Method to fetch data for rooms and devices
  Future<void> _fetchData() async {
    await Future.wait([
      context.read<RoomCubit>().fetchRooms(),
    _loadDevices(),
    ]);
  }

  Future<void> _loadDevices() async {
    DeviceRepository deviceRepo = DeviceRepository();
    List<DeviceModel> fetchedDevices = await deviceRepo.getAllDevices();
    setState(() {
      devices = fetchedDevices;
    });
  }

  void _showAddRoomBottomSheet() {
    // Reset controllers before showing the bottom sheet
    _nameController.clear();
    _descriptionController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // This allows the bottom sheet to take up more space
      builder: (context) {
        // Wrap the bottom sheet content with a GestureDetector to dismiss keyboard on tap outside
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            // Use MediaQuery to adjust for keyboard and safe area
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: smallSize,
              right: smallSize,
              top: smallSize,
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(smallSize),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(mediumSize),
                    topLeft: Radius.circular(mediumSize),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 70.0,
                      height: 10.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onTertiary,
                          borderRadius: BorderRadius.circular(smallSize),
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Add room',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.scrim,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontFamily,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontWeight,
                          ),
                        ),
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiary
                                .withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.xmark,
                              color: Theme.of(context).colorScheme.scrim,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    Form(
                      key: _formKey,
                      child: Wrap(
                        runSpacing: mediumSize,
                        children: [
                          Input(
                            label: "Name",
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            radius: 0,
                            outlined: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a room name';
                              }
                              return null;
                            },
                          ),
                          Input(
                            label: "Description",
                            controller: _descriptionController,
                            keyboardType: TextInputType.text,
                            radius: 0,
                            outlined: false,
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceMedium,
                    Button(
                      label: 'Confirm',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context.read<RoomCubit>().createRoom(
                                RoomModel.fromJson({
                                  'name': _nameController.text.trim(),
                                  'description':
                                      _descriptionController.text.trim(),
                                }),
                              );

                          // Close the bottom sheet
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Rest of the code remains the same as the original implementation
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
          "Rooms",
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.add,
              color: Theme.of(context).colorScheme.tertiary,
              size: smallSize + 10,
            ),
            onPressed: _showAddRoomBottomSheet,
          ),
        ],
      ),
      body: RefreshIndicator(
         // Customize the color and background color of the refresh indicator
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          color: Theme.of(context).colorScheme.primary,

          // Trigger data refresh when pulled
          onRefresh: () async {
            // Call the method to fetch data
            await _fetchData();
          },
          
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(mediumSize),
              child: BlocBuilder<RoomCubit, RoomState>(
                builder: (context, state) {
                  return state.when(
                      // The rest of the state handling remains the same as the original implementation
                      initial: () => const Text(''),
                      loading: () => Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 1.25,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                      loaded: (rooms) => GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            // Prevent nested scrolling
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: smallSize,
                              mainAxisSpacing: smallSize,
                            ),
                            itemCount: rooms.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context.pushRoute(
                                      RoomDetailsRoute(room: rooms[index]));
                                },
                                child: FutureBuilder<Color>(
                                    future: RoomUtils().getCardBackgroundColor(
                                        rooms[index].name),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Card(
                                          color: snapshot.data,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  RoomUtils().getCardIcon(
                                                      rooms[index].name),
                                                  color: snapshot.data,
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
                                              ),
                                              Text(
                                                "${context.read<RoomCubit>().fetchTotalDevicesByRoom(rooms[index].rid!, devices).toString()} Devices",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onTertiary,
                                                  fontFamily: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .fontFamily,
                                                  fontSize: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .fontSize,
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .fontWeight,
                                                ),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      );
                                    }),
                              );
                            },
                          ),
                      detailsLoaded: (RoomModel room) =>
                          RoomDetailsScreen(room: room),
                      error: (error) => Center(
                              child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1.25,
                            child: Center(
                              child: Text(
                                error,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .fontSize,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )));
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
