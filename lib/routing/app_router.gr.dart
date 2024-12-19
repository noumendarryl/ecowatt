// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:ecowatt/features/auth/ui/login.dart' as _i5;
import 'package:ecowatt/features/auth/ui/register.dart' as _i8;
import 'package:ecowatt/features/dashboard/ui/dashboard.dart' as _i2;
import 'package:ecowatt/features/device/ui/add_device_screen.dart' as _i1;
import 'package:ecowatt/features/device/ui/search_device_screen.dart' as _i11;
import 'package:ecowatt/features/home/models/room_model.dart' as _i19;
import 'package:ecowatt/features/home/ui/home_screen.dart' as _i4;
import 'package:ecowatt/features/home/ui/room_details_screen.dart' as _i9;
import 'package:ecowatt/features/home/ui/room_list_screen.dart' as _i10;
import 'package:ecowatt/features/onboarding/ui/onboarding_screen.dart' as _i6;
import 'package:ecowatt/features/profile/ui/edit_profile_screen.dart' as _i3;
import 'package:ecowatt/features/profile/ui/user_profile_screen.dart' as _i13;
import 'package:ecowatt/features/recommendations/ui/recommendation_screen.dart'
    as _i7;
import 'package:ecowatt/features/splash_screen/ui/splash_screen.dart' as _i12;
import 'package:ecowatt/features/voice_command/ui/voice_command_screen.dart'
    as _i14;
import 'package:ecowatt/features/weather/ui/weather_screen.dart' as _i15;
import 'package:flutter/cupertino.dart' as _i17;
import 'package:flutter/material.dart' as _i18;

abstract class $AppRouter extends _i16.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    AddDeviceRoute.name: (routeData) {
      final args = routeData.argsAs<AddDeviceRouteArgs>(
          orElse: () => const AddDeviceRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddDeviceScreen(
          key: args.key,
          roomId: args.roomId,
        ),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DashboardPage(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.EditProfileScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
      );
    },
    Login.name: (routeData) {
      final args = routeData.argsAs<LoginArgs>(orElse: () => const LoginArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.Login(key: args.key),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.OnboardingScreen(),
      );
    },
    RecommendationsRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RecommendationsScreen(),
      );
    },
    Register.name: (routeData) {
      final args =
          routeData.argsAs<RegisterArgs>(orElse: () => const RegisterArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.Register(key: args.key),
      );
    },
    RoomDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<RoomDetailsRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.RoomDetailsScreen(
          key: args.key,
          room: args.room,
        ),
      );
    },
    RoomListRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.RoomListScreen(),
      );
    },
    SearchDeviceRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.SearchDeviceScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.SplashScreen(),
      );
    },
    UserProfileRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.UserProfileScreen(),
      );
    },
    VoiceCommandRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.VoiceCommandScreen(),
      );
    },
    WeatherRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.WeatherScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddDeviceScreen]
class AddDeviceRoute extends _i16.PageRouteInfo<AddDeviceRouteArgs> {
  AddDeviceRoute({
    _i17.Key? key,
    String? roomId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          AddDeviceRoute.name,
          args: AddDeviceRouteArgs(
            key: key,
            roomId: roomId,
          ),
          initialChildren: children,
        );

  static const String name = 'AddDeviceRoute';

  static const _i16.PageInfo<AddDeviceRouteArgs> page =
      _i16.PageInfo<AddDeviceRouteArgs>(name);
}

class AddDeviceRouteArgs {
  const AddDeviceRouteArgs({
    this.key,
    this.roomId,
  });

  final _i17.Key? key;

  final String? roomId;

  @override
  String toString() {
    return 'AddDeviceRouteArgs{key: $key, roomId: $roomId}';
  }
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i16.PageRouteInfo<void> {
  const DashboardRoute({List<_i16.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EditProfileScreen]
class EditProfileRoute extends _i16.PageRouteInfo<void> {
  const EditProfileRoute({List<_i16.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i5.Login]
class Login extends _i16.PageRouteInfo<LoginArgs> {
  Login({
    _i18.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          Login.name,
          args: LoginArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Login';

  static const _i16.PageInfo<LoginArgs> page = _i16.PageInfo<LoginArgs>(name);
}

class LoginArgs {
  const LoginArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'LoginArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.OnboardingScreen]
class OnboardingRoute extends _i16.PageRouteInfo<void> {
  const OnboardingRoute({List<_i16.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i7.RecommendationsScreen]
class RecommendationsRoute extends _i16.PageRouteInfo<void> {
  const RecommendationsRoute({List<_i16.PageRouteInfo>? children})
      : super(
          RecommendationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecommendationsRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i8.Register]
class Register extends _i16.PageRouteInfo<RegisterArgs> {
  Register({
    _i18.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          Register.name,
          args: RegisterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Register';

  static const _i16.PageInfo<RegisterArgs> page =
      _i16.PageInfo<RegisterArgs>(name);
}

class RegisterArgs {
  const RegisterArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'RegisterArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.RoomDetailsScreen]
class RoomDetailsRoute extends _i16.PageRouteInfo<RoomDetailsRouteArgs> {
  RoomDetailsRoute({
    _i17.Key? key,
    required _i19.RoomModel room,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          RoomDetailsRoute.name,
          args: RoomDetailsRouteArgs(
            key: key,
            room: room,
          ),
          initialChildren: children,
        );

  static const String name = 'RoomDetailsRoute';

  static const _i16.PageInfo<RoomDetailsRouteArgs> page =
      _i16.PageInfo<RoomDetailsRouteArgs>(name);
}

class RoomDetailsRouteArgs {
  const RoomDetailsRouteArgs({
    this.key,
    required this.room,
  });

  final _i17.Key? key;

  final _i19.RoomModel room;

  @override
  String toString() {
    return 'RoomDetailsRouteArgs{key: $key, room: $room}';
  }
}

/// generated route for
/// [_i10.RoomListScreen]
class RoomListRoute extends _i16.PageRouteInfo<void> {
  const RoomListRoute({List<_i16.PageRouteInfo>? children})
      : super(
          RoomListRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoomListRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SearchDeviceScreen]
class SearchDeviceRoute extends _i16.PageRouteInfo<void> {
  const SearchDeviceRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SearchDeviceRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchDeviceRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i12.SplashScreen]
class SplashRoute extends _i16.PageRouteInfo<void> {
  const SplashRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i13.UserProfileScreen]
class UserProfileRoute extends _i16.PageRouteInfo<void> {
  const UserProfileRoute({List<_i16.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i14.VoiceCommandScreen]
class VoiceCommandRoute extends _i16.PageRouteInfo<void> {
  const VoiceCommandRoute({List<_i16.PageRouteInfo>? children})
      : super(
          VoiceCommandRoute.name,
          initialChildren: children,
        );

  static const String name = 'VoiceCommandRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i15.WeatherScreen]
class WeatherRoute extends _i16.PageRouteInfo<void> {
  const WeatherRoute({List<_i16.PageRouteInfo>? children})
      : super(
          WeatherRoute.name,
          initialChildren: children,
        );

  static const String name = 'WeatherRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}
