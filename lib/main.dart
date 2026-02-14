import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/colors.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
