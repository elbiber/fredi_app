import 'package:flutter/material.dart';
import 'package:flutter_open_app_settings/flutter_open_app_settings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:fredi_app/pages/programms_overview_page.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:video_player/video_player.dart';

class FrediAppBarMain extends StatelessWidget implements PreferredSizeWidget {
  const FrediAppBarMain({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.black,
      backgroundColor: AppColors.primary,
      elevation: 3.0,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              context.go('/');
            },
            child: SvgPicture.asset(
              'assets/icons/fredi-logo-long.svg',
              fit: BoxFit.contain,
              width: 120,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class FrediAppBarLight extends StatelessWidget implements PreferredSizeWidget {
  const FrediAppBarLight({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: AppColors.primary, //change your color here
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(
          'assets/icons/fredi-logo-long.svg',
          fit: BoxFit.contain,
          width: 120,
          colorFilter:
              const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
        ),
      ),
      backgroundColor: AppColors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class FredAppBarDrawer extends StatelessWidget {
  const FredAppBarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            child: SvgPicture.asset(
              'assets/icons/fredi-logo-square.svg',
              fit: BoxFit.contain,
              width: 120,
            ),
          ),
          const TabsMobile(
            'Home',
            '/',
          ),
          const SizedBox(
            height: 20.0,
          ),
          const TabsMobile(
            'Über Uns',
            '/about',
          ),
          const SizedBox(
            height: 20.0,
          ),
          const TabsMobile(
            'FAQ',
            '/faq',
          ),
          const SizedBox(
            height: 20.0,
          ),
          const TabsMobile(
            'Kontakt',
            '/contact',
          ),
          const SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }
}

class TabsMobile extends StatefulWidget {
  final String text;
  final String route;

  const TabsMobile(this.text, this.route, {super.key});

  @override
  State<TabsMobile> createState() => _TabsMobileState();
}

class _TabsMobileState extends State<TabsMobile> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      height: 50,
      minWidth: 200.0,
      child: Sans(widget.text, 20, Colors.black),
      onPressed: () {
        context.go(widget.route);
      },
    );
  }
}

class ControlsOverlay extends StatelessWidget {
  const ControlsOverlay({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : const ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}

class FrequencyPackages extends StatelessWidget {
  const FrequencyPackages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: SansBoldCentered('Du willst eine neue Frequenz übertragen?',
              25.0, AppColors.primary),
        ),
        const Sans(
          'Dein(e)FrediFrequenzpaket(e)',
          18.0,
          Colors.black,
        ),
        const SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProgrammsOverviewPage(
                    jsonFile: 'frequencies_humans.json',
                    titel: 'Frequenzwelt für Menschen',
                    titelImage: 'humans.png',
                    packageColor: AppColors.complementary),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/humans.png'),
              fit: BoxFit.cover,
            )),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SansBold('Frequenzwelt\nfür Menschen', 18.0, Colors.white),
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
            Navigator.popUntil(context, ModalRoute.withName('/'));
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProgrammsOverviewPage(
                    jsonFile: 'frequencies_horses.json',
                    titel: 'Frequenzwelt für Pferde',
                    titelImage: 'horses.png',
                    packageColor: AppColors.primary),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/horses.png'),
              fit: BoxFit.cover,
            )),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SansBold('Frequenzwelt\nfür Pferde', 18.0, Colors.white),
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
            Navigator.popUntil(context, ModalRoute.withName('/'));
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProgrammsOverviewPage(
                    jsonFile: 'frequencies_cats_and_dogs.json',
                    titel: 'Frequenzwelt für Hunde und Katzen',
                    titelImage: 'cats_and_dogs.png',
                    packageColor: AppColors.green),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/cats_and_dogs.png'),
              fit: BoxFit.cover,
            )),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SansBold(
                      'Frequenzwelt\nfür Hunde und Katzen', 18.0, Colors.white),
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
      ],
    );
  }
}

class FrediOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? bgColor;

  const FrediOutlinedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.bgColor = const Color(0xff005B96)});

  @override
  Widget build(BuildContext context) {
    /* return ButtonTheme(
        minWidth: 500,
        child: OutlinedButton(
            onPressed: () {},
            child: SansBoldCentered(text, 18, AppColors.black))); */
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all<Size>(const Size(250.0, 50.0)),
        side: WidgetStateProperty.all(const BorderSide(
          color: AppColors.white,
        )),
        backgroundColor: WidgetStateProperty.all(bgColor),
      ),
      child: SansBoldCentered(text, 18.0, AppColors.white),
    );
  }
}

class NFCErrorMessage extends StatelessWidget {
  const NFCErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: SansBoldCentered(
              'Leider ist die NFC Funktion Deines Smartphones im Moment deaktiviert. Du kannst diese in den Einstellungen deines Smartphones aktivieren. Drücke auf den Button um direkt dorthin zu gelangen.',
              20,
              AppColors.complementary),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                minimumSize: const Size(200, 50)),
            onPressed: () {
              FlutterOpenAppSettings.openAppsSettings(
                  settingsCode: SettingsCode.NFC,
                  onCompletion: () {
                    debugPrint('NFC Menu left');
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NFCActivated()),
                    );
                  });
            },
            child: const Text("NFC aktivieren")),
      ],
    );
  }
}

class NFCActivated extends StatelessWidget {
  const NFCActivated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBarLight(),
      body: FutureBuilder<bool>(
        future: NfcManager.instance.isAvailable(),
        builder: (context, ss) => ss.data == true
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: SansBoldCentered(
                        'NFC wurde erfolgreich aktiviert. Du kannst die Fredi App jetzt im vollem Umfang nutzen.',
                        20,
                        AppColors.primary),
                  ),
                ],
              )
            : const NFCErrorMessage(),
      ),
    );
  }
}
