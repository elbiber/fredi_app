import 'package:fredi_app/pages/about_page.dart';
import 'package:fredi_app/pages/contact_page.dart';
import 'package:fredi_app/pages/faq_page.dart';
import 'package:fredi_app/pages/home_page.dart';
import 'package:fredi_app/pages/purchase_success_page.dart';
import 'package:fredi_app/pages/shop_page.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/shop',
    builder: (context, state) => const ShopPage(),
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
    path: '/purchase-success',
    builder: (context, state) => const PurchaseSuccessPage(),
  ),
]);
