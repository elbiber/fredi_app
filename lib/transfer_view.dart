import 'package:flutter/material.dart';
import 'package:fredi_app/components.dart';

class TransferView extends StatefulWidget {
  const TransferView({super.key});

  @override
  State<TransferView> createState() => _TransferViewState();
}

class _TransferViewState extends State<TransferView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBar('Übertragung'),
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
              Sans(
                'Halte dein SmartphoneJetzt für ca. 1 Minute an Dein Fredi-Produkt. Jetzt wird dein Fredi-Produkt neu programmiert.',
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

class TransferViewFinished extends StatelessWidget {
  const TransferViewFinished({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBar('Übertragung'),
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
              Sans(
                'Übertragung erfolgreich!',
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

class TransferViewRead extends StatelessWidget {
  const TransferViewRead({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBar('Übertragung'),
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
              Sans(
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
