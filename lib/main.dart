import 'package:ecowatt/routing/app_router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import 'features/auth/logic/auth_cubit.dart';

import 'features/auth/repository/auth_repository.dart';
import 'features/dashboard/logic/electricity_cubit.dart';
import 'features/dashboard/repository/electricity_repository.dart';
import 'features/device/logic/device_cubit.dart';
import 'features/device/logic/device_measurement_cubit.dart';
import 'features/device/logic/device_type_cubit.dart';
import 'features/device/repositories/device_measurement_repository.dart';
import 'features/device/repositories/device_repository.dart';
import 'features/device/repositories/device_type_repository.dart';
import 'features/home/logic/room_cubit.dart';
import 'features/home/repositories/room_repository.dart';
import 'features/profile/logic/edit_profile_cubit.dart';
import 'features/profile/logic/user_cubit.dart';
import 'features/profile/repository/user_repository.dart';
import 'features/recommandations/logic/recommandation_cubit.dart';
import 'features/recommandations/repository/recommendations_repository.dart';
import 'features/weather/logic/weather_cubit.dart';
import 'features/weather/repository/weather_repository.dart';
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
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<WeatherRepository>(
          create: (context) => WeatherRepository(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<RecommendationRepository>(
          create: (context) => RecommendationRepository(),
        ),
        RepositoryProvider<ElectricityRepository>(
          create: (context) => ElectricityRepository(),
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
        RepositoryProvider<DeviceMeasurementRepository>(
          create: (context) => DeviceMeasurementRepository(),
        ),
        // RepositoryProvider<EquipmentRepository>(
        //   create: (context) => EquipmentRepository(),
        // ),
        // RepositoryProvider<IndustryRepository>(
        //   create: (context) => IndustryRepository(),
        // ),
        // RepositoryProvider<TutorialRepository>(
        //   create: (context) => TutorialRepository(),
        // ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => UserCubit(
                  context.read<UserRepository>(),

                )),
            BlocProvider(
                create: (context) => WeatherCubit(
                  context.read<WeatherRepository>(),

                )),
            BlocProvider<EditProfileCubit>(
              create: (context) => EditProfileCubit(context.read<UserRepository>(), context.read<AuthRepository>()),
            ),
            BlocProvider<ElectricityCubit>(
              create: (context) => ElectricityCubit(context.read<ElectricityRepository>()),
            ),
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(context.read<AuthRepository>()),
            ),
            BlocProvider<RecommendationCubit>(
              create: (context) => RecommendationCubit(context.read<RecommendationRepository>()),
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
            BlocProvider<DeviceMeasurementCubit>(
              create: (context) => DeviceMeasurementCubit(context.read<DeviceMeasurementRepository>()),
            ),

            // BlocProvider<CategoryCubit>(
            //   create: (context) => CategoryCubit(),
            // ),
            // BlocProvider<EquipmentCubit>(
            //   create: (context) => EquipmentCubit(context.read<EquipmentRepository>()),
            // ),
            // BlocProvider<IndustryCubit>(
            //   create: (context) => IndustryCubit(context.read<IndustryRepository>()),
            // ),
            // BlocProvider<TutorialCubit>(
            //   create: (context) => TutorialCubit(context.read<TutorialRepository>()),
            // ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            //theme: AppThemes.lightTheme,
            routerConfig: _appRouter.config(),
          )),
    );
  }
}