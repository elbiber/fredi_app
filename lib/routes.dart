import 'package:flutter/material.dart';
import 'package:fredi_app/components.dart';
import 'package:fredi_app/pages/about_page.dart';
import 'package:fredi_app/pages/home_page.dart';
import 'package:fredi_app/pages/show_actual_programm_page.dart';

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
      case '/actual-programm':
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ShowActualProgrammPage(
            actualProgramm: args,
          ),
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
