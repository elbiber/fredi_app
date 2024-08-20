import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: FrediAppBarLogo(),
        drawer: FredAppBarDrawer(),
        body: SingleChildScrollView(
          child: Text('Kontakt'),
        ));
  }
}
