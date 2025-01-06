import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vital_health/app/onboarding/onboarding_screen.dart';

Future<void> main() async {
  // This is to ensure that the app's orientation stays portrait
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Initialize the ScreenUtil package for responsive UI
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          home: const OnboardingScreen(), // Starting point of the app
        );
      },
    );
  }
}
