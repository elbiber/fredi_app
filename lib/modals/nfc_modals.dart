import 'package:audioplayers/audioplayers.dart';
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
                child: SansBoldCentered(
                    'Leider verfügt Dein Smartphone keine NFC Funktion bzw. diese ist deaktiviert.',
                    22,
                    AppColors.black))
            : !gotResult
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),
                        // color: const Color(0xffFEC401),
                        color: AppColors.secondary,
                        child: SansCentered(
                          'Du willst wissen welche Frequenz aktuell auf deinen Fredi übertragen ist?',
                          18,
                          AppColors.white,
                        ),
                      ),
                      Column(
                        children: [
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
                      Container(
                        padding: const EdgeInsets.all(30),
                        // color: const Color(0xffFEC401),
                        color: AppColors.secondary,
                        child: Column(
                          children: [
                            SansCentered(
                              'Du willst eine neue Frequenz übertragen?',
                              18,
                              AppColors.white,
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                side: WidgetStateProperty.all(BorderSide(
                                  color: AppColors.white,
                                )),
                                backgroundColor: WidgetStateProperty.all(
                                    AppColors.complementary),
                              ),
                              child: SansBold('Neue Frequenz übertragen', 18.0,
                                  AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(30.0),
                          color: AppColors.secondary,
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

class SetActualFreq extends StatefulWidget {
  const SetActualFreq({super.key});

  @override
  State<SetActualFreq> createState() => _SetActualFreqState();
}

class _SetActualFreqState extends State<SetActualFreq> {
  bool transfering = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    debugPrint('--------------NFC Instance Opened---------------');
    final player = AudioPlayer();
    // const trans = TransferView();

    // showModalBottomSheet(context: context, builder: (ctx) => trans);
    NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
      var ndef = Ndef.from(badge);
      debugPrint(ndef.toString());
      if (ndef != null && ndef.isWritable) {
        NdefRecord ndefRecord = NdefRecord.createText('Frequenz 1');
        NdefMessage message = NdefMessage([ndefRecord]);
        debugPrint(message.records.toString());

        try {
          await ndef.write(message);
          await player.play(AssetSource('audio/programm_004.mp3'));
          await Future.delayed(const Duration(seconds: 5));
          if (!context.mounted) return;
          Navigator.pop(context);
          /* showModalBottomSheet(
                context: context,
                builder: (ctx) => const TransferViewFinished()); */
        } catch (e) {
          NfcManager.instance
              .stopSession(errorMessage: "Error while writing to badge");
        }
      }

      NfcManager.instance.stopSession();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                child: SansBoldCentered(
                    'Leider verfügt Dein Smartphone keine NFC Funktion bzw. diese ist deaktiviert.',
                    22,
                    AppColors.black))
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