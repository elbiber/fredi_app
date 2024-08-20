import 'package:flutter/material.dart';
import 'package:fredi_app/components.dart';
import 'package:fredi_app/modals/nfc_modals.dart';
import 'package:fredi_app/pages/about_page.dart';
import 'package:fredi_app/pages/contact_page.dart';
import 'package:fredi_app/pages/faq_page.dart';
import 'package:fredi_app/pages/home_page.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/about',
    builder: (context, state) => const AboutPage(),
  ),
  GoRoute(
    path: '/faq',
    builder: (context, state) => const FAQPage(),
  ),
  GoRoute(
    path: '/contact',
    builder: (context, state) => const ContactPage(),
  ),
  GoRoute(
    path: '/nfc-read',
    builder: (context, state) => const GetActualFreq(),
  )
]);

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case '/about':
        return MaterialPageRoute(
          builder: (_) => const AboutPage(),
          settings: settings,
        );
      case '/faq':
        return MaterialPageRoute(
          builder: (_) => const FAQPage(),
          settings: settings,
        );
      case '/contact':
        return MaterialPageRoute(
          builder: (_) => const ContactPage(),
          settings: settings,
        );
      case '/nfc-read':
        return MaterialPageRoute(
          builder: (_) => const GetActualFreq(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Center(
              child: SansBold("Error Page", 50.0, Colors.black),
            );
          },
        );
    }
  }
}
