import 'package:flutter/material.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:fredi_app/modals/get_actual_frequency_modal.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/demo.mp4');

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
    return Scaffold(
      appBar: const FrediAppBarMain(),
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
                  padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 30.0),
                  child: SansCentered(
                      'Herzlich willkommen in der APP von Fredi! Du möchtest dich und dein Tier mit der feinsten Art der Bioresonanzregulation unterstützen? Dann bist du hier genau richtig! Hier findest du alle Programme für dein Fredi-Produkt.',
                      16.0,
                      Colors.black),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const GetActualFreq();
                      }),
                    );
                  },
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(const BorderSide(
                      color: AppColors.complementary,
                    )),
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.complementary),
                  ),
                  child: const SansBoldCentered(
                      'Aktuelle Frequenz anzeigen', 18.0, AppColors.white),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const FrequencyPackages(),
              ],
            ),
          ),
        ),
      ),
    );

    // Populate the Drawer in the next step.
  }
}
