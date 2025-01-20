import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fredi_app/components/components.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // URL zur Datenschutzrichtlinie
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
      throw 'Die URL konnte nicht geöffnet werden: $url';
    }
  }

  void _restorePurchases() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      debugPrint('$customerInfo');
      if (!mounted) return;
      context.go('/restore-success');
      // ... check restored purchaserInfo to see if entitlement is now active
    } on PlatformException catch (e) {
      // Error restoring purchases
    }
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
              Column(
                children: [
                  SansBoldCentered(AppLocalizations.of(context)!.welcomeText,
                      28.0, AppColors.primary),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansCentered(AppLocalizations.of(context)!.productInfoText,
                      18, AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansCentered(AppLocalizations.of(context)!.restoreInfoText,
                      14, AppColors.complementary),
                  const SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    onTap: () => _restorePurchases(),
                    child: Text(
                      AppLocalizations.of(context)!.restorePurchasesButton,
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
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
                  SansBoldCentered(AppLocalizations.of(context)!.premiumTitle,
                      24, AppColors.gold),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansBoldCentered(
                      AppLocalizations.of(context)!.priceDurationLabel,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.premiumPriceDetails,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansCentered(AppLocalizations.of(context)!.premiumDescription,
                      20, AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  hasActivePackages() && !_premiumIsActive
                      ? SansCentered(
                          AppLocalizations.of(context)!
                              .additionalActiveSubscriptionsText,
                          16,
                          AppColors.complementary)
                      : const SizedBox(
                          height: 0.0,
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(privacyPolicyUrl),
                    child: Text(
                      AppLocalizations.of(context)!.privacyPolicyLabel,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Platform.isIOS
                      ? GestureDetector(
                          onTap: () => _launchURL(termsUrlApple),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => _launchURL(termsUrlGoogle),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive
                      ? Column(
                          children: [
                            SansCentered(
                                AppLocalizations.of(context)!
                                    .alreadySubscribedText,
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
                                child: SansBoldCentered(
                                    AppLocalizations.of(context)!
                                        .changeSubscriptionButton,
                                    20,
                                    AppColors.gold)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Premium'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.gold)),
                          child: SansBoldCentered(
                              AppLocalizations.of(context)!.subscribeButton,
                              20,
                              AppColors.gold)),
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
                  SansBoldCentered(
                      AppLocalizations.of(context)!.horseBasicTitle,
                      24,
                      AppColors.primary),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansBoldCentered(
                      AppLocalizations.of(context)!.priceDurationLabel,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.horseBasicPriceDetails,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.horseBasicDescription,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(privacyPolicyUrl),
                    child: Text(
                      AppLocalizations.of(context)!.privacyPolicyLabel,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Platform.isIOS
                      ? GestureDetector(
                          onTap: () => _launchURL(termsUrlApple),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => _launchURL(termsUrlGoogle),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive && !_horseBasicIsActive
                      ? SansCentered(
                          AppLocalizations.of(context)!.premiumActiveInfoText,
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
                            SansCentered(
                                AppLocalizations.of(context)!
                                    .alreadySubscribedText,
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
                                child: SansBoldCentered(
                                    AppLocalizations.of(context)!
                                        .changeSubscriptionButton,
                                    20,
                                    AppColors.primary)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Grundprogramm Pferd'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.primary)),
                          child: SansBoldCentered(
                              AppLocalizations.of(context)!.subscribeButton,
                              20,
                              AppColors.primary)),
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
                  SansBoldCentered(
                      AppLocalizations.of(context)!.horseAdditionalTitle,
                      24,
                      AppColors.primary),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansBoldCentered(
                      AppLocalizations.of(context)!.priceDurationLabel,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.horseAdditionalPriceDetails,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.horseAdditionalDescription,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(privacyPolicyUrl),
                    child: Text(
                      AppLocalizations.of(context)!.privacyPolicyLabel,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Platform.isIOS
                      ? GestureDetector(
                          onTap: () => _launchURL(termsUrlApple),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => _launchURL(termsUrlGoogle),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive && !_horseIsActive
                      ? SansCentered(
                          AppLocalizations.of(context)!.premiumActiveInfoText,
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
                                "Du bist bereits im Besitz dieses Abos! Du kannst aber dieses Abo anpassen.",
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
                                child: SansBoldCentered(
                                    AppLocalizations.of(context)!
                                        .changeSubscriptionButton,
                                    20,
                                    AppColors.primary)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Pferd Komplett'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.primary)),
                          child: SansBoldCentered(
                              AppLocalizations.of(context)!.subscribeButton,
                              20,
                              AppColors.primary)),
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
                  SansBoldCentered(AppLocalizations.of(context)!.dogBasicTitle,
                      24, AppColors.green),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansBoldCentered(
                      AppLocalizations.of(context)!.priceDurationLabel,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.horseBasicPriceDetails,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.dogBasicDescription,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(privacyPolicyUrl),
                    child: Text(
                      AppLocalizations.of(context)!.privacyPolicyLabel,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Platform.isIOS
                      ? GestureDetector(
                          onTap: () => _launchURL(termsUrlApple),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => _launchURL(termsUrlGoogle),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive && !_dogBasicIsActive
                      ? SansCentered(
                          AppLocalizations.of(context)!.premiumActiveInfoText,
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
                            SansCentered(
                                AppLocalizations.of(context)!
                                    .alreadySubscribedText,
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
                                child: SansBoldCentered(
                                    AppLocalizations.of(context)!
                                        .changeSubscriptionButton,
                                    20,
                                    AppColors.green)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Grundprogramm Hund'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.green)),
                          child: SansBoldCentered(
                              AppLocalizations.of(context)!.subscribeButton,
                              20,
                              AppColors.green)),
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
                  SansBoldCentered(
                      AppLocalizations.of(context)!.dogAdditionalTitle,
                      24,
                      AppColors.green),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansBoldCentered(
                      AppLocalizations.of(context)!.priceDurationLabel,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.dogAdditionalPriceDetails,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.dogAdditionalDescription,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(privacyPolicyUrl),
                    child: Text(
                      AppLocalizations.of(context)!.privacyPolicyLabel,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Platform.isIOS
                      ? GestureDetector(
                          onTap: () => _launchURL(termsUrlApple),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => _launchURL(termsUrlGoogle),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive && !_dogIsActive
                      ? SansCentered(
                          AppLocalizations.of(context)!.premiumActiveInfoText,
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
                            SansCentered(
                                AppLocalizations.of(context)!
                                    .alreadySubscribedText,
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
                                child: SansBoldCentered(
                                    AppLocalizations.of(context)!
                                        .changeSubscriptionButton,
                                    20,
                                    AppColors.green)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Hund Komplett'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(color: AppColors.green)),
                          child: SansBoldCentered(
                              AppLocalizations.of(context)!.subscribeButton,
                              20,
                              AppColors.green)),
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
                  SansBoldCentered(
                      AppLocalizations.of(context)!.humanBasicTitle,
                      24,
                      AppColors.complementary),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansBoldCentered(
                      AppLocalizations.of(context)!.priceDurationLabel,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.humanBasicPriceDetails,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SansCentered(
                      AppLocalizations.of(context)!.humanBasicDescription,
                      20,
                      AppColors.black),
                  const SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(privacyPolicyUrl),
                    child: Text(
                      AppLocalizations.of(context)!.privacyPolicyLabel,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Platform.isIOS
                      ? GestureDetector(
                          onTap: () => _launchURL(termsUrlApple),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => _launchURL(termsUrlGoogle),
                          child: Text(
                            AppLocalizations.of(context)!
                                .termsAndConditionsLabel,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _premiumIsActive && !_humanBasicIsActive
                      ? SansCentered(
                          AppLocalizations.of(context)!.premiumActiveInfoText,
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
                            SansCentered(
                                AppLocalizations.of(context)!
                                    .alreadySubscribedText,
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
                                child: SansBoldCentered(
                                    AppLocalizations.of(context)!
                                        .changeSubscriptionButton,
                                    20,
                                    AppColors.complementary)),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => showOffering('Grundprogramm Mensch'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: const BorderSide(
                                  color: AppColors.complementary)),
                          child: SansBoldCentered(
                              AppLocalizations.of(context)!.subscribeButton,
                              20,
                              AppColors.complementary)),
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
