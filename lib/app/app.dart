import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/cursor_follower.dart';
import 'package:portfolio/app/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: GoogleFonts.interTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
  );

  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
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
            title: 'Kazi Woaej Mariz',
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: false),
            theme: isDark ? _darkTheme : _lightTheme,
            routerConfig: appRouter,
            builder: (context, child) {
              final isMobile = MediaQuery.of(context).size.width < 900;
              if (isMobile) return child ?? const SizedBox.shrink();

              // Desktop: hide system cursor + show circle follower globally
              return MouseRegion(
                cursor: SystemMouseCursors.none,
                child: Stack(
                  children: [
                    Positioned.fill(child: child ?? const SizedBox.shrink()),
                    const Positioned.fill(child: CursorFollower()),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
