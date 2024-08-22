import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:nfc_manager/nfc_manager.dart';

class SetActualFreq extends StatefulWidget {
  final String selectedFrequency;
  final String audioAsset;
  const SetActualFreq(
      {super.key, required this.selectedFrequency, required this.audioAsset});

  @override
  State<SetActualFreq> createState() => _SetActualFreqState();
}

class _SetActualFreqState extends State<SetActualFreq> {
  bool transfering = false;
  bool transferSuccess = false;
  final player = AudioPlayer();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    debugPrint('--------------NFC Instance Opened---------------');
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag badge) async {
        var ndef = Ndef.from(badge);
        debugPrint('--------------Delayed---------------');

        if (ndef != null && ndef.isWritable) {
          NdefRecord ndefRecord =
              NdefRecord.createText(widget.selectedFrequency);
          NdefMessage message = NdefMessage([ndefRecord]);

          try {
            setState(() {
              transfering = true;
            });
            await ndef.write(message);
            debugPrint('--------------NFC Instance Written---------------');
            setState(() {
              transfering = true;
            });
            await player.play(AssetSource(widget.audioAsset));
            timer = Timer(const Duration(seconds: 5), () {
              setState(() {
                transfering = false;
                transferSuccess = true;
              });
            });
          } catch (e) {
            NfcManager.instance
                .stopSession(errorMessage: "Error while writing to badge");
          }
          NfcManager.instance.stopSession();
          debugPrint('--------------NFC Instance Closed 1---------------');
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
    timer.cancel();
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
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  transfering
                      ? Container(
                          padding: const EdgeInsets.all(30),
                          color: AppColors.primary,
                          child: Column(
                            children: [
                              SansCentered(
                                'Folgende Frequenz wird jetzt übertragen:',
                                18,
                                AppColors.white,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CircularProgressIndicator(
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
                                'Bitte warten, bist die Übertragung abgeschlossen ist.',
                                18,
                                AppColors.white,
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: !transferSuccess
                              ? const Column(
                                  children: [
                                    Icon(
                                      Icons.phonelink_ring_rounded,
                                      size: 50.0,
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    SansCentered(
                                      'Halte Dein Smartphone für ca. 1 Minute an Dein Fredi-Produkt. Dein Fredi-Produkt wird dann neu programmiert.',
                                      18,
                                      Colors.black,
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Column(
                                    children: [
                                      SansBoldCentered(
                                          'Herzlichen Glückwunsch!',
                                          20,
                                          AppColors.primary),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      SansCentered(
                                          'Folgende Frequenz wurde erfolgreich auf deinen Fredi übertragen:',
                                          20,
                                          AppColors.black),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      SansBoldCentered(widget.selectedFrequency,
                                          32, AppColors.primary),
                                    ],
                                  ),
                                ),
                        ),
                ],
              ),
      ),
    );
  }
}

class TransferViewFinished extends StatelessWidget {
  const TransferViewFinished({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBarLight(),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.rss_feed,
                size: 50.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              Sans(
                'Übertragung erfolgreich!',
                18,
                Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
