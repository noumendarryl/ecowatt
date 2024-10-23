import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/features/device/logic/device_cubit.dart';
import 'package:ecowatt/features/home/models/room_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/constants/ui_helpers.dart';
import '../../../shared/utils/device_utils.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/input.dart';
import '../../home/repositories/room_repository.dart';
import '../logic/device_type_cubit.dart';
import '../logic/device_type_state.dart';
import '../models/device_model.dart';

@RoutePage()
class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<RoomModel> rooms = [];
  String? selectedRoomId;
  String? selectedDeviceType;
  bool _isDeviceActive = false;
  bool _isSmartDevice = false;

  @override
  void initState() {
    super.initState();
    context.read<DeviceTypeCubit>().loadDeviceTypes();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    RoomRepository roomRepo = RoomRepository();
    List<RoomModel> fetchedRooms = await roomRepo.getAllRooms();
    setState(() {
      rooms = fetchedRooms;
    });
  }

  // This method will handle when a device type is selected
  void _onDeviceTypeSelected(String deviceType) {
    setState(() {
      selectedDeviceType = deviceType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.onTertiary.withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: Theme.of(context).colorScheme.scrim,
            size: mediumSize,
          ),
          onPressed: () {
            context.router.pop();
          },
        ),
        title: Text(
          "Select Device Type",
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
            fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            fontWeight: Theme.of(context).textTheme.titleSmall!.fontWeight,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.ellipsis_vertical,
              color: Theme.of(context).colorScheme.scrim,
              size: mediumSize,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(mediumSize),
          child: BlocBuilder<DeviceTypeCubit, DeviceTypeState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Text(''),
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                loaded: (deviceTypes) => GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: mediumSize,
                    mainAxisSpacing: mediumSize,
                    children: List.generate(4, (index) {
                      return GestureDetector(
                        onTap: () {
                          _onDeviceTypeSelected(deviceTypes[index].name);
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(smallSize),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(mediumSize),
                                      topLeft: Radius.circular(mediumSize)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Add Device',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .scrim,
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .fontFamily,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .fontSize,
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
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .scrim,
                                            ),
                                            onPressed: () {
                                              context.router.pop();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    Form(
                                        key: _formKey,
                                        child: Wrap(
                                          runSpacing: mediumSize,
                                          children: [
                                            Input(
                                              label: "Name",
                                              controller: _nameController,
                                              keyboardType: TextInputType.text,
                                              outlined: false,
                                            ),
                                            Input(
                                              label: "Description",
                                              controller:
                                                  _descriptionController,
                                              keyboardType: TextInputType.text,
                                              outlined: false,
                                            ),
                                            Text(
                                              'Where is/are you device(s) installed ?',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onTertiary,
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontFamily,
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontSize,
                                              ),
                                            ),
                                            DropdownButton<String>(
                                              value: selectedRoomId,
                                              items:
                                                  rooms.map((RoomModel room) {
                                                return DropdownMenuItem<String>(
                                                  value: room.rid,
                                                  child: Text(room.name),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedRoomId = value!;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Is you device active ?',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onTertiary,
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontFamily,
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontSize,
                                              ),
                                            ),
                                            DropdownButton<bool>(
                                              value: _isDeviceActive,
                                              items: const [
                                                DropdownMenuItem(
                                                    value: true,
                                                    child: Text('Active')),
                                                DropdownMenuItem(
                                                    value: false,
                                                    child: Text('Inactive')),
                                              ],
                                              onChanged: (value) {
                                                setState(() {
                                                  _isDeviceActive = value!;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Is it a smart device ?',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onTertiary,
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontFamily,
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontSize,
                                              ),
                                            ),
                                            DropdownButton<bool>(
                                              value: _isSmartDevice,
                                              items: const [
                                                DropdownMenuItem(
                                                    value: true,
                                                    child:
                                                        Text('Smart Device')),
                                                DropdownMenuItem(
                                                    value: false,
                                                    child: Text(
                                                        'Not Smart Device')),
                                              ],
                                              onChanged: (value) {
                                                setState(() {
                                                  _isSmartDevice = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        )),
                                    verticalSpaceSmall,
                                    Button(
                                        label: 'Confirm',
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            context
                                                .read<DeviceCubit>()
                                                .createDevice(
                                                    DeviceModel.fromJson({
                                                  'name': _nameController.text
                                                      .trim(),
                                                  'type': selectedDeviceType,
                                                  'rid': selectedRoomId,
                                                  'uid': FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  'description':
                                                      _descriptionController
                                                          .text,
                                                  'isActive': _isDeviceActive,
                                                  'isSmartDevice':
                                                      _isSmartDevice,
                                                }));
                                            _formKey.currentState!.reset();
                                          }
                                        })
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              color: DeviceUtils().getCardBackgroundColor(
                                  context, deviceTypes[index].name),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(smallSize)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                // Diameter of the circular background
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface, // Background color
                                  shape: BoxShape
                                      .circle, // Makes the background circular
                                ),
                                child: Icon(
                                  DeviceUtils()
                                      .getCardIcon(deviceTypes[index].name),
                                  color: DeviceUtils().getCardBackgroundColor(
                                      context, deviceTypes[index].name),
                                  size: mediumSize,
                                ),
                              ),
                              verticalSpaceSmall,
                              Text(
                                deviceTypes[index].name,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
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
                error: (error) => Center(
                    child: Text(
                  error,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize),
                )),
              );
            },
          )),
    );
  }
}
