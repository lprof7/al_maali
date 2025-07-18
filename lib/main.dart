import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'app/views/level_screen.dart';
import 'app/views/texts_screen.dart';
import 'app/views/text_detail_screen.dart';
import 'app/views/word_detail_screen.dart';
import 'app/controllers/level_controller.dart';
import 'app/controllers/text_controller.dart';
import 'app/utils/responsive_utils.dart';
import 'app/views/login_screen.dart';
import 'app/views/register_screen.dart';
import 'app/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Animate.restartOnHotReload = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'المعالي',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF6D4C41), // بني داكن
          secondary: Color(0xFFD7CCC8), // بيج فاتح
          surface: Color(0xFFEFEBE9), // بيج أفتح
          background: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Color(0xFF4E342E), // بني داكن للنصوص
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 32),
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          margin: EdgeInsets.all(ResponsiveUtils.getResponsiveSize(context, 8)),
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(LevelController());
        Get.put(TextController());
        Get.put(AuthController());
      }),
      getPages: [
        GetPage(
          name: '/',
          page: () => const LoginScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/levels',
          page: () => const LevelScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/texts',
          page: () => const TextsScreen(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/text-detail',
          page: () => TextDetailScreen(),
          transition: Transition.zoom,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/word-details',
          page: () => const WordDetailScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterScreen(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ],
      locale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      defaultTransition: Transition.fadeIn,
    );
  }
}
