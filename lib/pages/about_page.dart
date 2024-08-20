import 'package:flutter/material.dart';
import 'package:fredi_app/components/components.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: FrediAppBarLogo(),
        drawer: FredAppBarDrawer(),
        body: SingleChildScrollView(
          child: Text('About'),
        ));
  }
}
