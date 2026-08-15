import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/app/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.interTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
  );

  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: GoogleFonts.interTextTheme(
      ThemeData(brightness: Brightness.light).textTheme,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Selector<HomeViewModel, bool>(
        selector: (_, vm) => vm.isDarkMode,
        builder: (context, isDark, _) {
          return MaterialApp.router(
            title: 'Portfolio Bento',
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: false),
            theme: isDark ? _darkTheme : _lightTheme,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
