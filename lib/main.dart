import 'package:ecowatt/routing/app_router.dart';
import 'package:ecowatt/shared/themes/app_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/logic/auth_cubit.dart';
import 'features/auth/repository/auth_repository.dart';
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
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(context.read<AuthRepository>()),
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
            theme: AppThemes.lightTheme,
            routerConfig: _appRouter.config(),
          )),
    );
  }
}