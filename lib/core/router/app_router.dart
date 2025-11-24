import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/presentation/screens/welcome_screen.dart';
import '../../../features/home/presentation/screens/home_screen.dart';

// Sayfalar arası geçişi yöneten Router nesnesi
final goRouter = GoRouter(
  initialLocation: '/welcome', // Uygulama buradan başlar
  routes: [
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);