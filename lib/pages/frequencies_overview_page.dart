import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../l10n/app_localizations.dart';
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

  @override
  void initState() {
    updateEntitlementStatus();
  }

  void updateEntitlementStatus() {
    if (widget.packageID == 'free') {
      _programmAvailable = true;
    } else {
      hasEntitlement('Pferd Komplett');
      hasEntitlement('Hund Komplett');
      hasEntitlement('Mensch Komplett');
      hasEntitlement('Premium');
      hasEntitlement('Pferd Grundprogramm');
      hasEntitlement('Mensch Grundprogramm');
      hasEntitlement('Hund Grundprogramm');
    }
  }

  hasEntitlement(entitlementID) async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      if (customerInfo.entitlements.all[entitlementID]!.isActive) {
        setState(() {
          switch (entitlementID) {
            case 'Pferd Komplett':
              if (widget.packageID == 'horses' &&
                  widget.programName != 'grundprogramm') {
                _programmAvailable = true;
              }
              break;
            case 'Hund Komplett':
              if (widget.packageID == 'cats_and_dogs') {
                _programmAvailable = true;
              }
              break;
            case 'Mensch Komplett':
              if (widget.packageID == 'humans') {
                _programmAvailable = true;
              }
              break;
            case 'Premium':
              _programmAvailable = true;
              break;
            case 'Pferd Grundprogramm':
              if (widget.packageID == 'horses' &&
                  widget.programName == 'grundprogramm') {
                _programmAvailable = true;
              }
              break;
            case 'Mensch Grundprogramm':
              if (widget.packageID == 'humans' &&
                  widget.programName == 'grundprogramm') {
                _programmAvailable = true;
              }
              break;
            case 'Hund Grundprogramm':
              if (widget.packageID == 'cats_and_dogs' &&
                  widget.programName == 'grundprogramm') {
                _programmAvailable = true;
              }
              break;
          }
        });
      }
      // access latest customerInfo
    } on PlatformException {
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
                        SansCentered(
                          AppLocalizations.of(context)!
                              .notInPossesionOfProgrammText,
                          23,
                          AppColors.complementary,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        SansCentered(
                          AppLocalizations.of(context)!
                              .notInPossesionOfProgrammHintText,
                          19,
                          AppColors.black,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        FrediOutlinedButton(
                          onPressed: () {
                            context.go('/shop');
                          },
                          text: AppLocalizations.of(context)!.toShopButton,
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
                            packageID: widget.packageID,
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
