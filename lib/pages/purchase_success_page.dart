import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:go_router/go_router.dart';

import '../components/app_colors.dart';

class PurchaseSuccessPage extends StatelessWidget {
  const PurchaseSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const FrediAppBarMain(),
        drawer: const FredAppBarDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25.0,
            ),
            const SansBoldCentered(
                'Dein Kauf war erfolgreich!', 32, AppColors.primary),
            const SizedBox(
              height: 25.0,
            ),
            const SansCentered(
                "Du kannst dein Abo jeder Zeit im Google Play Store kündigen. Mehr dazu findest du in den FAQ's.",
                22,
                AppColors.black),
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
        ));
  }
}
