import 'package:flutter/material.dart';
import 'package:fredi_app/components.dart';

class ReadNfcView extends StatelessWidget {
  final String actualProgramm;
  //const ReadNfcView(this.actualProgramm, {super.key});
  const ReadNfcView({super.key, required this.actualProgramm});

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
              Sans(
                'Du hast derzeit folgendes Programm auf Deinem Fredi Produkt: $actualProgramm',
                18,
                Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
