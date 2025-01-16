import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:fredi_app/modals/get_actual_frequency_modal.dart';
import 'package:go_router/go_router.dart';
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
    _controller = VideoPlayerController.asset('assets/video/fredi_intro.mp4');

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 30.0),
                  child: SansCentered(
                      AppLocalizations.of(context)!.intro, 16.0, Colors.black),
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
                  child: SansBoldCentered(
                      AppLocalizations.of(context)!.getFrequencyButton,
                      18.0,
                      AppColors.white),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const FrequencyPackages(),
                const SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 30.0),
                  child: SansBoldCentered(
                      AppLocalizations.of(context)!.noFrequencyText,
                      22.0,
                      AppColors.primary),
                ),
                OutlinedButton(
                  onPressed: () {
                    context.go('/shop');
                  },
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(const BorderSide(
                      color: AppColors.complementary,
                    )),
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.complementary),
                  ),
                  child: SansBoldCentered(
                      AppLocalizations.of(context)!.allPackagesInTheShopButton,
                      18.0,
                      AppColors.white),
                ),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Populate the Drawer in the next step.
  }
}
