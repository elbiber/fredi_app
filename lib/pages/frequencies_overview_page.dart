import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../modals/set_actual_frequency_modal.dart';

class FrequenciesOverviewPage extends StatefulWidget {
  final String titel, titelImage, packageID, programName;
  final List frequencies;
  final Color packageColor;

  const FrequenciesOverviewPage({
    super.key,
    required this.frequencies,
    required this.titel,
    required this.titelImage,
    required this.packageID,
    required this.packageColor,
    required this.programName,
  });

  @override
  State<FrequenciesOverviewPage> createState() =>
      _FrequenciesOverviewPageState();
}

class _FrequenciesOverviewPageState extends State<FrequenciesOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: widget.packageColor,
            foregroundColor: AppColors.white,
            stretch: true,
            pinned: true,
            floating: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Sans(widget.titel, 18, AppColors.white),
              background: Image.asset(
                'assets/images/${widget.titelImage}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: widget.packageColor, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: AppColors.white,
                  onTap: () {
                    Purchases.addCustomerInfoUpdateListener(
                        (customerInfo) async {
                      CustomerInfo customerInfo =
                          await Purchases.getCustomerInfo();
                      EntitlementInfo? entitlement =
                          customerInfo.entitlements.all['Pferd Komplett'];
                      if (entitlement != null &&
                          entitlement.isActive &&
                          context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetActualFreq(
                              selectedFrequency: widget.frequencies[index]
                                  ['name'],
                              audioAsset:
                                  'audio/${widget.packageID}/${widget.programName}/${widget.frequencies[index]["audio_file"]}',
                              packageColor: widget.packageColor,
                            ),
                          ),
                        );
                      } else {
                        final paywallResult =
                            await RevenueCatUI.presentPaywallIfNeeded(
                                'Pferd Komplett',
                                displayCloseButton: true);
                        log('Paywall result: $paywallResult');
                      }
                      debugPrint('sdf${entitlement?.isActive}');
                    });
                    /*if (Platform.isAndroid) {
                      final paywallResult =
                          await RevenueCatUI.presentPaywallIfNeeded(
                              'Pferd Komplett');
                      log('Paywall result: $paywallResult');
                    } else if (Platform.isIOS) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SetActualFreq(
                            selectedFrequency: widget.frequencies[index]
                                ['name'],
                            audioAsset:
                                'audio/${widget.packageID}/${widget.programName}/${widget.frequencies[index]["audio_file"]}',
                            packageColor: widget.packageColor,
                          ),
                        ),
                      );
                    }*/

                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetActualFreq(
                          selectedFrequency: widget.frequencies[index]['name'],
                          audioAsset:
                              'audio/${widget.packageID}/${widget.programName}/${widget.frequencies[index]["audio_file"]}',
                          packageColor: widget.packageColor,
                        ),
                      ),
                    );*/
                  },
                  title: SansCentered(
                    widget.frequencies[index]['name'],
                    18,
                    widget.packageColor,
                  ),
                ),
              );
            }, childCount: widget.frequencies.length),
          )
        ],
      ),
    );
  }
}
