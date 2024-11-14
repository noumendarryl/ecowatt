import 'package:ecowatt/features/dashboard/logic/device_measurement_cubit.dart';
import 'package:ecowatt/features/dashboard/repositories/device_measurement_repository.dart';
import 'package:ecowatt/features/device/logic/device_cubit.dart';
import 'package:ecowatt/features/device/logic/device_type_cubit.dart';
import 'package:ecowatt/features/device/repositories/device_repository.dart';
import 'package:ecowatt/features/device/repositories/device_type_repository.dart';
import 'package:ecowatt/features/home/logic/room_cubit.dart';
import 'package:ecowatt/features/home/repositories/room_repository.dart';
import 'package:ecowatt/features/profile/logic/user_cubit.dart';
import 'package:ecowatt/features/profile/repositories/user_repository.dart';
import 'package:ecowatt/features/recommendations/logic/recommendation_cubit.dart';
import 'package:ecowatt/features/recommendations/repositories/recommendation_repository.dart';
import 'package:ecowatt/features/weather/logic/weather_cubit.dart';
import 'package:ecowatt/features/weather/repositories/weather_repository.dart';
import 'package:ecowatt/routing/app_router.dart';
import 'package:ecowatt/shared/themes/app_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/logic/auth_cubit.dart';
import 'features/auth/repositories/auth_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<RoomRepository>(
          create: (context) => RoomRepository(),
        ),
        RepositoryProvider<DeviceRepository>(
          create: (context) => DeviceRepository(),
        ),
        RepositoryProvider<DeviceTypeRepository>(
          create: (context) => DeviceTypeRepository(),
        ),
        RepositoryProvider<RecommendationRepository>(
          create: (context) => RecommendationRepository(),
        ),
        RepositoryProvider<DeviceMeasurementRepository>(
          create: (context) => DeviceMeasurementRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<WeatherRepository>(
          create: (context) => WeatherRepository(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(context.read<AuthRepository>()),
            ),
            BlocProvider<RoomCubit>(
              create: (context) => RoomCubit(context.read<RoomRepository>()),
            ),
            BlocProvider<DeviceCubit>(
              create: (context) => DeviceCubit(context.read<DeviceRepository>()),
            ),
            BlocProvider<DeviceTypeCubit>(
              create: (context) => DeviceTypeCubit(context.read<DeviceTypeRepository>()),
            ),
            BlocProvider<RecommendationCubit>(
              create: (context) => RecommendationCubit(context.read<RecommendationRepository>()),
            ),
            BlocProvider<DeviceMeasurementCubit>(
              create: (context) => DeviceMeasurementCubit(context.read<DeviceMeasurementRepository>()),
            ),
            BlocProvider<UserCubit>(
              create: (context) => UserCubit(context.read<UserRepository>()),
            ),
            BlocProvider<WeatherCubit>(
              create: (context) => WeatherCubit(context.read<WeatherRepository>()),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            routerConfig: _appRouter.config(),
          )),
    );
  }
}