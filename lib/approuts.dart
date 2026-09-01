import 'package:go_router/go_router.dart';
import 'package:local_storage_options/screens/onboarding_screen.dart';
import 'package:local_storage_options/screens/welcome_screem.dart';

class Approuts {
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
}

GoRouter router(String initialLocation) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: Approuts.onboarding,
        builder: (context, state) =>  OnboardingScreen(),
      ) , 
      GoRoute(
        path: Approuts.welcome,
        builder: (context, state) =>  WelcomeScreen(),
      )
    ]
  );
}
