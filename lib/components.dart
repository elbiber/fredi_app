import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class FrediAppBarLogo extends StatelessWidget implements PreferredSizeWidget {
  const FrediAppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xff005B96);
    return AppBar(
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 3.0,
      iconTheme: const IconThemeData(color: color),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/icon/fredi-logo-long.png',
            fit: BoxFit.contain,
            height: 42,
          )
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
      leading: const BackButton(color: Colors.white),
      title: SansBold(titel, 18.0, Colors.white),
      backgroundColor: const Color(0xff005B96),
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
            child: Image.asset(
              'assets/icon/fredi-logo-square.png',
              fit: BoxFit.contain,
              height: 12,
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
          /*  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () async =>
                    await launch("https://www.instagram.com/vetmedicum/"),
                icon: icon,
              ),
            ],
          ) */
          /*  ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Sans('Aktuelle Frequenz anzeigen', 16.0, Colors.black),
            onTap: () {
              Navigator.of(context).pushNamed('/actual-programm');
            },
          ),
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Sans('Neue Frequenz übertragen', 16.0, Colors.black),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Sans(
                'Alle Frequenzpakete im Überblick', 16.0, Colors.black),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Sans('Über uns', 16.0, Colors.black),
            onTap: () {
              Navigator.of(context).pushNamed('/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Sans('FAQ', 16.0, Colors.black),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Sans('Kontakt', 16.0, Colors.black),
            onTap: () {},
          ), */
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
      onPressed: () {},
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
