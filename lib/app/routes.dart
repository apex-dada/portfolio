import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/home/view/home_screen.dart';
import 'package:portfolio/features/about/view/about_screen.dart';
import 'package:portfolio/features/projects/view/projects_screen.dart';
import 'package:portfolio/features/experience/view/experience_screen.dart';
import 'package:portfolio/features/contact/view/contact_screen.dart';

CustomTransitionPage buildPageTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCubic).animate(animation),
        child: child,
      );
    },
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/about',
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const AboutScreen(),
      ),
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const ProjectsScreen(),
      ),
    ),
    GoRoute(
      path: '/experience',
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const ExperienceScreen(),
      ),
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const ContactScreen(),
      ),
    ),
  ],
);
