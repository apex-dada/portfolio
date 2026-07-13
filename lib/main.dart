import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/view/home_view.dart';
import 'package:portfolio/viewmodel/home_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, _) {
          final isDark = homeViewModel.isDarkMode;
          return MaterialApp(
            title: 'Portfolio Bento',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              brightness: isDark ? Brightness.dark : Brightness.light,
              textTheme: GoogleFonts.interTextTheme(
                ThemeData(brightness: isDark ? Brightness.dark : Brightness.light).textTheme,
              ),
            ),
            home: const HomeView(),
          );
        },
      ),
    );
  }
}
