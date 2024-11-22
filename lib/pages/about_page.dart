import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/app_colors.dart';
import '../components/font_components.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  // URL zur Datenschutzrichtlinie
  final Uri websiteUrl = Uri.https('fredi-shop.com', '', {'limit': '10'});
  final Uri contactURL =
      Uri.https('fredi-shop.com', 'kontakt', {'limit': '10'});
  final Uri privacyPolicyUrl =
      Uri.https('fredi-shop.com', 'datenschutzerklaerung', {'limit': '10'});

  // URL zu den Nutzungsbedingungen
  final Uri termsUrlApple = Uri.https('www.apple.com',
      'legal/internet-services/itunes/dev/stdeula', {'limit': '10'});

  final Uri termsUrlGoogle = Uri.https(
      'play.google.com', '/about/play-terms/index.html', {'limit': '10'});

  // Funktion zum Öffnen von URLs
  void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Die URL konnte nicht geöffnet werden: $url";
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
              GestureDetector(
                onTap: () => _launchURL(websiteUrl),
                child: const Text(
                  "Zu unserer Webseite",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Divider(),
              const SizedBox(
                height: 25.0,
              ),
              const SansBoldCentered(
                  'Datenschutzerklärung', 24, AppColors.primary),
              const SizedBox(
                height: 25.0,
              ),
              const SansCentered(
                  'Unsere Datenschutzerklärung findest du unter:',
                  18,
                  AppColors.black),
              const SizedBox(
                height: 25.0,
              ),
              GestureDetector(
                onTap: () => _launchURL(privacyPolicyUrl),
                child: const Text(
                  "Zu unserer Datenschutzerklärung",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Divider(),
              const SizedBox(
                height: 25.0,
              ),
              const SansBoldCentered(
                  'Nutzungsbedingungen', 24, AppColors.primary),
              const SizedBox(
                height: 25.0,
              ),
              Platform.isIOS
                  ? Column(
                      children: [
                        const SansCentered(
                            'Unsere Nutzungsbedingungen basieren auf der Standard-EULA von Apple:',
                            18,
                            AppColors.black),
                        const SizedBox(
                          height: 25.0,
                        ),
                        GestureDetector(
                          onTap: () => _launchURL(termsUrlApple),
                          child: const Text(
                            "Zu den Nutzungsbedingungen",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 25.0,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const SansCentered(
                            'Unsere Nutzungsbedingungen basieren auf Google Play-Nutzngsbedingungen:',
                            18,
                            AppColors.black),
                        const SizedBox(
                          height: 25.0,
                        ),
                        GestureDetector(
                          onTap: () => _launchURL(termsUrlGoogle),
                          child: const Text(
                            "Zu den Nutzungsbedingungen",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        const Divider(),
                      ],
                    ),
              const SansBoldCentered('Kontakt', 24, AppColors.primary),
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
              GestureDetector(
                onTap: () => _launchURL(contactURL),
                child: const Text(
                  "Zu unserer Kontaktseite",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
            ]),
          ),
        ));
  }
}
