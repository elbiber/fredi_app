import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';

import '../components/app_colors.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const FrediAppBarMain(),
        drawer: const FredAppBarDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25.0,
              ),
              const SansBoldCentered('FAQ', 32, AppColors.primary),
              const SizedBox(
                height: 25.0,
              ),
              const FAQ(
                question:
                    'Wo finde ich die Produkte auf welche die Fredi App anwendbar sind?',
                answer:
                    'Alle Produkte und Information findest du auf unserer Homepage unter www.fredi-shop.de',
                ansStyle: TextStyle(color: AppColors.black, fontSize: 18),
                queStyle: TextStyle(color: AppColors.primary, fontSize: 20),
                queDecoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                ansDecoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              Platform.isAndroid
                  ? const FAQ(
                      question: "Wie kündige Ich ein Abo?",
                      answer:
                          '* Stelle sicher, dass du mit dem richtigen Google-Konto angemeldet bist.\n* Öffne die Google Play Store App auf deinem Gerät.\n* Tippe oben rechts auf dein Profilbild.\n* Wähle Zahlungen und Abos.\n* Klicke anschließend auf Abonnements.\n* Tippe auf das Abo, das du kündigen möchtest.\n* Tippe auf Abo kündigen.\n* Folge den angezeigten Anweisungen und gib, falls gefragt, einen Kündigungsgrund an. *\n Bestätige die Kündigung, um den Prozess abzuschließen.\n\nDein Abo bleibt bis zum Ende der bezahlten Laufzeit aktiv. Danach wird der Zugang automatisch beendet. Du kannst ein Abo jederzeit neu abschließen, falls du deine Meinung änderst. Für weitere Informationen oder Unterstützung besuche unsere Webseite fredi-shop.com.',
                      ansStyle: TextStyle(color: AppColors.black, fontSize: 18),
                      queStyle:
                          TextStyle(color: AppColors.primary, fontSize: 20),
                      queDecoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      ansDecoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )
                  : const FAQ(
                      question: "Wie kündige Ich ein Abo?",
                      answer:
                          '* Öffne die Einstellungen-App auf deinem iPhone.\n* Tippe auf deinen Apple-ID-Namen oben im Menü.\n* Wähle „Abonnements“ aus.\n* Suche das Fredi-Abo in der Liste und tippe darauf.\n* Wähle „Abo kündigen“ und bestätige deine Entscheidung.\n\nDein Abo bleibt bis zum Ende der bezahlten Laufzeit aktiv. Danach wird der Zugang automatisch beendet. Du kannst ein Abo jederzeit neu abschließen, falls du deine Meinung änderst. Für weitere Informationen oder Unterstützung besuche unsere Webseite fredi-shop.com.',
                      ansStyle: TextStyle(color: AppColors.black, fontSize: 18),
                      queStyle:
                          TextStyle(color: AppColors.primary, fontSize: 20),
                      queDecoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      ansDecoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
              Platform.isAndroid
                  ? const FAQ(
                      question:
                          "Wie löse ich einen Promocode bzw. Gutschein ein?",
                      answer:
                          '* Öffne die Google Play Store App auf deinem Gerät.\n* Tippe oben rechts auf dein Profilbild.\n* Wähle Zahlungen und Abos.\n* Klicke anschließend auf Abonnements.\n* Dann auf Code einlösen.\n* Code manuell eingeben.',
                      ansStyle: TextStyle(color: AppColors.black, fontSize: 18),
                      queStyle:
                          TextStyle(color: AppColors.primary, fontSize: 20),
                      queDecoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      ansDecoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )
                  : const FAQ(
                      question:
                          "Wie löse ich einen Promocode bzw. Gutschein ein?",
                      answer:
                          '* Öffne den App Store. Suche auf das Icon für den App Store und tippe darauf.\n* Tippe auf deinen Apple-ID-Namen oben im Menü.\n* Tippe auf „Karte oder Code einlösen“.\n* Code manuell eingeben.',
                      ansStyle: TextStyle(color: AppColors.black, fontSize: 18),
                      queStyle:
                          TextStyle(color: AppColors.primary, fontSize: 20),
                      queDecoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      ansDecoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
              Platform.isAndroid
                  ? const FAQ(
                      question:
                          "Wie aktiviere ich die NFC-Übertragung auf meinem Gerät?",
                      answer:
                          '* Falls NFC auf deinem Gerät nicht aktiviert ist, sollte die App dich automatisch zu den Einstellungen führen. Falls nicht:\n* Tippe auf das Zahnrad-Symbol auf deinem Startbildschirm oder in der App-Übersicht, um das Einstellungsmenü zu öffnen.\n* Je nach Gerät kann dieser Bereich anders benannt sein. Suche nach "Verbindungen" oder "Verbundene Geräte".\n* In den "Verbindungen" oder "Verbundene Geräte"-Optionen findest du den Punkt "NFC" (Near Field Communication).\n* Schiebe den Schalter, um NFC zu aktivieren. Der Schalter sollte auf "Ein" springen.\n* Nachdem NFC aktiviert ist, kannst du die Einstellungen verlassen. NFC ist nun auf deinem Gerät aktiv.',
                      ansStyle: TextStyle(color: AppColors.black, fontSize: 18),
                      queStyle:
                          TextStyle(color: AppColors.primary, fontSize: 20),
                      queDecoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      ansDecoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )
                  : const SizedBox(),
            ],
          ),
        ));
  }
}
