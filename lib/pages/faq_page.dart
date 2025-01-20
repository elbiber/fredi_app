import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              SansBoldCentered(AppLocalizations.of(context)!.faqTitle, 32,
                  AppColors.primary),
              const SizedBox(
                height: 25.0,
              ),
              FAQ(
                question: AppLocalizations.of(context)!.productQuestion,
                answer: AppLocalizations.of(context)!.productAnswer,
                ansStyle: const TextStyle(color: AppColors.black, fontSize: 18),
                queStyle:
                    const TextStyle(color: AppColors.primary, fontSize: 20),
                queDecoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                ansDecoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              Platform.isAndroid
                  ? FAQ(
                      question: AppLocalizations.of(context)!
                          .cancelSubscriptionQuestionAndroid,
                      answer: AppLocalizations.of(context)!
                          .cancelSubscriptionAnswerAndroid,
                      ansStyle:
                          const TextStyle(color: AppColors.black, fontSize: 18),
                      queStyle: const TextStyle(
                          color: AppColors.primary, fontSize: 20),
                      queDecoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      ansDecoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )
                  : FAQ(
                      question: AppLocalizations.of(context)!
                          .cancelSubscriptionQuestionIOS,
                      answer: AppLocalizations.of(context)!
                          .cancelSubscriptionAnswerIOS,
                      ansStyle:
                          const TextStyle(color: AppColors.black, fontSize: 18),
                      queStyle: const TextStyle(
                          color: AppColors.primary, fontSize: 20),
                      queDecoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      ansDecoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
              Platform.isAndroid
                  ? FAQ(
                      question: AppLocalizations.of(context)!
                          .promoCodeQuestionAndroid,
                      answer:
                          AppLocalizations.of(context)!.promoCodeAnswerAndroid,
                      ansStyle:
                          const TextStyle(color: AppColors.black, fontSize: 18),
                      queStyle: const TextStyle(
                          color: AppColors.primary, fontSize: 20),
                      queDecoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      ansDecoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )
                  : FAQ(
                      question:
                          AppLocalizations.of(context)!.promoCodeQuestionIOS,
                      answer: AppLocalizations.of(context)!.promoCodeAnswerIOS,
                      ansStyle:
                          const TextStyle(color: AppColors.black, fontSize: 18),
                      queStyle: const TextStyle(
                          color: AppColors.primary, fontSize: 20),
                      queDecoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      ansDecoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
              Platform.isAndroid
                  ? FAQ(
                      question:
                          AppLocalizations.of(context)!.nfcActivationQuestion,
                      answer: AppLocalizations.of(context)!.nfcActivationAnswer,
                      ansStyle:
                          const TextStyle(color: AppColors.black, fontSize: 18),
                      queStyle: const TextStyle(
                          color: AppColors.primary, fontSize: 20),
                      queDecoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      ansDecoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )
                  : const SizedBox(),
            ],
          ),
        ));
  }
}
