import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:fredi_app/pages/shop_page.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

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
  bool _programmAvailable = false;
  bool _dogIsActive = false;
  bool _horseIsActive = false;
  bool _humanIsActive = false;
  bool _premiumIsActive = false;
  bool _horseBasicIsActive = false;
  bool _dogBasicIsActive = false;
  bool _humanBasicIsActive = false;

  @override
  void initState() {
    debugPrint('++++++++++++++++++++++++++++++++++++++++${widget.packageID}');
    updateEntitlementStatus();
    switch (widget.packageID) {
      case 'horses':
        debugPrint(widget.packageID);
        debugPrint(widget.programName);
        break;
    }
  }

  void updateEntitlementStatus() {
    hasEntitlement('Hund Komplett');
    hasEntitlement('Mensch Komplett');
    hasEntitlement('Premium');
    hasEntitlement('Pferd Grundprogramm');
    hasEntitlement('Mensch Grundprogramm');
    hasEntitlement('Hund Grundprogramm');
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
  }

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
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: !_programmAvailable
                  ? Column(
                      children: [
                        const SansCentered(
                          'Du bist leider nicht im Besitz dieses Programmes',
                          23,
                          AppColors.complementary,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        const SansCentered(
                          'Du findest alle Abos zu den Frequenzen in unserem Shop',
                          19,
                          AppColors.black,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        FrediOutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShopPage(),
                              ),
                            );
                          },
                          text: 'Zum Shop',
                          bgColor: AppColors.complementary,
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 5.0,
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
                      side: BorderSide(
                          color: !_programmAvailable
                              ? AppColors.grey
                              : widget.packageColor,
                          width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: AppColors.white,
                  onTap: () {
                    if (_programmAvailable) {
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
                    }
                  },
                  title: !_programmAvailable
                      ? SansCenteredLineThrough(
                          widget.frequencies[index]['name'],
                          18,
                          AppColors.grey,
                        )
                      : SansCentered(
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
