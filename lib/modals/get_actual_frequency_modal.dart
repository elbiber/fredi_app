import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:nfc_manager/nfc_manager.dart';

class GetActualFreq extends StatefulWidget {
  const GetActualFreq({super.key});

  @override
  State<GetActualFreq> createState() => _GetActualFreqState();
}

class _GetActualFreqState extends State<GetActualFreq> {
  // ValueNotifier<dynamic> result = ValueNotifier(null);
  String result = '';
  bool gotResult = false;
  @override
  void initState() {
    super.initState();
    debugPrint('--------------NFC Instance Opened---------------');
    NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
      var ndef = Ndef.from(badge);
      if (ndef != null && ndef.cachedMessage != null) {
        debugPrint('--------------NFC Message Read---------------');
        String tempRecord = "";
        for (var record in ndef.cachedMessage!.records) {
          tempRecord =
              "$tempRecord ${String.fromCharCodes(record.payload.sublist(record.payload[0] + 1))}";
          debugPrint('--------------$tempRecord---------------');
          //result.value = tempRecord;
          setState(() {
            result = tempRecord;
            gotResult = true;
          });
        }
      } else {
        // TODO:No or invalid String from Produkt
      }
      NfcManager.instance.stopSession();
      debugPrint('--------------NFC Instance Closed 1---------------');
    });
  }

  @override
  void dispose() {
    super.dispose();
    NfcManager.instance.stopSession();
    debugPrint('--------------NFC Instance Closed 2---------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBarLight(),
      body: FutureBuilder<bool>(
        future: NfcManager.instance.isAvailable(),
        builder: (context, ss) => ss.data != true
            ? Center(
                child: Column(
                  children: [
                    SansBoldCentered(
                        'Leider verfügt Dein Smartphone keine NFC Funktion bzw. diese ist deaktiviert.',
                        22,
                        AppColors.black),
                    TextButton(
                      onPressed: () {
                        if (true) {
                          AndroidIntent intent = const AndroidIntent(
                              action: 'action_location_source_settings');
                          intent.launch();
                        }
                      },
                      child: const Text('NFC Einstellungen'),
                    ),
                  ],
                ),
              )
            : !gotResult
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(30),
                          // color: const Color(0xffFEC401),
                          color: AppColors.primary,
                          child: SansCentered(
                            'Du willst wissen welche Frequenz aktuell auf deinen Fredi übertragen ist?',
                            18,
                            AppColors.white,
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Icon(
                              Icons.phonelink_ring_rounded,
                              size: 50.0,
                              color: AppColors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: SansCentered(
                                'Halte Dein Smartphone kurz an das Fredi Produkt um dein aktuelles Programm anzuzeigen.',
                                18,
                                AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        const FrequencyPackages(),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(30.0),
                          color: AppColors.primary,
                          child: Column(children: [
                            SansCentered(
                              'Du hast aktuell folgende Frequenz auf deinen Fredi übertragen:',
                              18,
                              AppColors.white,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SansBoldCentered(result, 28.0, AppColors.white),
                          ]),
                        ),
                        const FrequencyPackages(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
