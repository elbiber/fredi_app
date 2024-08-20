import 'package:flutter/material.dart';
import 'package:fredi_app/components.dart';
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
    debugPrint('--------------Close1---------------');
    // TODO: implement initState
    super.initState();
    NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
      debugPrint('--------------Close2---------------');
      var ndef = Ndef.from(badge);
      if (ndef != null && ndef.cachedMessage != null) {
        debugPrint('--------------Close---------------');
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
    // TODO: implement dispose
    super.dispose();
    NfcManager.instance.stopSession();
    debugPrint('--------------Close3---------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBar('Anzeigen'),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.rss_feed,
                size: 50.0,
              ),
              const SizedBox(
                height: 30.0,
              ),
              !gotResult
                  ? const SansCentered(
                      'Halte Dein Smartphone kurz an das Fredi Produkt um dein aktuelles Programm anzuzeigen.',
                      18,
                      Colors.black,
                    )
                  : Column(children: [
                      const SansCentered(
                        'Du hast derzeit folgendes Programm auf Deinem Fredi Produkt:',
                        18,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SansBoldCentered(result, 25.0, const Color(0xff005B96)),
                    ]), /* ValueListenableBuilder<dynamic>(
                      valueListenable: result,
                      builder: (context, value, _) => Text('${value ?? ''}'),
                    ), */
            ],
          ),
        ),
      ),
    );
  }
}
