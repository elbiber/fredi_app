import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fredi_app/components/components.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../components/app_colors.dart';
import '../components/font_components.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool _dogIsActive = false;
  bool _horseIsActive = false;
  bool _humanIsActive = false;
  bool _premiumIsActive = false;

  @override
  void initState() {
    hasEntitlement('Hund Komplett');
    hasEntitlement('Pferd Komplett');
    hasEntitlement('Mensch Komplett');
    hasEntitlement('Premium');
  }

  void showOffering(offeringID) async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      var toPrint = offerings.getOffering(offeringID);
      debugPrint('OFFERINGS: $toPrint');
      RevenueCatUI.presentPaywall(offering: toPrint, displayCloseButton: true);
    } on PlatformException catch (e) {
      // optional error handling
    }
  }

  hasEntitlement(entitlementID) async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      if (customerInfo.entitlements.all[entitlementID]!.isActive) {
        setState(() {
          switch (entitlementID) {
            case 'Pferd Komplett':
              _horseIsActive = true;
              break;
            case 'Hund Komplett':
              _dogIsActive = true;
              break;
            case 'Mensch Komplett':
              _humanIsActive = true;
              break;
            case 'Premium':
              _premiumIsActive = true;
              break;
          }
        });
      }
      debugPrint(
          'INFO: ${customerInfo.entitlements.all[entitlementID]?.isActive}');
      // access latest customerInfo
    } on PlatformException catch (e) {
      // Error fetching customer info
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const FrediAppBarMain(),
        drawer: const FredAppBarDrawer(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              const Column(
                children: [
                  SansBoldCentered('Herzlich Willkommen im Fredi Shop!', 28.0,
                      AppColors.primary),
                  SizedBox(
                    height: 25.0,
                  ),
                  SansCentered(
                      'Hier findest du alle verfügbaren Abos für dein Fredi Produkt',
                      18,
                      AppColors.black)
                ],
              ),
              const SizedBox(
                height: 55.0,
              ),
              Column(
                children: [
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansBold('Pferd Komplett Abo', 24, AppColors.primary),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansCentered(
                      'Mit diesem Abo sind alle Programme/Frequenzen für Pferde freigeschaltet',
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _horseIsActive
                      ? const SansCentered(
                          'Du bist bereits im Besitz dieses Abos!',
                          20,
                          AppColors.primary)
                      : ElevatedButton(
                          onPressed: () => showOffering('Pferd Komplett'),
                          child: const SansBoldCentered(
                              'Zum Angebot', 20, AppColors.primary)),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
              Column(
                children: [
                  const SansBold('Hund Komplett Abo', 24, AppColors.green),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansCentered(
                      'Mit diesem Abo sind alle Programme/Frequenzen für Hunde freigeschaltet',
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _dogIsActive
                      ? const SansCentered(
                          'Du bist bereits im Besitz dieses Abos!',
                          20,
                          AppColors.green)
                      : ElevatedButton(
                          onPressed: () => showOffering('Hund Komplett'),
                          child: const SansBoldCentered(
                              'Zum Angebot', 20, AppColors.green)),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
              Column(
                children: [
                  const SansBold(
                      'Für Dich Komplett Abo', 24, AppColors.complementary),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansCentered(
                      'Mit diesem Abo sind alle Programme/Frequenzen für Dich freigeschaltet',
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _humanIsActive
                      ? const SansCentered(
                          'Du bist bereits im Besitz dieses Abos!',
                          20,
                          AppColors.complementary)
                      : ElevatedButton(
                          onPressed: () => showOffering('Mensch Komplett'),
                          child: const SansBoldCentered(
                              'Zum Angebot', 20, AppColors.complementary)),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
              Column(
                children: [
                  const SansBold('Fredi Premimum Abo', 24, AppColors.gold),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansCentered(
                      'Mit diesem Abo sind alle Programme/Frequenzen der Fredi App freigeschaltet',
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive
                      ? const SansCentered(
                          'Du bist bereits im Besitz dieses Abos!',
                          20,
                          AppColors.gold)
                      : ElevatedButton(
                          onPressed: () => showOffering('Premium'),
                          child: const SansBoldCentered(
                              'Zum Angebot', 20, AppColors.gold)),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              )
            ],
          ),
        )
            /*SansBoldCentered('Du willst eine neue Frequenz übertragen?',
              25.0, AppColors.primary),*/
            ));
  }
}
