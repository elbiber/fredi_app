import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/app_colors.dart';
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
      } else {}

      // NfcManager.instance.stopSession();
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
      body: !gotResult
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
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.complementary),
                        ),
                        child: SansBold(
                            'Neue Frequenz übertragen', 18.0, AppColors.white),
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
    );
  }
}

class SetActualFreq extends StatefulWidget {
  const SetActualFreq({super.key});

  @override
  State<SetActualFreq> createState() => _SetActualFreqState();
}

class _SetActualFreqState extends State<SetActualFreq> {
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
                'Halte dein SmartphoneJetzt für ca. 1 Minute an Dein Fredi-Produkt. Jetzt wird dein Fredi-Produkt neu programmiert.',
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