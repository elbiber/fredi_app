import 'package:flutter/material.dart';
import 'package:fredi_app/components.dart';

class ShowActualProgrammModal extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final actualProgramm;
  const ShowActualProgrammModal({super.key, required this.actualProgramm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBar('Aktuelles Programm'),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SansCentered(
                'Du hast derzeit folgendes Programm auf Deinem Fredi Produkt:',
                18,
                Colors.black,
              ),
              const SizedBox(
                height: 30,
              ),
              SansBoldCentered(actualProgramm, 25.0, const Color(0xff005B96)),
            ],
          ),
        ),
      ),
    );
  }
}
