import 'package:flutter/material.dart';
import 'package:fredi_app/components.dart';

class TransferReadModal extends StatelessWidget {
  const TransferReadModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrediAppBar('Programm Anzeigen'),
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
