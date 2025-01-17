import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:nfc_manager/nfc_manager.dart';

class SetActualFreq extends StatefulWidget {
  final String packageID;
  final String selectedFrequency;
  final String audioAsset;
  final Color packageColor;

  const SetActualFreq(
      {super.key,
      required this.packageID,
      required this.selectedFrequency,
      required this.audioAsset,
      required this.packageColor});

  @override
  State<SetActualFreq> createState() => _SetActualFreqState();
}

class _SetActualFreqState extends State<SetActualFreq> {
  bool transferring = false;
  final player = AudioPlayer();

  // ignore: prefer_typing_uninitialized_variables
  var timer;

  @override
  void initState() {
    super.initState();
    debugPrint('--------------NFC Instance Opened---------------');
    debugPrint(widget.audioAsset);
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag badge) async {
        var ndef = Ndef.from(badge);

        if (ndef != null && ndef.isWritable) {
          NdefRecord ndefRecord = NdefRecord.createText(
              'fsp_${widget.packageID}_${widget.selectedFrequency}');
          NdefMessage message = NdefMessage([ndefRecord]);

          try {
            setState(() {
              transferring = true;
            });
            await ndef.write(message);
            debugPrint('--------------NFC Instance Written---------------');
            setState(() {
              transferring = true;
            });
            await player.play(AssetSource(widget.audioAsset));
            timer = Timer(const Duration(seconds: 30), () {
              setState(() {
                transferring = false;
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransferViewFinished(
                        selectedFrequency: widget.selectedFrequency,
                        packageColor: widget.packageColor),
                  ),
                );
              });
            });
          } catch (e) {
            NfcManager.instance.stopSession(
                errorMessage:
                    "Es gab einen Fehler bei der Übtragung. Bitte versuche es noch einmal");
            debugPrint('ERRo');
            transferring = false;
          }
          if (Platform.isIOS) NfcManager.instance.stopSession();
          debugPrint('--------------NFC Instance Closed 1---------------');
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
    if (timer != null) timer.cancel();
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
            : Column(
                mainAxisAlignment: Platform.isIOS
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  transferring
                      ? Container(
                          padding: const EdgeInsets.all(30),
                          color: widget.packageColor,
                          child: Column(
                            children: [
                              SansCentered(
                                AppLocalizations.of(context)!
                                    .setFrequencyTransmissionText,
                                18,
                                AppColors.white,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const CircularProgressIndicator(
                                backgroundColor: AppColors.white,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SansBoldCentered(
                                widget.selectedFrequency,
                                25.0,
                                AppColors.white,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SansBoldCentered(
                                AppLocalizations.of(context)!
                                    .setFrequencyWaitText,
                                18,
                                AppColors.white,
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.phonelink_ring_rounded,
                                size: 75.0,
                                color: AppColors.primary,
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              SansBoldCentered(
                                AppLocalizations.of(context)!
                                    .setFrequencyInstructionText,
                                20,
                                AppColors.primary,
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              const Icon(
                                Icons.volume_down_outlined,
                                size: 75.0,
                                color: AppColors.black,
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              SansCentered(
                                AppLocalizations.of(context)!.setFrequencyText,
                                18,
                                AppColors.black,
                              ),
                            ],
                          )),
                ],
              ),
      ),
    );
  }
}

class TransferViewFinished extends StatelessWidget {
  final String selectedFrequency;
  final Color packageColor;

  const TransferViewFinished(
      {super.key, required this.selectedFrequency, required this.packageColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBarLight(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SansBoldCentered(
                  AppLocalizations.of(context)!.setFrequencyCongratutlationText,
                  20,
                  packageColor),
              const SizedBox(
                height: 25,
              ),
              SansCentered(
                  AppLocalizations.of(context)!.setFrequencySuccessText,
                  20,
                  AppColors.black),
              const SizedBox(
                height: 25,
              ),
              SansBoldCentered(selectedFrequency, 24, packageColor),
            ],
          ),
        ),
      ),
    );
  }
}
