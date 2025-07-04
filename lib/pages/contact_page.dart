import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fredi_app/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/app_colors.dart';
import '../components/font_components.dart';
import '../l10n/app_localizations.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

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
              SansBoldCentered(AppLocalizations.of(context)!.contactTitle, 32,
                  AppColors.primary),
              const SizedBox(
                height: 25.0,
              ),
              SansCentered(AppLocalizations.of(context)!.contactInfo, 18,
                  AppColors.black),
              const SizedBox(
                height: 25.0,
              ),
              TextButton(
                  onPressed: () {
                    _launchUrl(AppLocalizations.of(context)!.contactWebsiteUrl);
                  },
                  child: SansBoldCentered(
                      AppLocalizations.of(context)!.contactWebsiteText,
                      24,
                      AppColors.primary)),
              const SizedBox(
                height: 25.0,
              ),
              SansCentered(AppLocalizations.of(context)!.supportInfo, 18,
                  AppColors.black),
              const SizedBox(
                height: 25.0,
              ),
              TextButton(
                  onPressed: () {
                    _launchUrl(AppLocalizations.of(context)!.supportContactUrl);
                  },
                  child: SansBoldCentered(
                      AppLocalizations.of(context)!.supportContactText,
                      24,
                      AppColors.primary)),
            ]),
          ),
        ));
  }
}
