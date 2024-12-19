import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/features/device/logic/device_cubit.dart';
import 'package:ecowatt/features/home/models/room_model.dart';
import 'package:ecowatt/shared/widgets/base_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/constants/ui_helpers.dart';
import '../../../shared/utils/device_utils.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/dropdown.dart';
import '../../../shared/widgets/input.dart';
import '../../dashboard/models/sensor_model.dart';
import '../../home/repositories/room_repository.dart';
import '../../dashboard/repositories/sensor_repository.dart';
import '../logic/device_type_cubit.dart';
import '../logic/device_type_state.dart';
import '../models/device_model.dart';

@RoutePage()
class AddDeviceScreen extends StatefulWidget {
  final String? roomId;

  const AddDeviceScreen({super.key, this.roomId});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<RoomModel> rooms = [];
  String? selectedRoomId;
  List<SensorModel> sensors = [];
  String? selectedSensorId;
  String? userId;
  String? selectedDeviceType;
  bool _isDeviceActive = false;
  bool _isSmartDevice = false;
  bool _isLoading = false;
  bool _isSensorsLoading = false;

  @override
  void initState() {
    super.initState();
    print('Received Room ID: ${widget.roomId}');
    final FirebaseAuth _auth = FirebaseAuth.instance;
    userId = _auth.currentUser!.uid;
    context.read<DeviceTypeCubit>().loadDeviceTypes();
    _loadSensors();
    _loadRooms();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadRooms() async {
    setState(() {
      _isLoading = true;
    });

    try {
      RoomRepository roomRepo = RoomRepository();
      List<RoomModel> fetchedRooms = await roomRepo.getAllRooms();
      setState(() {
        rooms = fetchedRooms;

        // If a specific roomId is passed
        if (widget.roomId != null) {
          // Find the room that matches the passed roomId
          RoomModel? matchingRoom;
          if (widget.roomId != null) {
            try {
              matchingRoom =
                  rooms.firstWhere((room) => room.rid == widget.roomId);
            } catch (e) {
              // If no matching room is found, use the first room or null
              matchingRoom = rooms.isNotEmpty ? rooms[0] : null;
            }
          }

          // Set the selectedRoomId accordingly
          selectedRoomId =
              matchingRoom?.rid ?? (rooms.isNotEmpty ? rooms[0].rid : null);

          print('Loaded rooms: ${rooms.map((r) => r.name)}');
          print('Selected Room ID: $selectedRoomId');
          print('Selected Room Name: ${matchingRoom?.name}');
          print('Passed Room ID: ${widget.roomId}');
        } else {
          // If no roomId is passed, use the first room or null
          selectedRoomId = rooms.isNotEmpty ? rooms[0].rid : null;
        }

        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load rooms: $e')),
      );
    }
  }
  
  Future<void> _loadSensors() async {
    setState(() {
      _isSensorsLoading = true;
    });

    try {
      SensorRepository sensorRepo = SensorRepository();
      List<SensorModel> fetchedSensors = await sensorRepo.getAllSensors();
      setState(() {
        sensors = fetchedSensors;

        selectedSensorId = sensors.isNotEmpty ? sensors[0].sid : null;
        
        _isSensorsLoading = false;
      });
    } catch (e) {
      setState(() {
        _isSensorsLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load sensors: $e')),
      );
    }
  }

  void _onDeviceTypeSelected(String deviceType) {
    setState(() {
      selectedDeviceType = deviceType;
    });
  }

  void _showAddDeviceBottomSheet(String deviceType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: smallSize,
            right: smallSize,
            top: smallSize,
          ),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBottomSheetHeader(context),
                verticalSpaceSmall,
                _buildDeviceForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetHeader(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 70.0,
          height: 10.0,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onTertiary,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Add device',
              style: TextStyle(
                color: Theme.of(context).colorScheme.scrim,
                fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
              ),
            ),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.onTertiary.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  CupertinoIcons.xmark,
                  color: Theme.of(context).colorScheme.scrim,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeviceForm(BuildContext context) {
    Map<bool, String> activeOptions = {
      true: 'Active',
      false: 'Inactive',
    };

    Map<bool, String> smartDeviceOptions = {
      true: 'Smart',
      false: 'Not Smart',
    };

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Input(
            label: "Name",
            controller: _nameController,
            keyboardType: TextInputType.text,
            radius: 8,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          verticalSpaceSmall,
          Input(
            label: "Description",
            controller: _descriptionController,
            keyboardType: TextInputType.text,
            radius: 8,
          ),
          verticalSpaceSmall,
          DropDownList<String>(
                  width: double.infinity,
                  height: 50,
                  hintText: 'To which sensor is your device connected ?',
                  value: selectedSensorId,
                  options: {
                    for (var sensor in sensors) 
                      sensor.sid: sensor.name 
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedSensorId = value;
                    });
                  },
                  isLoading: _isSensorsLoading,
                ),
          verticalSpaceSmall,
          DropDownList<String>(
            width: double.infinity,
            height: 50,
            hintText: 'Where is your device installed ?',
            value: selectedRoomId,
            options: {for (var room in rooms) room.rid!: room.name},
            onChanged: (value) {
              print('Dropdown value changed: $value');
              setState(() {
                selectedRoomId = value;
              });
            },
            isLoading: _isLoading,
          ),
          verticalSpaceSmall,
          DropDownList<bool>(
            width: double.infinity,
            height: 50,
            hintText: 'Is your device on ?',
            value: _isDeviceActive,
            options: activeOptions,
            onChanged: (value) {
              setState(() {
                _isDeviceActive = value ?? false;
              });
            },
          ),
          verticalSpaceSmall,
          DropDownList<bool>(
            width: double.infinity,
            height: 50,
            hintText: 'Is it a smart device ?',
            value: _isSmartDevice,
            options: smartDeviceOptions,
            onChanged: (value) {
              setState(() {
                _isSmartDevice = value ?? false;
              });
            },
          ),
          verticalSpaceSmall,
          Button(
            label: 'Confirm',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _createDevice();
              }
            },
          ),
        ],
      ),
    );
  }

  void _createDevice() {
    context.read<DeviceCubit>().createDevice(
          DeviceModel.fromJson({
            'name': _nameController.text.trim(),
            'type': selectedDeviceType,
            'rid': selectedRoomId,
            'uid': userId,
            'sid': selectedSensorId,
            'description': _descriptionController.text.trim(),
            'isActive': _isDeviceActive,
            'isSmartDevice': _isSmartDevice,
          }),
        );

    // Reset form fields
    _nameController.clear();
    _descriptionController.clear();
    setState(() {
      _isDeviceActive = false;
      _isSmartDevice = false;
    });

    // Close bottom sheet
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
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
          "Add devices",
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       CupertinoIcons.ellipsis_vertical,
        //       color: Theme.of(context).colorScheme.tertiary,
        //       size: smallSize + 10,
        //     ),
        //     onPressed: () => {},
        //   ),
        // ],
      ),
      currentIndex: 2,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(smallSize + 5),
          child: BlocBuilder<DeviceTypeCubit, DeviceTypeState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Text(''),
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                loaded: (deviceTypes) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // Prevent nested scrolling
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: smallSize,
                      mainAxisSpacing: smallSize,
                      childAspectRatio: 2 / 1,
                    ),
                    itemCount: deviceTypes.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _onDeviceTypeSelected(deviceTypes[index].name);
                          _showAddDeviceBottomSheet(deviceTypes[index].name);
                        },
                        child: FutureBuilder<Color>(
                          future: DeviceUtils()
                              .getCardBackgroundColor(deviceTypes[index].name),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Card(
                                color: snapshot.data,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Center(
                                      child: SizedBox(
                                        width: constraints.maxWidth * 0.7,
                                        // Limit content width
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                DeviceUtils().getCardIcon(
                                                    deviceTypes[index].name),
                                                color: snapshot.data,
                                                size: smallSize + 10,
                                              ),
                                            ),
                                            horizontalSpaceSmall,
                                            Expanded(
                                              child: Text(
                                                deviceTypes[index].name,
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
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                error: (error) => Center(
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
