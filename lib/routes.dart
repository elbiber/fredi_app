import 'package:fredi_app/modals/set_actual_frequency_modal.dart';
import 'package:fredi_app/pages/about_page.dart';
import 'package:fredi_app/pages/contact_page.dart';
import 'package:fredi_app/pages/faq_page.dart';
import 'package:fredi_app/pages/frequencies_dogs_and_cats_page.dart';
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
    path: '/transfer-success',
    builder: (context, state) => const TransferViewFinished(),
  ),
  GoRoute(
    path: '/freq-dog-cat',
    builder: (context, state) => const FrequenciesDogsAndCatsPage(),
  ),
]);
