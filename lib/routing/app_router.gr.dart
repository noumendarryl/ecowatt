// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:ecowatt/features/auth/ui/login.dart' as _i4;
import 'package:ecowatt/features/auth/ui/register.dart' as _i5;
import 'package:ecowatt/features/device/models/device_model.dart' as _i13;
import 'package:ecowatt/features/device/ui/add_device_screen.dart' as _i1;
import 'package:ecowatt/features/device/ui/device_details_screen.dart' as _i2;
import 'package:ecowatt/features/device/ui/search_device_screen.dart' as _i8;
import 'package:ecowatt/features/home/models/room_model.dart' as _i15;
import 'package:ecowatt/features/home/ui/home_screen.dart' as _i3;
import 'package:ecowatt/features/home/ui/room_details_screen.dart' as _i6;
import 'package:ecowatt/features/home/ui/room_list_screen.dart' as _i7;
import 'package:ecowatt/features/splashscreen/ui/splash_screen.dart' as _i9;
import 'package:ecowatt/features/welcome/ui/welcome_screen.dart' as _i10;
import 'package:flutter/cupertino.dart' as _i12;
import 'package:flutter/material.dart' as _i14;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    AddDeviceRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddDeviceScreen(),
      );
    },
    DeviceDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DeviceDetailsRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DeviceDetailsScreen(
          key: args.key,
          deviceModel: args.deviceModel,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    Login.name: (routeData) {
      final args = routeData.argsAs<LoginArgs>(orElse: () => const LoginArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.Login(key: args.key),
      );
    },
    Register.name: (routeData) {
      final args =
          routeData.argsAs<RegisterArgs>(orElse: () => const RegisterArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.Register(key: args.key),
      );
    },
    RoomDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<RoomDetailsRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.RoomDetailsScreen(
          key: args.key,
          roomModel: args.roomModel,
        ),
      );
    },
    RoomListRoute.name: (routeData) {
      final args = routeData.argsAs<RoomListRouteArgs>(
          orElse: () => const RoomListRouteArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.RoomListScreen(key: args.key),
      );
    },
    SearchDeviceRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SearchDeviceScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SplashScreen(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddDeviceScreen]
class AddDeviceRoute extends _i11.PageRouteInfo<void> {
  const AddDeviceRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AddDeviceRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddDeviceRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DeviceDetailsScreen]
class DeviceDetailsRoute extends _i11.PageRouteInfo<DeviceDetailsRouteArgs> {
  DeviceDetailsRoute({
    _i12.Key? key,
    required _i13.DeviceModel deviceModel,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          DeviceDetailsRoute.name,
          args: DeviceDetailsRouteArgs(
            key: key,
            deviceModel: deviceModel,
          ),
          initialChildren: children,
        );

  static const String name = 'DeviceDetailsRoute';

  static const _i11.PageInfo<DeviceDetailsRouteArgs> page =
      _i11.PageInfo<DeviceDetailsRouteArgs>(name);
}

class DeviceDetailsRouteArgs {
  const DeviceDetailsRouteArgs({
    this.key,
    required this.deviceModel,
  });

  final _i12.Key? key;

  final _i13.DeviceModel deviceModel;

  @override
  String toString() {
    return 'DeviceDetailsRouteArgs{key: $key, deviceModel: $deviceModel}';
  }
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.Login]
class Login extends _i11.PageRouteInfo<LoginArgs> {
  Login({
    _i14.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          Login.name,
          args: LoginArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Login';

  static const _i11.PageInfo<LoginArgs> page = _i11.PageInfo<LoginArgs>(name);
}

class LoginArgs {
  const LoginArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'LoginArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.Register]
class Register extends _i11.PageRouteInfo<RegisterArgs> {
  Register({
    _i14.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          Register.name,
          args: RegisterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Register';

  static const _i11.PageInfo<RegisterArgs> page =
      _i11.PageInfo<RegisterArgs>(name);
}

class RegisterArgs {
  const RegisterArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'RegisterArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.RoomDetailsScreen]
class RoomDetailsRoute extends _i11.PageRouteInfo<RoomDetailsRouteArgs> {
  RoomDetailsRoute({
    _i12.Key? key,
    required _i15.RoomModel roomModel,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          RoomDetailsRoute.name,
          args: RoomDetailsRouteArgs(
            key: key,
            roomModel: roomModel,
          ),
          initialChildren: children,
        );

  static const String name = 'RoomDetailsRoute';

  static const _i11.PageInfo<RoomDetailsRouteArgs> page =
      _i11.PageInfo<RoomDetailsRouteArgs>(name);
}

class RoomDetailsRouteArgs {
  const RoomDetailsRouteArgs({
    this.key,
    required this.roomModel,
  });

  final _i12.Key? key;

  final _i15.RoomModel roomModel;

  @override
  String toString() {
    return 'RoomDetailsRouteArgs{key: $key, roomModel: $roomModel}';
  }
}

/// generated route for
/// [_i7.RoomListScreen]
class RoomListRoute extends _i11.PageRouteInfo<RoomListRouteArgs> {
  RoomListRoute({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          RoomListRoute.name,
          args: RoomListRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RoomListRoute';

  static const _i11.PageInfo<RoomListRouteArgs> page =
      _i11.PageInfo<RoomListRouteArgs>(name);
}

class RoomListRouteArgs {
  const RoomListRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'RoomListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.SearchDeviceScreen]
class SearchDeviceRoute extends _i11.PageRouteInfo<void> {
  const SearchDeviceRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SearchDeviceRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchDeviceRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i10.WelcomeScreen]
class WelcomeRoute extends _i11.PageRouteInfo<void> {
  const WelcomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
