import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/features/device/logic/device_cubit.dart';
import 'package:ecowatt/features/device/logic/device_state.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:ecowatt/shared/widgets/device_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/device_model.dart';

@RoutePage()
class SearchDeviceScreen extends StatefulWidget {
  const SearchDeviceScreen({super.key});

  @override
  State<SearchDeviceScreen> createState() => _SearchDeviceScreenState();
}

class _SearchDeviceScreenState extends State<SearchDeviceScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DeviceModel> _filteredDevices = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    context.read<DeviceCubit>().fetchAllDevices();
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _filteredDevices = [];
      _hasSearched = false;
    });
  }

  void _performSearch(String query) {
    setState(() {
      _hasSearched = query.isNotEmpty;
    });

    if (query.isEmpty) {
      setState(() {
        _filteredDevices = [];
      });
      return;
    }

    // Get all devices from the state
    final currentState = context.read<DeviceCubit>().state;

    if (currentState is DeviceLoaded) {
      setState(() {
        _filteredDevices = currentState.devices
            .where((device) =>
                device.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
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
        leadingWidth: 25,
        title: SizedBox(
          width: 300.0,
          height: 40.0,
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        CupertinoIcons.xmark,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      onPressed: _clearSearch,
                    )
                  : null,
              hintText: 'Search for devices...',
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.scrim,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(tinySize),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.onTertiary,
            ),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.scrim,
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
            onChanged: _performSearch,
          ),
        ),
      ),
      body: BlocBuilder<DeviceCubit, DeviceState>(
        builder: (context, state) {
          return state.when(
            initial: () => _buildInitialState(),
            loading: () => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            loaded: (devices) => _buildDeviceContent(devices),
            error: (error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(smallSize),
                child: Text(
                  error,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontFamily:
                        Theme.of(context).textTheme.bodySmall!.fontFamily,
                    fontSize:
                        Theme.of(context).textTheme.bodySmall!.fontSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/search/search-devices.png',
            width: 250,
            height: 250,
          ),
          verticalSpaceMedium,
          Text(
            'Looking for any devices in particular ?',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
                fontFamily: Theme.of(context).textTheme.bodySmall?.fontFamily,
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,),
          )
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/errors/404.png',
            width: 250,
            height: 250,
          ),
          verticalSpaceMedium,
          Text.rich(
            TextSpan(
                text: 'No matches found for ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                ),
                children: [
                  TextSpan(
                    text: _searchController.text,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily:
                          Theme.of(context).textTheme.titleSmall!.fontFamily,
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.titleSmall!.fontWeight,
                    ),
                  )
                ]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceContent(List<DeviceModel> devices) {
    // If no search has been performed yet, show initial state
    if (!_hasSearched) {
      return _buildInitialState();
    }

    // If search has been performed but no devices match
    if (_filteredDevices.isEmpty) {
      return _buildEmptyState();
    }

    // If devices match the search
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: smallSize, vertical: mediumSize),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredDevices.length,
              itemBuilder: (context, index) {
                return DeviceCard(
                  device: _filteredDevices[index],
                  isCompact: false,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
