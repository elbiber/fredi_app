import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/components.dart';
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
  Color resultColor = AppColors.primary;
  String resultPackage = '';

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
          List<int> rawRecord = [];
          List<int> rawRecordTemp =
              record.payload.sublist(record.payload[0] + 1);
          debugPrint(
              '${record.payload.sublist(record.payload[0] + 1).runtimeType}');
          for (int i = 0; i < rawRecordTemp.length; i++) {
            rawRecord.add(rawRecordTemp[i]);
          }
          debugPrint('----$rawRecord');
          for (int i = 0; i < rawRecord.length; i++) {
            if (rawRecord[i] == 195) {
              if (rawRecord[i + 1] == 132) rawRecord[i + 1] = 0x00C4;
              if (rawRecord[i + 1] == 164) rawRecord[i + 1] = 0x00E4;
              if (rawRecord[i + 1] == 150) rawRecord[i + 1] = 0x00D6;
              if (rawRecord[i + 1] == 182) rawRecord[i + 1] = 0x00F6;
              if (rawRecord[i + 1] == 156) rawRecord[i + 1] = 0x00DC;
              if (rawRecord[i + 1] == 188) rawRecord[i + 1] = 0x00FC;
              rawRecord.removeAt(i);
            }
          }

          tempRecord = "$tempRecord${String.fromCharCodes(rawRecord)}";
          debugPrint('--------------$tempRecord---------------');
          final prefix = RegExp(r'^fsp_');

          if (prefix.hasMatch(tempRecord)) {
            String prefixRemoved = tempRecord.substring(4);
            debugPrint('-------------Regex-----------------$prefixRemoved');

            String finalRecord = '';

            if (RegExp(r'^free_').hasMatch(prefixRemoved)) {
              finalRecord = prefixRemoved.substring(5);
              setState(() {
                resultColor = AppColors.black;
                resultPackage = '(Kostenlose Frequenzwelt)';
              });
            } else if (RegExp(r'^horses_').hasMatch(prefixRemoved)) {
              finalRecord = prefixRemoved.substring(7);
              setState(() {
                resultColor = AppColors.primary;
                resultPackage = '(Frequenzwelt für Pferde)';
              });
            } else if (RegExp(r'^cats_and_dogs_').hasMatch(prefixRemoved)) {
              finalRecord = prefixRemoved.substring(14);
              setState(() {
                resultColor = AppColors.green;
                resultPackage = '(Frequenzwelt für Hunde und Katzen)';
              });
            } else if (RegExp(r'^humans_').hasMatch(prefixRemoved)) {
              finalRecord = prefixRemoved.substring(7);
              setState(() {
                resultColor = AppColors.complementary;
                resultPackage = '(Frequenzwelt für Dich)';
              });
            }

            setState(() {
              result = finalRecord;
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
      if (Platform.isIOS) NfcManager.instance.stopSession();
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
            ? const NFCErrorMessage()
            : !gotResult
                ? SingleChildScrollView(
                    child: Column(
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
                                color: resultColor,
                                child: Column(children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
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
                                  SansCentered(
                                    resultPackage,
                                    18,
                                    AppColors.white,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
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
