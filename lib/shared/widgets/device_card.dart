import 'package:ecowatt/features/device/models/device_model.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:ecowatt/shared/utils/device_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/dashboard/models/sensor_model.dart';
import '../../features/dashboard/repositories/sensor_repository.dart';
import '../../features/device/logic/device_cubit.dart';
import '../../features/home/models/room_model.dart';
import '../../features/home/repositories/room_repository.dart';
import 'button.dart';
import 'custom_elevated_button.dart';
import 'dropdown.dart';
import 'input.dart';

class DeviceCard extends StatefulWidget {
  final DeviceModel device;
  final bool isCompact;

  const DeviceCard({
    super.key,
    required this.device,
    this.isCompact = false,
  });

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  List<RoomModel> rooms = [];
  List<SensorModel> sensors = [];
  String? selectedRoomId;
  String? selectedSensorId;
  bool _isDeviceActive = false;
  bool _isSmartDevice = false;
  bool _isLoading = false;
  bool _isSensorsLoading = false;

  @override
  void initState() {
    super.initState();
    // Load sensors when the widget is initialized
    _loadSensors();
    // Load rooms when the widget is initialized
    _loadRooms();
    // Initialize controllers with existing device values
    _nameController = TextEditingController(text: widget.device.name);
    _descriptionController =
        TextEditingController(text: widget.device.description);
    selectedSensorId = widget.device.sid;
    selectedRoomId = widget.device.rid;
    _isDeviceActive = widget.device.isActive;
    _isSmartDevice = widget.device.isSmartDevice;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<List<RoomModel>> _loadRooms() async {
    setState(() {
      _isLoading = true;
    });
    try {
      RoomRepository roomRepo = RoomRepository();
      List<RoomModel> fetchedRooms = await roomRepo.getAllRooms();
      setState(() {
        rooms = fetchedRooms;
        _isLoading = false;
      });
      return fetchedRooms;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load rooms: $e')),
      );
      return [];
    }
  }

  Future<List<SensorModel>> _loadSensors() async {
    setState(() {
      _isSensorsLoading = true;
    });

    try {
      SensorRepository sensorRepo = SensorRepository();
      List<SensorModel> fetchedSensors = await sensorRepo.getAllSensors();
      setState(() {
        sensors = fetchedSensors;
        _isSensorsLoading = false;
      });
      return fetchedSensors;
    } catch (e) {
      setState(() {
        _isSensorsLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load sensors : $e')),
      );
      return [];
    }
  }

  void _showEditDeviceBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
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
                _buildEditDeviceForm(context),
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
              'Edit device',
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

  Widget _buildEditDeviceForm(BuildContext context) {
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
                return 'Please enter a name';
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
            options: {for (var sensor in sensors) sensor.sid: sensor.name},
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
            label: 'Update',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _updateDevice();
              }
            },
          ),
        ],
      ),
    );
  }

  void _updateDevice() {
    // Prepare the updated device model
    context.read<DeviceCubit>().updateDevice(DeviceModel.fromJson({
          'did': widget.device.did,
          'name': _nameController.text.trim(),
          'type': widget.device.type,
          'rid': selectedRoomId,
          'uid': widget.device.uid,
          'sid': selectedSensorId,
          'description': _descriptionController.text.trim(),
          'isActive': _isDeviceActive,
          'isSmartDevice': _isSmartDevice,
        }));

    // Close bottom sheet
    Navigator.of(context).pop();
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          title: Text(
            'Delete device',
            style: TextStyle(
              color: Theme.of(context).colorScheme.scrim,
              fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
            ),
          ),
          content: Text(
            'Are you sure you want to delete ${widget.device.name} ?',
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
                    _deleteDevice();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _deleteDevice() {
    // Use DeviceCubit to delete the device
    context.read<DeviceCubit>().deleteDevice(widget.device.did!);
  }

  void _showDeviceOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
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
              ListTile(
                leading: Icon(
                  Icons.edit_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: smallSize + 10,
                ),
                title: Text('Edit',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontFamily:
                            Theme.of(context).textTheme.titleLarge!.fontFamily,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  _showEditDeviceBottomSheet();
                },
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.delete,
                  color: Theme.of(context).colorScheme.error,
                  size: smallSize + 10,
                ),
                title: Text('Delete',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontFamily:
                            Theme.of(context).textTheme.titleLarge!.fontFamily,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmationDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = widget.isCompact || constraints.maxWidth < 200;

        return FutureBuilder<Color>(
          future: DeviceUtils().getCardBackgroundColor(widget.device.type),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(smallSize + 6.0),
                ),
                color: snapshot.data,
                child: Padding(
                  padding: isCompact
                      ? const EdgeInsets.symmetric(
                          horizontal: smallSize + 6.0, vertical: smallSize)
                      : const EdgeInsets.all(smallSize + 6.0),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Device Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Device Icon
                            Row(
                              children: [
                                Icon(
                                  DeviceUtils().getCardIcon(widget.device.type),
                                  size:
                                      isCompact ? mediumSize : mediumSize + 5.0,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                if (!isCompact) ...[
                                  horizontalSpaceMedium,
                                  if (widget.device.isSmartDevice)
                                    Container(
                                      width: 70.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        borderRadius:
                                            BorderRadius.circular(smallSize),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "SMART",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              fontFamily: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .fontFamily,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                ]
                              ],
                            ),

                            // Toggle Switch
                            if (isCompact)
                              CupertinoSwitch(
                                value: widget.device.isActive,
                                onChanged: (newValue) async {
                                  setState(() {
                                    widget.device.isActive = newValue;
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('devices')
                                      .doc(widget.device.did)
                                      .update({'isActive': newValue});
                                },
                                activeColor:
                                    Theme.of(context).colorScheme.onSecondary,
                                trackColor:
                                    Theme.of(context).colorScheme.onTertiary,
                              ),
                            // More Options
                            if (!isCompact)
                              IconButton(
                                icon: const Icon(
                                    CupertinoIcons.ellipsis_vertical),
                                iconSize: smallSize + 10,
                                onPressed: _showDeviceOptionsBottomSheet,
                              ),
                          ],
                        ),
                        verticalSpaceSmall,
                        // Device Information
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isCompact) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.device.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                  ),
                                  CupertinoSwitch(
                                    value: widget.device.isActive,
                                    onChanged: (newValue) async {
                                      setState(() {
                                        widget.device.isActive = newValue;
                                      });
                                      await FirebaseFirestore.instance
                                          .collection('devices')
                                          .doc(widget.device.did)
                                          .update({'isActive': newValue});
                                    },
                                    activeColor: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    trackColor: Theme.of(context)
                                        .colorScheme
                                        .onTertiary,
                                  ),
                                ],
                              ),
                            ],
                            if (isCompact)
                              Text(
                                widget.device.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                            verticalSpaceSmall,
                            Text(
                              widget.device.isActive ? "ON" : "OFF",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onTertiary,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .fontSize,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          },
        );
      },
    );
  }
}
