import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fredi_app/components.dart';
import 'package:fredi_app/transfer_view.dart';
import 'package:nfc_manager/nfc_manager.dart';

class ProgrammView extends StatelessWidget {
  const ProgrammView({super.key});

  @override
  Widget build(BuildContext context) {
    void writeNfcTag(String progammName, String pathToAudioFile) {
      final player = AudioPlayer();

      showModalBottomSheet(
          context: context, builder: (ctx) => const TransferView());
      NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
        var ndef = Ndef.from(badge);
        debugPrint(ndef.toString());
        if (ndef != null && ndef.isWritable) {
          NdefRecord ndefRecord = NdefRecord.createText(progammName);
          NdefMessage message = NdefMessage([ndefRecord]);
          debugPrint(message.records.toString());

          try {
            await ndef.write(message);
            await player.play(AssetSource(pathToAudioFile));
            await Future.delayed(const Duration(seconds: 5));
            if (!context.mounted) return;
            Navigator.pop(context);
            showModalBottomSheet(
                context: context,
                builder: (ctx) => const TransferViewFinished());
          } catch (e) {
            NfcManager.instance
                .stopSession(errorMessage: "Error while writing to badge");
          }
        }

        NfcManager.instance.stopSession();
      });
    }

    return Scaffold(
      appBar: const FrediAppBar('Grundprogramm Mensch'),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: NfcManager.instance.isAvailable(),
          builder: (context, ss) => ss.data != true
              ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
              : Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      const Sans(
                        'Wähle durch anklicken das gewünschte Programm aus:',
                        18,
                        Colors.black,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Column(
                        children: [
                          TextButton(
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.sync_alt,
                                  size: 20,
                                ),
                                SizedBox(width: 20.0),
                                Sans('Programm 1', 15.0, Colors.black),
                              ],
                            ),
                            onPressed: () {
                              writeNfcTag(
                                  'Programm 1', 'audio/programm_004.mp3');
                            },
                          ),
                          TextButton(
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.sync_alt,
                                  size: 20,
                                ),
                                SizedBox(width: 20.0),
                                Sans('Programm 2', 15.0, Colors.black),
                              ],
                            ),
                            onPressed: () {
                              writeNfcTag(
                                  'Programm 2', 'audio/programm_004.mp3');
                            },
                          ),
                          TextButton(
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.sync_alt,
                                  size: 20,
                                ),
                                SizedBox(width: 20.0),
                                Sans('Programm 3', 15.0, Colors.black),
                              ],
                            ),
                            onPressed: () {
                              writeNfcTag(
                                  'Programm 3', 'audio/programm_004.mp3');
                            },
                          ),
                          TextButton(
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.sync_alt,
                                  size: 20,
                                ),
                                SizedBox(width: 20.0),
                                Sans('Programm 4', 15.0, Colors.black),
                              ],
                            ),
                            onPressed: () {
                              writeNfcTag(
                                  'Programm 4', 'audio/programm_004.mp3');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
