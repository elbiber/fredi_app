import 'package:flutter/material.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:go_router/go_router.dart';

class FrequenciesDogsAndCatsPage extends StatelessWidget {
  const FrequenciesDogsAndCatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const FrediAppBarLogo(),
        drawer: const FredAppBarDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/cat-and-dog-dark.png'),
                  fit: BoxFit.cover,
                )),
                child: const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SansBold('Frequenzwelt\nfür Hunde und Katzen', 20.0,
                          Colors.white),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SansBold(
                      'Wähle durch anklicken die gewünschte Frequenz aus:',
                      18,
                      AppColors.primary,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextButton(
                      child: const Row(
                        children: [
                          Icon(
                            Icons.sync_alt,
                            size: 20,
                          ),
                          SizedBox(width: 20.0),
                          Sans('Frequenz 1', 18.0, Colors.black),
                        ],
                      ),
                      onPressed: () {
                        context.go('/nfc-write');
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
                          Sans('Frequenz 2', 18.0, Colors.black),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: const Row(
                        children: [
                          Icon(
                            Icons.sync_alt,
                            size: 20,
                          ),
                          SizedBox(width: 20.0),
                          Sans('Frequenz 3', 18.0, Colors.black),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: const Row(
                        children: [
                          Icon(
                            Icons.sync_alt,
                            size: 20,
                          ),
                          SizedBox(width: 20.0),
                          Sans('Frequenz 4', 18.0, Colors.black),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                color: AppColors.secondary,
                child: Column(
                  children: [
                    SansCentered(
                      'Du willst wissen welche Frequenz aktuell auf deinen Fredi übertragen ist?',
                      18,
                      AppColors.white,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        context.go('/nfc-read');
                      },
                      style: ButtonStyle(
                        side: WidgetStateProperty.all(BorderSide(
                          color: AppColors.white,
                        )),
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.complementary),
                      ),
                      child: SansBold(
                          'Aktuelle Frequenz anzeigen', 18.0, AppColors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
