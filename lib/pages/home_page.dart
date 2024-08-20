import 'package:flutter/material.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/pages/programm_list_page.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  onPressed: () {
                    context.go('/nfc-read');
                  },
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(BorderSide(
                      color: AppColors.complementary,
                    )),
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.complementary),
                  ),
                  child:
                      Sans('Aktuelle Frequenz anzeigen', 18.0, AppColors.white),
                ),
                const SizedBox(
                  height: 15.0,
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
