import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/view/home_view.dart';
import 'package:portfolio/view/about_view.dart';
import 'package:portfolio/view/projects_view.dart';
import 'package:portfolio/view/experience_view.dart';
import 'package:portfolio/view/contact_view.dart';

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
        child: const HomeView(),
      ),
    ),
    GoRoute(
      path: '/about',
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const AboutView(),
      ),
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const ProjectsView(),
      ),
    ),
    GoRoute(
      path: '/experience',
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const ExperienceView(),
      ),
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const ContactView(),
      ),
    ),
  ],
);
