import 'package:flutter/material.dart';
import 'package:fredi_app/components.dart';
import 'package:fredi_app/pages/programm_list_page.dart';

class GetActualProgrammModal extends StatelessWidget {
  const GetActualProgrammModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBar('Aktuelles Programm'),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.rss_feed,
                size: 50.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              SansCentered(
                'Halte Dein Smartphone kurz an das Fredi Produkt um dein aktuelles Programm anzuzeigen.',
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

class ShowNoProgrammModal extends StatelessWidget {
  const ShowNoProgrammModal({super.key});

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
                'Du hast derzeit kein Programm auf Deinem Fredi Produkt',
                18,
                Colors.black,
              ),
              const SizedBox(
                height: 30,
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
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xff005B96)),
                ),
                child:
                    const Sans('Neue Frequenz übertragen', 18.0, Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
