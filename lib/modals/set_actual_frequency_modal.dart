import 'package:android_intent_plus/android_intent.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:go_router/go_router.dart';
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
  @override
  void initState() {
    super.initState();
    debugPrint('--------------NFC Instance Opened---------------');
    final player = AudioPlayer();
    NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
      var ndef = Ndef.from(badge);

      if (ndef != null && ndef.isWritable) {
        NdefRecord ndefRecord = NdefRecord.createText(widget.selectedFrequency);
        NdefMessage message = NdefMessage([ndefRecord]);
        debugPrint(message.records.toString());

        try {
          setState(() {
            transfering = true;
          });
          await ndef.write(message);
          await player.play(AssetSource(widget.audioAsset));
          await player.getDuration().then(
                (value) => setState(() {
                  debugPrint(value?.inMilliseconds.toString());
                  Future.delayed(Duration(milliseconds: value!.inMilliseconds),
                      () {
                    context.go('/transfer-success');
                  });
                }),
              );
        } catch (e) {
          NfcManager.instance
              .stopSession(errorMessage: "Error while writing to badge");
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    NfcManager.instance.stopSession();
    debugPrint('--------------NFC Instance Closed---------------');
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
                                  'Frequenz 1', 25.0, AppColors.white),
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
                      : const Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
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
/* SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/cat-and-dog-dark.png'),
                fit: BoxFit.cover,
              )),
              child: const Padding(
                padding: EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SansBold('Frequenzwelt\nfür Hunde und Katzen', 20.0,
                        Colors.white),
                  ],
                ),
              ),
            ),
            Container(
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phonelink_ring_rounded,
                    size: 50.0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  SansCentered(
                    'Halte dein Smartphone für ca. 1 Minute an Dein Fredi-Produkt. Dein Fredi-Produkt wird dann neu programmiert.',
                    18,
                    Colors.black,
                  ),
                ],
              ),
            ), /*  */
          ],
        ), */

/*             Container(
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
                  SansBoldCentered('Frequenz 1', 25.0, AppColors.white),
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
            ), */