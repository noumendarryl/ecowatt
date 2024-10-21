import 'package:auto_route/annotations.dart';
import 'package:ecowatt/features/device/logic/device_cubit.dart';
import 'package:ecowatt/features/device/logic/device_state.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/BaseLayout.dart';
import '../../../shared/widgets/device_card.dart';
import '../models/device_model.dart';

@RoutePage()
class SearchDeviceScreen extends StatefulWidget {
  const SearchDeviceScreen({super.key});

  @override
  State<SearchDeviceScreen> createState() => _SearchDeviceScreenState();
}

class _SearchDeviceScreenState extends State<SearchDeviceScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: BaseLayout(
        currentIndex: 1,
      title: 'ReSearch',
        child: Container(
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
                        color: const Color(0xFFFFE361).withOpacity(0.2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(CupertinoIcons.search,
                                  color: Theme.of(context).colorScheme.scrim),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(CupertinoIcons.xmark,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .scrim),
                                      onPressed: _clearSearch,
                                    )
                                  : null,
                              hintText: 'Search for devices...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.1),
                            ),
                            onChanged: (query) {
                              if (query.isEmpty) {
                                _clearSearch();
                              } else {
                                context
                                    .read<DeviceCubit>()
                                    .searchDevicesByName(query);
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: BlocBuilder<DeviceCubit, DeviceState>(
                                builder: (context, state) {
                              return state.when(
                                initial: () => const Center(child: Text('')),
                                loading: () => Center(
                                  child: CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                loaded: (devices) => SingleChildScrollView(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: devices.length,
                                    itemBuilder: (context, index) {
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
                                    },
                                  ),
                                ),
                                error: (error) => Center(child: Text(error)),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: smallSize),
                        child: Text(
                          'Looking for more devices ?',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
