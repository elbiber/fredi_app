import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:fredi_app/components/components.dart';
import 'package:fredi_app/components/font_components.dart';

import '../components/app_colors.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: FrediAppBarMain(),
        drawer: FredAppBarDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 25.0,
              ),
              SansBoldCentered('FAQ', 32, AppColors.primary),
              SizedBox(
                height: 25.0,
              ),
              FAQ(
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
              FAQ(
                question: "Wie kündige Ich ein Abo? (Android)",
                answer:
                    '* Stelle sicher, dass du mit dem richtigen Google-Konto angemeldet bist.\n* Öffne die Google Play Store App auf deinem Gerät.\n* Tippe oben rechts auf dein Profilbild.\n* Wähle Zahlungen und Abos.\n* Klicke anschließend auf Abonnements.\n* Tippe auf das Abo, das du kündigen möchtest.\n* Tippe auf Abo kündigen.\n* Folge den angezeigten Anweisungen und gib, falls gefragt, einen Kündigungsgrund an. *\n Bestätige die Kündigung, um den Prozess abzuschließen.\n\nDein Abo bleibt bis zum Ende der bezahlten Laufzeit aktiv. Danach wird der Zugang automatisch beendet. Du kannst ein Abo jederzeit neu abschließen, falls du deine Meinung änderst. Für weitere Informationen oder Unterstützung besuche unsere Webseite fredi-shop.com.',
                ansStyle: TextStyle(color: AppColors.black, fontSize: 18),
                queStyle: TextStyle(color: AppColors.primary, fontSize: 20),
                queDecoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                ansDecoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              FAQ(
                question: "Wie kündige Ich ein Abo? (IPhone/IOS)",
                answer:
                    '* Öffne die Einstellungen-App auf deinem iPhone.\n* Tippe auf deinen Apple-ID-Namen oben im Menü.\n* Wähle „Abonnements“ aus.\n* Suche das Fredi-Abo in der Liste und tippe darauf.\n* Wähle „Abo kündigen“ und bestätige deine Entscheidung.\n\nDein Abo bleibt bis zum Ende der bezahlten Laufzeit aktiv. Danach wird der Zugang automatisch beendet. Du kannst ein Abo jederzeit neu abschließen, falls du deine Meinung änderst. Für weitere Informationen oder Unterstützung besuche unsere Webseite fredi-shop.com.',
                ansStyle: TextStyle(color: AppColors.black, fontSize: 18),
                queStyle: TextStyle(color: AppColors.primary, fontSize: 20),
                queDecoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                ansDecoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              /*FAQ(
                question:
                    "Wird ein kleineres Abo automatisch gekündigt wenn ich ein größeres abschließe welche das kleinere beinhaltet?",
                answer:
                    'Nein, du musst das kleinere wie in der obigen Frage selber kündigen. Ansonsten läuft es parallel zum größeren weiter und du zahlst doppelt',
                ansStyle: TextStyle(color: AppColors.black, fontSize: 18),
                queStyle: TextStyle(color: AppColors.primary, fontSize: 20),
                queDecoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                ansDecoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),*/
            ],
          ),
        ));
  }
}
