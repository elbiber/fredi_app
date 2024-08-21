import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: FrediAppBarMain(),
        drawer: FredAppBarDrawer(),
        body: SingleChildScrollView(
          child: Text('FAQ'),
        ));
  }
}
