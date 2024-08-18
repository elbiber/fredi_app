import 'package:flutter/material.dart';
import 'package:fredi_app/components.dart';
import 'package:fredi_app/modals/show_actual_programm_modal.dart';
import 'package:fredi_app/modals/transfer_modals.dart';
import 'package:fredi_app/pages/programm_list_page.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late YoutubePlayerController _controller;
  late VideoPlayerController _controller;

  static const mainColor = Color(0xff005B96);
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/demo.mov');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {}));
    // _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void readNfcTag() {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => const TransferReadModal(),
      );
      NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
        var ndef = Ndef.from(badge);

        if (ndef != null && ndef.cachedMessage != null) {
          String tempRecord = "";
          for (var record in ndef.cachedMessage!.records) {
            tempRecord =
                "$tempRecord ${String.fromCharCodes(record.payload.sublist(record.payload[0] + 1))}";
            Navigator.pop(context);
            showModalBottomSheet(
                context: context,
                builder: (ctx) => ShowActualProgrammModal(
                      actualProgramm: tempRecord,
                    ));
          }
        } else {
          // Show a snackbar for example
        }

        NfcManager.instance.stopSession();
      });
    }

    return Scaffold(
      appBar: const FrediAppBarLogo(),
      drawer: const FredAppBarDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        ControlsOverlay(controller: _controller),
                        VideoProgressIndicator(_controller,
                            allowScrubbing: true),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: SansCentered(
                      'Herzlichen Willkommen in derApp von Fredi! Lorem ipsum dolor sit amet,consetetur sadipscing elitr, sed diam nonumyeirmod tempor invidunt ut laboreet dolore magna aliquyam erat, sed diam voluptua',
                      16.0,
                      Colors.black),
                ),
                OutlinedButton(
                  onPressed: readNfcTag,
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(const BorderSide(
                      color: Color(0xff005B96),
                    )),
                    backgroundColor: WidgetStateProperty.all(mainColor),
                  ),
                  child: const Sans(
                      'Aktuelle Frequenz anzeigen', 18.0, Colors.white),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProgrammView()));
                  },
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(const BorderSide(
                      color: Color(0xff005B96),
                    )),
                    backgroundColor: WidgetStateProperty.all(mainColor),
                  ),
                  child: const Sans(
                      'Neue Frequenz übertragen', 18.0, Colors.white),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const Sans(
                  'Dein(e)FrediFrequenzpaket(e)',
                  18.0,
                  Colors.black,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProgrammView()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/cat-and-dog-dark.png'),
                      fit: BoxFit.cover,
                    )),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SansBold('Frequenzwelt\nfür Hunde und Katzen', 18.0,
                              Colors.white),
                          Icon(
                            Icons.arrow_circle_right,
                            color: Colors.orange,
                            size: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProgrammView()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/horse-dark.png'),
                      fit: BoxFit.cover,
                    )),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SansBold(
                              'Frequenzwelt\nfür Pferde', 18.0, Colors.white),
                          Icon(
                            Icons.arrow_circle_right,
                            color: Colors.orange,
                            size: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProgrammView()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/human-dark.png'),
                      fit: BoxFit.cover,
                    )),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SansBold(
                              'Frequenzwelt\nfür Menschen', 18.0, Colors.white),
                          Icon(
                            Icons.arrow_circle_right,
                            color: Colors.orange,
                            size: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    // Populate the Drawer in the next step.
  }
}
