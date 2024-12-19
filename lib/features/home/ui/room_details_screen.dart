import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/features/home/models/room_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routing/app_router.gr.dart';
import '../../../shared/constants/ui_helpers.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
import '../../../shared/widgets/device_card.dart';
import '../../../shared/widgets/input.dart';
import '../../device/logic/device_cubit.dart';
import '../../device/logic/device_state.dart';
import '../../device/models/device_model.dart';
import '../../device/repositories/device_repository.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  List<DeviceModel> devices = [];

  @override
  void initState() {
    super.initState();
    _fetchDevices();
    _nameController = TextEditingController(text: widget.room.name);
    _descriptionController =
        TextEditingController(text: widget.room.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
   // Method to fetch data for rooms and devices
  Future<void> _fetchDevices() async {
    await Future.wait([
      context.read<DeviceCubit>().fetchAllDevices(),
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

  void _showEditRoomBottomSheet() {
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
                          'Edit room',
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
                      label: 'Update',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _updateRoom();
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

  void _updateRoom() {
    // Prepare the updated device model
    RoomModel updatedRoom = RoomModel.fromJson({
      'rid': widget.room.rid,
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
    });

    // Use DeviceCubit to update the device
    context.read<RoomCubit>().updateRoom(updatedRoom);

    // Close bottom sheet
    Navigator.of(context).pop();

    context.router.push(const RoomListRoute());
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          title: Text(
            'Delete room',
            style: TextStyle(
              color: Theme.of(context).colorScheme.scrim,
              fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
            ),
          ),
          content: Text(
            'Are you sure you want to delete ${widget.room.name} ?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily,
              fontSize: 16.0,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  width: 20.0,
                  label: 'Cancel',
                  labelColor: Theme.of(context).colorScheme.scrim,
                  color: Theme.of(context).colorScheme.onTertiary,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                horizontalSpaceTiny,
                CustomElevatedButton(
                  width: 20.0,
                  label: 'Delete',
                  labelColor: Theme.of(context).colorScheme.onSurface,
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () {
                    _deleteRoom();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _deleteRoom() {
    // Use DeviceCubit to delete the device
    context.read<RoomCubit>().deleteRoom(widget.room.rid!);
    Navigator.of(context).pop();
    context.router.push(const RoomListRoute());
  }

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
        title: Column(
          children: [
            Text(
              widget.room.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.scrim,
                fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpaceTiny,
            Text(
              "${context.read<RoomCubit>().fetchTotalDevicesByRoom(widget.room.rid!, devices).toString()} Devices",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily,
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                fontWeight: Theme.of(context).textTheme.bodySmall!.fontWeight,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpaceSmall,
          ],
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            padding: const EdgeInsets.all(smallSize),
            elevation: mediumSize,
            color: Theme.of(context).colorScheme.onSurface,
            icon: Icon(
              CupertinoIcons.ellipsis_vertical,
              color: Theme.of(context).colorScheme.tertiary,
              size: smallSize + 10,
            ),
            onSelected: (String choice) {
              switch (choice) {
                case 'edit':
                  _showEditRoomBottomSheet();
                  break;
                case 'delete':
                  _showDeleteConfirmationDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: smallSize + 10,
                    ),
                    horizontalSpaceSmall,
                    Text('Edit',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontFamily,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.delete,
                      color: Theme.of(context).colorScheme.error,
                      size: smallSize + 10,
                    ),
                    horizontalSpaceSmall,
                    Text('Delete',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontFamily,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        // Customize the color and background color of the refresh indicator
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          color: Theme.of(context).colorScheme.primary,

          // Trigger data refresh when pulled
          onRefresh: () async {
            // Call the method to fetch devices
            await _fetchDevices();
          },
          
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(mediumSize),
        child: Column(
          children: [
            BlocBuilder<RoomCubit, RoomState>(
              builder: (context, state) {
                return state.when(
                    initial: () => const SizedBox.shrink(),
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
                    loaded: (rooms) => BlocBuilder<DeviceCubit, DeviceState>(
                            builder: (context, state) {
                          return state.when(
                            initial: () => const SizedBox.shrink(),
                            loading: () => Center(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.25,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            loaded: (devices) {
                              // Filter devices by room ID
                              final roomDevices = devices
                                  .where(
                                      (device) => device.rid == widget.room.rid)
                                  .toList();

                              if (roomDevices.isEmpty) {
                                return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        1.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'No devices found in ${widget.room.name} !',
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
                                            context.pushRoute(AddDeviceRoute(
                                                roomId: widget.room.rid))
                                          },
                                          child: Text(
                                            'Add a new device here',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontFamily: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .fontFamily,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                              }

                              return ListView(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                children: [
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    // Prevent nested scrolling
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: smallSize,
                                      mainAxisSpacing: smallSize,
                                      childAspectRatio:
                                          1.0, // Adjust this to control card shape
                                    ),
                                    itemCount: roomDevices.length,
                                    itemBuilder: (context, index) {
                                      return DeviceCard(
                                        device: DeviceModel(
                                            did: roomDevices[index].did,
                                            name: roomDevices[index].name,
                                            type: roomDevices[index].type,
                                            rid: roomDevices[index].rid,
                                            uid: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            isActive: roomDevices[index].isActive,
                                            isSmartDevice:
                                                roomDevices[index].isSmartDevice),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                            error: (error) => Center(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.25,
                                child: Center(
                                  child: Text(
                                    error,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .fontSize,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    detailsLoaded: (RoomModel room) => Container(),
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
                                    .bodyMedium!
                                    .fontSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )));
              },
            )
          ],
        ),
      ),
      )
    );
  }
}
