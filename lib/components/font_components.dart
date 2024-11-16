import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class SansCenteredLineThrough extends Sans {
  const SansCenteredLineThrough(super.text, super.size, super.fontColor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size,
        color: fontColor,
        decoration: TextDecoration.lineThrough,
      ),
      textAlign: TextAlign.center,
    );
  }
}
