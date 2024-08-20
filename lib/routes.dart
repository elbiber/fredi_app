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
