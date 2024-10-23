import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fredi_app/routes.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  runApp(const MyApp());
  await _configureSDK();
}

Future<void> _configureSDK() async {
  debugPrint('SDK Config');
  await Purchases.setLogLevel(LogLevel.debug);
  PurchasesConfiguration? configuration;
  if (Platform.isAndroid) {
  } else if (Platform.isIOS) {
    configuration = PurchasesConfiguration('appl_HwdKOvSTWvYKlGbdYusgBTXIDSW');
  }

  if (configuration != null) {
    await Purchases.configure(configuration);
    final paywallResult = await RevenueCatUI.presentPaywallIfNeeded('Premium');
    log('Paywall result: $paywallResult');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Fredi',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
