import 'dart:io';

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
  bool _premiumIsActive = false;
  bool _horseBasicIsActive = false;
  bool _dogBasicIsActive = false;
  bool _humanBasicIsActive = false;

  @override
  void initState() {
    updateEntitlementStatus();
  }

  void updateEntitlementStatus() {
    hasEntitlement('Hund Komplett');
    hasEntitlement('Pferd Komplett');
    hasEntitlement('Mensch Komplett');
    hasEntitlement('Premium');
    hasEntitlement('Pferd Grundprogramm');
    hasEntitlement('Mensch Grundprogramm');
    hasEntitlement('Hund Grundprogramm');
  }

  void showOffering(offeringID) async {
    try {
      debugPrint('Get OFFERINGS');
      Offerings offerings = await Purchases.getOfferings();
      debugPrint('OFFERINGS: $offerings');
      var toPrint = offerings.getOffering(offeringID);
      debugPrint('OFFERINGS: $toPrint');
      final result = await RevenueCatUI.presentPaywall(
              offering: toPrint, displayCloseButton: true)
          .whenComplete(() async {
        updateEntitlementStatus();
      });
      if (result == PaywallResult.purchased) {
        if (!mounted) return;
        // context.go('/');
      }
    } on PlatformException catch (e) {
      // optional error handling
    }
  }

  hasEntitlement(entitlementID) async {
    if (Platform.isAndroid) {
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
              case 'Mensch Grundprogramm':
                _humanBasicIsActive = true;
                break;
              case 'Premium':
                _premiumIsActive = true;
                break;
              case 'Pferd Grundprogramm':
                _horseBasicIsActive = true;
                break;
              case 'Mensch Grundprogramm':
                _humanBasicIsActive = true;
                break;
              case 'Hund Grundprogramm':
                _dogBasicIsActive = true;
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
    } else if (Platform.isIOS) {
      debugPrint('INFO IOS +++++++++++++++++++++++++++++');
      //CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      // debugPrint('$customerInfo');
      try {
        CustomerInfo customerInfo = await Purchases.getCustomerInfo();
        debugPrint('Checking. $entitlementID');
        if (customerInfo.entitlements.all[entitlementID]?.isActive != null) {
          if (customerInfo.entitlements.all[entitlementID]!.isActive) {
            debugPrint('Checking. $entitlementID');
            setState(() {
              switch (entitlementID) {
                case 'Pferd Komplett':
                  _horseIsActive = true;
                  break;
                case 'Hund Komplett':
                  _dogIsActive = true;
                  break;
                case 'Premium':
                  _premiumIsActive = true;
                  break;
                case 'Pferd Grundprogramm':
                  _horseBasicIsActive = true;
                  break;
                case 'Mensch Grundprogramm':
                  _humanBasicIsActive = true;
                  break;
                case 'Hund Grundprogramm':
                  _dogBasicIsActive = true;
                  break;
              }
            });
          }
          debugPrint(
              'INFO: ${customerInfo.entitlements.all[entitlementID]?.isActive}');
        }
        // access latest customerInfo
      } on PlatformException catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  bool hasActivePackages() {
    return _horseIsActive ||
        _horseBasicIsActive ||
        _dogIsActive ||
        _dogBasicIsActive ||
        _humanBasicIsActive;
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
                  const SansBoldCentered('Fredi Premimum', 24, AppColors.gold),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansCentered(
                      "Mit diesem Abo sind alle Programme/Frequenzen der Fredi App freigeschaltet.",
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  hasActivePackages() && !_premiumIsActive
                      ? const SansCentered(
                          'Du hast noch weitere aktive Abonnements, die bereits im Premium-Abo enthalten sind. Diese werden nicht automatisch gekündigt und laufen weiterhin. Eine Anleitung zur Kündigung deiner Abonnements, um doppelte Zahlungen zu vermeiden, findest du in der App unter den FAQs.',
                          16,
                          AppColors.complementary)
                      : const SizedBox(
                          height: 0.0,
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive
                      ? Column(
                          children: [
                            const SansCentered(
                                'Du bist bereits im Besitz dieses Abos! Du kannst aber dieses Abo anpassen.',
                                16,
                                AppColors.complementary),
                            const SizedBox(
                              height: 25.0,
                            ),
                            ElevatedButton(
                                onPressed: () => showOffering('Premium'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    side: const BorderSide(
                                        color: AppColors.gold)),
                                child: const SansBoldCentered(
                                    'Abo ändern', 20, AppColors.gold)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Premium'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.gold)),
                          child: const SansBoldCentered(
                              'Zum Angebot', 20, AppColors.gold)),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
              Column(
                children: [
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansBoldCentered(
                      'Grundprogramm Pferd', 24, AppColors.primary),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansCentered(
                      'Mit diesem Abo werden 16 Frequenzreihen für Pferde freigeschaltet.',
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive && !_horseBasicIsActive
                      ? const SansCentered(
                          'Du bist bereits durch dein Premium-Abo in Besitz dieses Programmes. Wenn du jedoch auf dieses Programm wechseln willst, solltest du dein Premium-Abo kündigen um doppelte Zahlungen zu vermeiden. Eine Anleitung zur Kündigung deiner Abonnements, um doppelte Zahlungen zu vermeiden, findest du in der App unter den FAQs.',
                          16,
                          AppColors.complementary)
                      : const SizedBox(
                          height: 0.0,
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _horseBasicIsActive
                      ? Column(
                          children: [
                            const SansCentered(
                                'Du bist bereits im Besitz dieses Abos! Du kannst aber dieses Abo anpassen.',
                                16,
                                AppColors.complementary),
                            const SizedBox(
                              height: 25.0,
                            ),
                            ElevatedButton(
                                onPressed: () =>
                                    showOffering('Grundprogramm Pferd'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    side: const BorderSide(
                                        color: AppColors.primary)),
                                child: const SansBoldCentered(
                                    'Abo ändern', 20, AppColors.primary)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Grundprogramm Pferd'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.primary)),
                          child: const SansBoldCentered(
                              'Zum Angebot', 20, AppColors.primary)),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
              Column(
                children: [
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansBoldCentered(
                      'Zusatzprogramme Pferd', 24, AppColors.primary),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansCentered(
                      'Frequenzreihen freigeschaltet:\n- Bewegungsapparat\n- Atemwege und Haut\n- Stoffwechsel und Organe,\n- Emotion und Traumata',
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive && !_horseIsActive
                      ? const SansCentered(
                          'Du bist bereits durch dein Premium-Abo in Besitz dieses Programmes. Wenn du jedoch auf dieses Programm wechseln willst, solltest du dein Premium-Abo kündigen um doppelte Zahlungen zu vermeiden. Eine Anleitung zur Kündigung deiner Abonnements, um doppelte Zahlungen zu vermeiden, findest du in der App unter den FAQs.',
                          16,
                          AppColors.complementary)
                      : const SizedBox(
                          height: 0.0,
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _horseIsActive
                      ? Column(
                          children: [
                            const SansCentered(
                                'Du bist bereits im Besitz dieses Abos! Du kannst aber dieses Abo anpassen.',
                                16,
                                AppColors.complementary),
                            const SizedBox(
                              height: 25.0,
                            ),
                            ElevatedButton(
                                onPressed: () => showOffering('Pferd Komplett'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    side: const BorderSide(
                                        color: AppColors.primary)),
                                child: const SansBoldCentered(
                                    'Abo ändern', 20, AppColors.primary)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Pferd Komplett'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.primary)),
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
                  const SansBoldCentered(
                      'Grundprogramm Hund', 24, AppColors.green),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansCentered(
                      'Mit diesem Abo werden 16 Frequenzreihen für Hunde freigeschaltet.',
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive && !_dogBasicIsActive
                      ? const SansCentered(
                          'Du bist bereits durch dein Premium-Abo in Besitz dieses Programmes. Wenn du jedoch auf dieses Programm wechseln willst, solltest du dein Premium-Abo kündigen um doppelte Zahlungen zu vermeiden. Eine Anleitung zur Kündigung deiner Abonnements, um doppelte Zahlungen zu vermeiden, findest du in der App unter den FAQs.',
                          16,
                          AppColors.complementary)
                      : const SizedBox(
                          height: 0.0,
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _dogBasicIsActive
                      ? Column(
                          children: [
                            const SansCentered(
                                'Du bist bereits im Besitz dieses Abos! Du kannst aber dieses Abo anpassen.',
                                16,
                                AppColors.complementary),
                            const SizedBox(
                              height: 25.0,
                            ),
                            ElevatedButton(
                                onPressed: () =>
                                    showOffering('Grundprogramm Hund'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    side: const BorderSide(
                                        color: AppColors.green)),
                                child: const SansBoldCentered(
                                    'Abo ändern', 20, AppColors.green)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Grundprogramm Hund'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.green)),
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
                  const SansBoldCentered(
                      'Zusatzprogramme Hund', 24, AppColors.green),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansCentered(
                      'Frequenzreihen freigeschaltet:\n- Bewegungsapparat\n- Haut Darm Ohren\n- Emotion und Traumata',
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive && !_dogIsActive
                      ? const SansCentered(
                          'Du bist bereits durch dein Premium-Abo in Besitz dieses Programmes. Wenn du jedoch auf dieses Programm wechseln willst, solltest du dein Premium-Abo kündigen um doppelte Zahlungen zu vermeiden. Eine Anleitung zur Kündigung deiner Abonnements, um doppelte Zahlungen zu vermeiden, findest du in der App unter den FAQs.',
                          16,
                          AppColors.complementary)
                      : const SizedBox(
                          height: 0.0,
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _dogIsActive
                      ? Column(
                          children: [
                            const SansCentered(
                                'Du bist bereits im Besitz dieses Abos! Du kannst aber dieses Abo anpassen.',
                                16,
                                AppColors.complementary),
                            const SizedBox(
                              height: 25.0,
                            ),
                            ElevatedButton(
                                onPressed: () => showOffering('Hund Komplett'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    side: const BorderSide(
                                        color: AppColors.green)),
                                child: const SansBoldCentered(
                                    'Abo ändern', 20, AppColors.green)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Hund Komplett'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.green)),
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
                  const SansBoldCentered(
                      'Fredi Für Dich', 24, AppColors.complementary),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SansCentered(
                      'Mit diesem Abo werden 16 Frequenzreihen für Dich freigeschaltet.',
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive && !_humanBasicIsActive
                      ? const SansCentered(
                          'Du bist bereits durch dein Premium-Abo in Besitz dieses Programmes. Wenn du jedoch auf dieses Programm wechseln willst, solltest du dein Premium-Abo kündigen um doppelte Zahlungen zu vermeiden. Eine Anleitung zur Kündigung deiner Abonnements, um doppelte Zahlungen zu vermeiden, findest du in der App unter den FAQs.',
                          16,
                          AppColors.complementary)
                      : const SizedBox(
                          height: 0.0,
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _humanBasicIsActive
                      ? Column(
                          children: [
                            const SansCentered(
                                'Du bist bereits im Besitz dieses Abos! Du kannst aber dieses Abo anpassen.',
                                16,
                                AppColors.complementary),
                            const SizedBox(
                              height: 25.0,
                            ),
                            ElevatedButton(
                                onPressed: () =>
                                    showOffering('Grundprogramm Mensch'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    side: const BorderSide(
                                        color: AppColors.complementary)),
                                child: const SansBoldCentered(
                                    'Abo ändern', 20, AppColors.complementary)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Grundprogramm Mensch'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(
                                  color: AppColors.complementary)),
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
            ],
          ),
        )));
  }
}
