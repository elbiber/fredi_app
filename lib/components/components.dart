import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/pages/programm_list_page.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class FrediAppBarLogo extends StatelessWidget implements PreferredSizeWidget {
  const FrediAppBarLogo({super.key});

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

class FrediAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titel;
  const FrediAppBar(this.titel, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.go('/');
        },
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      title: SansBold(titel, 18.0, Colors.white),
      backgroundColor: AppColors.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class FrediAppBarLight extends StatelessWidget implements PreferredSizeWidget {
  final String titel;
  const FrediAppBarLight(this.titel, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.go('/');
        },
        icon: Icon(Icons.arrow_back, color: AppColors.primary),
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(
          'assets/icons/fredi-logo-long.svg',
          fit: BoxFit.contain,
          width: 120,
          colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
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

class SansBold extends StatelessWidget {
  final String text;
  final double size;
  final Color fontColor;
  const SansBold(this.text, this.size, this.fontColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: fontColor,
      ),
    );
  }
}

class SansBoldCentered extends Sans {
  const SansBoldCentered(super.text, super.size, super.fontColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size,
        color: fontColor,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class Sans extends StatelessWidget {
  final String text;
  final double size;
  final Color fontColor;
  const Sans(this.text, this.size, this.fontColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size,
        color: fontColor,
      ),
    );
  }
}

class SansCentered extends Sans {
  const SansCentered(super.text, super.size, super.fontColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size,
        color: fontColor,
      ),
      textAlign: TextAlign.center,
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
        Padding(
          padding: const EdgeInsets.all(30.0),
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
            context.go('/freq-dog-cat');
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
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProgrammView()));
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProgrammView()));
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
        )
      ],
    );
  }
}
