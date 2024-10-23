import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/features/home/ui/room_details_screen.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  final TextEditingController _deviceCountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<RoomCubit>().fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Theme
          .of(context)
          .colorScheme
          .onTertiary
          .withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .onSurface,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: Theme
                .of(context)
                .colorScheme
                .scrim,
            size: mediumSize,
          ),
          onPressed: () {
            context.router.maybePop();
          },
        ),
        title: Text(
          "Rooms",
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
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.add,
              color: Theme
                  .of(context)
                  .colorScheme
                  .scrim,
              size: mediumSize,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(smallSize),
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onSurface,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(mediumSize),
                          topLeft: Radius.circular(mediumSize)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Room',
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .scrim,
                                fontFamily: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontFamily,
                                fontSize: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontSize,
                              ),
                            ),
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onTertiary
                                    .withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  CupertinoIcons.xmark,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .scrim,
                                ),
                                onPressed: () {
                                  context.router.maybePop();
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
                                  controller: _descriptionController,
                                  keyboardType: TextInputType.text,
                                  outlined: false,
                                ),
                                Input(
                                  label: "No Of Devices",
                                  controller: _deviceCountController,
                                  keyboardType: TextInputType.number,
                                  outlined: false,
                                ),
                              ],
                            )),
                        verticalSpaceMedium,
                        Button(
                            label: 'Confirm',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                context
                                    .read<RoomCubit>()
                                    .createRoom(RoomModel.fromJson({
                                  'name': _nameController.text.trim(),
                                  'description':
                                  _descriptionController.text,
                                  'totalDevices':
                                  int.tryParse(_deviceCountController.text),
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(mediumSize),
                child: BlocBuilder<RoomCubit, RoomState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Text(''),
                      loading: () =>
                          Center(
                            child: CircularProgressIndicator(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                      loaded: (rooms) =>
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height,
                            child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: smallSize,
                                mainAxisSpacing: smallSize,
                                children: List.generate(rooms.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                  context
                                      .read<RoomCubit>()
                                      .fetchRoomById(rooms[index].rid!);
                                }, child: Card(
                                    color: RoomUtils()
                                        .getCardBackgroundColor(
                                        context, rooms[index].name),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Container(
                                          width: 50,
                                          // Diameter of the circular background
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .onSurface, // Background color
                                            shape: BoxShape
                                                .circle, // Makes the background circular
                                          ),
                                          child: Icon(
                                            RoomUtils()
                                                .getCardIcon(rooms[index].name),
                                            color: RoomUtils()
                                                .getCardBackgroundColor(
                                                context, rooms[index].name),
                                            size: mediumSize,
                                          ),
                                        ),
                                        verticalSpaceSmall,
                                        Text(
                                          rooms[index].name,
                                          style: TextStyle(
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .onSurface,
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
                                        verticalSpaceSmall,
                                        Text(
                                          "${rooms[index].totalDevices
                                              .toString()} Device(s)",
                                          style: TextStyle(
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .onTertiary,
                                            fontFamily: Theme
                                                .of(context)
                                                .textTheme
                                                .labelSmall!
                                                .fontFamily,
                                            fontSize: Theme
                                                .of(context)
                                                .textTheme
                                                .labelSmall!
                                                .fontSize,
                                            fontWeight: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .fontWeight,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),);
                                })),
                          ),
                      detailsLoaded: (RoomModel room) =>
                          RoomDetailsScreen(roomModel: room),
                      error: (error) =>
                          Center(
                              child: Text(
                                error,
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .error,
                                    fontSize: Theme
                                        .of(context)
                                        .textTheme
                                        .titleSmall!
                                        .fontSize),
                              )),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
