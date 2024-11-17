import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/app_colors.dart';
import '../components/font_components.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const FrediAppBarMain(),
        drawer: const FredAppBarDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 25.0,
              ),
              const SansBoldCentered('Über uns', 32, AppColors.primary),
              const SizedBox(
                height: 25.0,
              ),
              const SansCentered(
                  'Alle Information über uns, die Fredi App und alle ihre Produkte findest du unter:',
                  18,
                  AppColors.black),
              const SizedBox(
                height: 25.0,
              ),
              TextButton(
                  onPressed: () {
                    _launchUrl('https://fredi-shop.com');
                  },
                  child: const SansBoldCentered(
                      'www.fredi-shop.de', 24, AppColors.primary)),
              const SizedBox(
                height: 25.0,
              ),
              const SansCentered(
                  'Falls du Ünterstützung bezüglich deines Fredi Produktes bzw. Abos hast findest du unseren Support unter:',
                  18,
                  AppColors.black),
              const SizedBox(
                height: 25.0,
              ),
              TextButton(
                  onPressed: () {
                    _launchUrl('https://fredi-shop.com/kontakt');
                  },
                  child: const SansBoldCentered(
                      'www.fredi-shop.de/kontakt', 24, AppColors.primary)),
            ]),
          ),
        ));
  }
}
