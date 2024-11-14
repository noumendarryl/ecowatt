import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/features/device/logic/device_cubit.dart';
import 'package:ecowatt/features/device/logic/device_state.dart';
import 'package:ecowatt/routing/app_router.gr.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:ecowatt/shared/widgets/device_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/text_rich.dart';
import '../models/device_model.dart';

@RoutePage()
class SearchDeviceScreen extends StatefulWidget {
  const SearchDeviceScreen({super.key});

  @override
  State<SearchDeviceScreen> createState() => _SearchDeviceScreenState();
}

class _SearchDeviceScreenState extends State<SearchDeviceScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DeviceCubit>().fetchAllDevices();
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onTertiary.withOpacity(0.3),
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.onTertiary,
              size: mediumSize,
            ),
            onPressed: () {
              context.router.maybePop();
            },
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: tinySize),
            child: SizedBox(
              width: double.maxFinite,
              height: smallSize,
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.search,
                      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1)),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(CupertinoIcons.xmark,
                              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1)),
                          onPressed: _clearSearch,
                        )
                      : null,
                  hintText: 'Search devices...',
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.scrim,
                      fontSize:
                          Theme.of(context).textTheme.bodySmall?.fontSize),
                  labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.scrim,
                      fontSize:
                      Theme.of(context).textTheme.bodySmall?.fontSize),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(mediumSize),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                ),
                onChanged: (query) {
                  if (query.isEmpty) {
                    _clearSearch();
                  } else {
                    context.read<DeviceCubit>().searchDevicesByName(query);
                  }
                },
              ),
            ),
          )),
      body: Container(
        color: Theme.of(context).colorScheme.onSurface,
        child: Center(
          child: SafeArea(
            child: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      CupertinoIcons.search,
                      size: 200.0,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                  BlocBuilder<DeviceCubit, DeviceState>(
                      builder: (context, state) {
                    return state.when(
                      initial: () => const Center(child: Text('Hello')),
                      loading: () => Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      loaded: (devices) => SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: devices.length,
                          itemBuilder: (context, index) {
                            return DeviceCard(
                                device: DeviceModel(
                                    name: devices[index].name,
                                    type: devices[index].type,
                                    rid: devices[index].rid,
                                    uid: FirebaseAuth
                                        .instance.currentUser!.uid,
                                    isActive: devices[index].isActive,
                                    isSmartDevice:
                                        devices[index].isSmartDevice));
                          },
                        ),
                      ),
                      error: (error) => Center(child: Text(error)),
                    );
                  }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: smallSize),
                      child: TextRich(
                        secondaryText: " Looking for more devices ?",
                        alignment: Alignment.center,
                        onClick: () {
                          context.pushRoute(const RoomListRoute());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
