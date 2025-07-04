import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../l10n/app_localizations.dart';

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
          debugPrint('----$rawRecord-----------------------');
          for (int i = 0; i < rawRecord.length; i++) {
            if (rawRecord[i] == 195) {
              //german
              if (rawRecord[i + 1] == 132) rawRecord[i + 1] = 0x00C4;
              if (rawRecord[i + 1] == 164) rawRecord[i + 1] = 0x00E4;
              if (rawRecord[i + 1] == 150) rawRecord[i + 1] = 0x00D6;
              if (rawRecord[i + 1] == 182) rawRecord[i + 1] = 0x00F6;
              if (rawRecord[i + 1] == 156) rawRecord[i + 1] = 0x00DC;
              if (rawRecord[i + 1] == 188) rawRecord[i + 1] = 0x00FC;
              //french
              if (rawRecord[i + 1] == 169) rawRecord[i + 1] = 0x00E8;
              if (rawRecord[i + 1] == 137) rawRecord[i + 1] = 0x00C8;
              if (rawRecord[i + 1] == 162) rawRecord[i + 1] = 0x00E2;

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
                resultPackage =
                    '(${AppLocalizations.of(context)!.forFreeTitle})';
              });
            } else if (RegExp(r'^horses_').hasMatch(prefixRemoved)) {
              finalRecord = prefixRemoved.substring(7);
              setState(() {
                resultColor = AppColors.primary;
                resultPackage =
                    '(${AppLocalizations.of(context)!.forHorseTitle})';
              });
            } else if (RegExp(r'^cats_and_dogs_').hasMatch(prefixRemoved)) {
              finalRecord = prefixRemoved.substring(14);
              setState(() {
                resultColor = AppColors.green;
                resultPackage =
                    '(${AppLocalizations.of(context)!.forCatsAndDogsTitle})';
              });
            } else if (RegExp(r'^humans_').hasMatch(prefixRemoved)) {
              finalRecord = prefixRemoved.substring(7);
              setState(() {
                resultColor = AppColors.complementary;
                resultPackage =
                    '(${AppLocalizations.of(context)!.forYouTitle})';
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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: SansCentered(
                                  AppLocalizations.of(context)!
                                      .whichFrequencyText,
                                  18,
                                  AppColors.white,
                                ),
                              ),
                              const Icon(
                                Icons.phonelink_ring_rounded,
                                size: 50.0,
                                color: AppColors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: SansCentered(
                                  AppLocalizations.of(context)!
                                      .whichFrequencyInstructionText,
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
                                  SansCentered(
                                    AppLocalizations.of(context)!
                                        .whichFrequencyIsSetText,
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
                                child: Column(children: [
                                  SansBoldCentered(
                                    AppLocalizations.of(context)!
                                        .noFrequencyText,
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
