import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: Login.page),
    AutoRoute(page: Register.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: RoomListRoute.page),
    AutoRoute(page: RoomDetailsRoute.page),
    AutoRoute(page: AddDeviceRoute.page),
    AutoRoute(page: SearchDeviceRoute.page),
    AutoRoute(page: UserProfileRoute.page),
    AutoRoute(page: EditProfileRoute.page),
    AutoRoute(page: RecommendationsRoute.page),
    AutoRoute(page: DashboardRoute.page),
    AutoRoute(page: WeatherRoute.page),
    AutoRoute(page: VoiceCommandRoute.page),
  ];
}
