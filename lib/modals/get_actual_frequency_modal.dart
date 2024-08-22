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
  bool resultValid = true;
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
              "$tempRecord${String.fromCharCodes(record.payload.sublist(record.payload[0] + 1))}";
          debugPrint('--------------$tempRecord---------------');
          //result.value = tempRecord;
          final prefix = RegExp(r'^fsp_');

          if (prefix.hasMatch(tempRecord)) {
            debugPrint('-------------Regex-----------------');
            setState(() {
              result = tempRecord.substring(4);
              resultValid = true;
              gotResult = true;
            });
          } else {
            debugPrint('--------------NFC Instance Invalid---------------');
            setState(() {
              gotResult = true;
              resultValid = false;
            });
          }
        }
      } else {
        debugPrint('--------------NFC Instance Invalid---------------');
        debugPrint('${ndef?.cachedMessage}');
        setState(() {
          gotResult = true;
          resultValid = false;
        });
      }
      //NfcManager.instance.stopSession();
      //debugPrint('--------------NFC Instance Closed 1---------------');
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
                    const SansBoldCentered(
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
                          color: AppColors.primary,
                          child: const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(30.0),
                                child: SansCentered(
                                  'Du willst wissen welche Frequenz aktuell auf deinen Fredi übertragen ist?',
                                  18,
                                  AppColors.white,
                                ),
                              ),
                              Icon(
                                Icons.phonelink_ring_rounded,
                                size: 50.0,
                                color: AppColors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.all(30.0),
                                child: SansCentered(
                                  'Halte Dein Smartphone kurz an das Fredi Produkt um dein aktuelles Programm anzuzeigen.',
                                  18,
                                  AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const FrequencyPackages(),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        resultValid
                            ? Container(
                                padding: const EdgeInsets.all(30.0),
                                color: AppColors.primary,
                                child: Column(children: [
                                  const SansCentered(
                                    'Du hast aktuell folgende Frequenz auf deinen Fredi übertragen:',
                                    18,
                                    AppColors.white,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  SansBoldCentered(
                                      result, 28.0, AppColors.white),
                                ]),
                              )
                            : Container(
                                padding: const EdgeInsets.all(30.0),
                                color: AppColors.complementary,
                                child: const Column(children: [
                                  SansBoldCentered(
                                    'Auf Deinem Fredi Produkt befindet sich im Moment keine gültige Frequenz. Bitte übertrage erst eine Frequenz!',
                                    20,
                                    AppColors.white,
                                  ),
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
