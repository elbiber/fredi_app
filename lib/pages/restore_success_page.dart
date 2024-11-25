import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:go_router/go_router.dart';

import '../components/app_colors.dart';

class RestoreSuccessPage extends StatelessWidget {
  const RestoreSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const FrediAppBarMain(),
        drawer: const FredAppBarDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25.0,
              ),
              const SansBoldCentered(
                  'Deine Abos wurden erfolgreich wiederhergestellt falls du noch welche hattest.',
                  24,
                  AppColors.primary),
              const SizedBox(
                height: 25.0,
              ),
              const SansBoldCentered(
                  'Bei weiteren Fragen wende Dich gerne unter dem Reiter Kontak an unseren Support!',
                  18,
                  AppColors.black),
              const SizedBox(
                height: 25.0,
              ),
              const SizedBox(
                height: 25.0,
              ),
              FrediOutlinedButton(
                onPressed: () {
                  context.go('/shop');
                },
                text: 'Zurück zum Shop',
                bgColor: AppColors.complementary,
              ),
              const SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ));
  }
}
