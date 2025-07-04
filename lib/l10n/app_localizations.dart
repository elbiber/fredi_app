import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('fr')
  ];

  /// The current Language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @languageCode.
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get languageCode;

  /// No description provided for @intro.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Fredi\'s APP! Would you like to support yourself and your pet with the finest form of bioresonance regulation? Then you\'ve come to the right place! Here you will find all the programs for your Fredi product.'**
  String get intro;

  /// No description provided for @getFrequencyButton.
  ///
  /// In en, this message translates to:
  /// **'Display current frequency'**
  String get getFrequencyButton;

  /// No description provided for @noFrequencyText.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any frequencies for your Fredi product yet?'**
  String get noFrequencyText;

  /// No description provided for @allPackagesInTheShopButton.
  ///
  /// In en, this message translates to:
  /// **'All frequencies in the store'**
  String get allPackagesInTheShopButton;

  /// No description provided for @newFrequencyText.
  ///
  /// In en, this message translates to:
  /// **'You want to transmit a new frequency?'**
  String get newFrequencyText;

  /// No description provided for @yourFrequncyPackagesText.
  ///
  /// In en, this message translates to:
  /// **'Your frequency packages'**
  String get yourFrequncyPackagesText;

  /// No description provided for @forYouTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequency world\nfor you'**
  String get forYouTitle;

  /// No description provided for @forHorseTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequency world\nfor horses'**
  String get forHorseTitle;

  /// No description provided for @forCatsAndDogsTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequency world\nfor dogs and cats'**
  String get forCatsAndDogsTitle;

  /// No description provided for @forFreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Free frequency\nworld for testing'**
  String get forFreeTitle;

  /// No description provided for @notInPossesionOfProgrammText.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, you do not own this program'**
  String get notInPossesionOfProgrammText;

  /// No description provided for @notInPossesionOfProgrammHintText.
  ///
  /// In en, this message translates to:
  /// **'You can find all subscriptions to the frequencies in our shop'**
  String get notInPossesionOfProgrammHintText;

  /// No description provided for @toShopButton.
  ///
  /// In en, this message translates to:
  /// **'To the Shop'**
  String get toShopButton;

  /// No description provided for @whichFrequencyText.
  ///
  /// In en, this message translates to:
  /// **'Do you want to know which frequency is currently transferred to your Fredi?'**
  String get whichFrequencyText;

  /// No description provided for @whichFrequencyInstructionText.
  ///
  /// In en, this message translates to:
  /// **'Briefly hold your smartphone near the Fredi product to display your current program.'**
  String get whichFrequencyInstructionText;

  /// No description provided for @wrongFrequencyText.
  ///
  /// In en, this message translates to:
  /// **'Your Fredi product currently does not have a valid frequency. Please transfer a frequency first!'**
  String get wrongFrequencyText;

  /// No description provided for @whichFrequencyIsSetText.
  ///
  /// In en, this message translates to:
  /// **'You currently have the following frequency transferred to your Fredi:'**
  String get whichFrequencyIsSetText;

  /// No description provided for @setFrequencyInstructionText.
  ///
  /// In en, this message translates to:
  /// **'Hold your smartphone close to your Fredi product for about 30 seconds. Your Fredi product will then be reprogrammed.'**
  String get setFrequencyInstructionText;

  /// No description provided for @setFrequencyText.
  ///
  /// In en, this message translates to:
  /// **'During the transmission process, we recommend reducing the smartphone volume to about 30%.'**
  String get setFrequencyText;

  /// No description provided for @setFrequencyErrorText.
  ///
  /// In en, this message translates to:
  /// **'There was an error during the transmission. Please try again.'**
  String get setFrequencyErrorText;

  /// No description provided for @setFrequencyTransmissionText.
  ///
  /// In en, this message translates to:
  /// **'The following frequency is now being transmitted:'**
  String get setFrequencyTransmissionText;

  /// No description provided for @setFrequencyWaitText.
  ///
  /// In en, this message translates to:
  /// **'Please wait until the transmission is complete.'**
  String get setFrequencyWaitText;

  /// No description provided for @setFrequencyCongratutlationText.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get setFrequencyCongratutlationText;

  /// No description provided for @setFrequencySuccessText.
  ///
  /// In en, this message translates to:
  /// **'The following frequency has been successfully transferred to your Fredi:'**
  String get setFrequencySuccessText;

  /// No description provided for @menuAboutUsButton.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get menuAboutUsButton;

  /// No description provided for @menuContactButton.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get menuContactButton;

  /// No description provided for @titleAboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get titleAboutUs;

  /// No description provided for @descriptionAboutUs.
  ///
  /// In en, this message translates to:
  /// **'All information about us, the Fredi app, and all its products can be found at:'**
  String get descriptionAboutUs;

  /// No description provided for @linkWebsite.
  ///
  /// In en, this message translates to:
  /// **'To our website'**
  String get linkWebsite;

  /// No description provided for @titlePrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get titlePrivacyPolicy;

  /// No description provided for @descriptionPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Our privacy policy can be found at:'**
  String get descriptionPrivacyPolicy;

  /// No description provided for @linkPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'To our Privacy Policy'**
  String get linkPrivacyPolicy;

  /// No description provided for @titleTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get titleTerms;

  /// No description provided for @descriptionTermsApple.
  ///
  /// In en, this message translates to:
  /// **'Our terms of use are based on Apple\'s Standard EULA:'**
  String get descriptionTermsApple;

  /// No description provided for @linkTermsApple.
  ///
  /// In en, this message translates to:
  /// **'To the Terms of Use'**
  String get linkTermsApple;

  /// No description provided for @descriptionTermsGoogle.
  ///
  /// In en, this message translates to:
  /// **'Our terms of use are based on Google Play\'s Terms of Use:'**
  String get descriptionTermsGoogle;

  /// No description provided for @titleContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get titleContact;

  /// No description provided for @descriptionContact.
  ///
  /// In en, this message translates to:
  /// **'If you need support for your Fredi product or subscription, you can find our support at:'**
  String get descriptionContact;

  /// No description provided for @linkContact.
  ///
  /// In en, this message translates to:
  /// **'To our Contact Page'**
  String get linkContact;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faqTitle;

  /// No description provided for @productQuestion.
  ///
  /// In en, this message translates to:
  /// **'Where can I find the products to which the Fredi app is applicable?'**
  String get productQuestion;

  /// No description provided for @productAnswer.
  ///
  /// In en, this message translates to:
  /// **'You can find all products and information on our website at www.fredi-shop.de'**
  String get productAnswer;

  /// No description provided for @cancelSubscriptionQuestionAndroid.
  ///
  /// In en, this message translates to:
  /// **'How do I cancel a subscription?'**
  String get cancelSubscriptionQuestionAndroid;

  /// No description provided for @cancelSubscriptionAnswerAndroid.
  ///
  /// In en, this message translates to:
  /// **'* Make sure you are signed in with the correct Google account.\n* Open the Google Play Store app on your device.\n* Tap on your profile picture in the top right corner.\n* Select Payments and Subscriptions.\n* Then click on Subscriptions.\n* Tap the subscription you want to cancel.\n* Tap Cancel Subscription.\n* Follow the on-screen instructions and, if prompted, provide a reason for cancellation.\n* Confirm the cancellation to complete the process.\n\nYour subscription will remain active until the end of the paid term. After that, access will automatically end. You can resubscribe anytime if you change your mind. For more information or assistance, visit our website fredi-shop.com.'**
  String get cancelSubscriptionAnswerAndroid;

  /// No description provided for @cancelSubscriptionQuestionIOS.
  ///
  /// In en, this message translates to:
  /// **'How do I cancel a subscription?'**
  String get cancelSubscriptionQuestionIOS;

  /// No description provided for @cancelSubscriptionAnswerIOS.
  ///
  /// In en, this message translates to:
  /// **'* Open the Settings app on your iPhone.\n* Tap your Apple ID name at the top of the menu.\n* Select Subscriptions.\n* Find the Fredi subscription in the list and tap on it.\n* Select Cancel Subscription and confirm your decision.\n\nYour subscription will remain active until the end of the paid term. After that, access will automatically end. You can resubscribe anytime if you change your mind. For more information or assistance, visit our website fredi-shop.com.'**
  String get cancelSubscriptionAnswerIOS;

  /// No description provided for @promoCodeQuestionAndroid.
  ///
  /// In en, this message translates to:
  /// **'How do I redeem a promo code or voucher?'**
  String get promoCodeQuestionAndroid;

  /// No description provided for @promoCodeAnswerAndroid.
  ///
  /// In en, this message translates to:
  /// **'* Open the Google Play Store app on your device.\n* Tap on your profile picture in the top right corner.\n* Select Payments and Subscriptions.\n* Then click on Subscriptions.\n* Tap Redeem Code.\n* Enter the code manually.'**
  String get promoCodeAnswerAndroid;

  /// No description provided for @promoCodeQuestionIOS.
  ///
  /// In en, this message translates to:
  /// **'How do I redeem a promo code or voucher?'**
  String get promoCodeQuestionIOS;

  /// No description provided for @promoCodeAnswerIOS.
  ///
  /// In en, this message translates to:
  /// **'* Open the App Store. Find the App Store icon and tap on it.\n* Tap your Apple ID name at the top of the menu.\n* Tap Redeem Gift Card or Code.\n* Enter the code manually.'**
  String get promoCodeAnswerIOS;

  /// No description provided for @nfcActivationQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I activate NFC transmission on my device?'**
  String get nfcActivationQuestion;

  /// No description provided for @nfcActivationAnswer.
  ///
  /// In en, this message translates to:
  /// **'* If NFC is not activated on your device, the app should automatically guide you to the settings. If not:\n* Tap on the gear icon on your home screen or in the app overview to open the settings menu.\n* Depending on the device, this area might have a different name. Look for \"Connections\" or \"Connected Devices\".\n* In the \"Connections\" or \"Connected Devices\" options, find the \"NFC\" (Near Field Communication) section.\n* Toggle the switch to activate NFC. The switch should move to \"On\".\n* After activating NFC, you can exit the settings. NFC is now active on your device.'**
  String get nfcActivationAnswer;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactTitle;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'All information about us, the Fredi app, and all its products can be found at:'**
  String get contactInfo;

  /// No description provided for @contactWebsiteUrl.
  ///
  /// In en, this message translates to:
  /// **'https://fredi-shop.com'**
  String get contactWebsiteUrl;

  /// No description provided for @contactWebsiteText.
  ///
  /// In en, this message translates to:
  /// **'www.fredi-shop.de'**
  String get contactWebsiteText;

  /// No description provided for @supportInfo.
  ///
  /// In en, this message translates to:
  /// **'If you need support for your Fredi product or subscription, you can find our support at:'**
  String get supportInfo;

  /// No description provided for @supportContactUrl.
  ///
  /// In en, this message translates to:
  /// **'https://fredi-shop.com/kontakt'**
  String get supportContactUrl;

  /// No description provided for @supportContactText.
  ///
  /// In en, this message translates to:
  /// **'www.fredi-shop.de/kontakt'**
  String get supportContactText;

  /// No description provided for @welcomeText.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the Fredi Shop!'**
  String get welcomeText;

  /// No description provided for @productInfoText.
  ///
  /// In en, this message translates to:
  /// **'Here you will find all available subscriptions for your Fredi product.'**
  String get productInfoText;

  /// No description provided for @restoreInfoText.
  ///
  /// In en, this message translates to:
  /// **'If you already have active subscriptions and have installed this app on a new device or your subscriptions are missing for any reason, you can restore them here.'**
  String get restoreInfoText;

  /// No description provided for @restorePurchasesButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchasesButton;

  /// No description provided for @premiumTitle.
  ///
  /// In en, this message translates to:
  /// **'Fredi Premium'**
  String get premiumTitle;

  /// No description provided for @priceDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Price / Duration'**
  String get priceDurationLabel;

  /// No description provided for @premiumPriceDetails.
  ///
  /// In en, this message translates to:
  /// **'€24.90 / 1 month\n€119.00 / 6 months\n€199.00 / 1 year'**
  String get premiumPriceDetails;

  /// No description provided for @premiumDescription.
  ///
  /// In en, this message translates to:
  /// **'With this subscription, all programs/frequencies in the Fredi app are unlocked.'**
  String get premiumDescription;

  /// No description provided for @additionalActiveSubscriptionsText.
  ///
  /// In en, this message translates to:
  /// **'You still have other active subscriptions that are already included in the Premium subscription. These will not be canceled automatically and will continue to run. Instructions on how to cancel your subscriptions to avoid double payments can be found in the FAQs section of the app.'**
  String get additionalActiveSubscriptionsText;

  /// No description provided for @privacyPolicyLabel.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyLabel;

  /// No description provided for @termsAndConditionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditionsLabel;

  /// No description provided for @alreadySubscribedText.
  ///
  /// In en, this message translates to:
  /// **'You already own this subscription! However, you can adjust this subscription.'**
  String get alreadySubscribedText;

  /// No description provided for @changeSubscriptionButton.
  ///
  /// In en, this message translates to:
  /// **'Change Subscription'**
  String get changeSubscriptionButton;

  /// No description provided for @subscribeButton.
  ///
  /// In en, this message translates to:
  /// **'View Offer'**
  String get subscribeButton;

  /// No description provided for @horseBasicTitle.
  ///
  /// In en, this message translates to:
  /// **'Basic Program Horse'**
  String get horseBasicTitle;

  /// No description provided for @horseBasicPriceDetails.
  ///
  /// In en, this message translates to:
  /// **'€4.90 / 1 month\n€24.90 / 6 months\n€39.90 / 1 year'**
  String get horseBasicPriceDetails;

  /// No description provided for @horseBasicDescription.
  ///
  /// In en, this message translates to:
  /// **'With this subscription, 16 frequency sequences for horses are unlocked.'**
  String get horseBasicDescription;

  /// No description provided for @premiumActiveInfoText.
  ///
  /// In en, this message translates to:
  /// **'You already own this program through your Premium subscription. However, if you want to switch to this program, you should cancel your Premium subscription to avoid double payments. Instructions for canceling your subscriptions can be found in the FAQs section of the app.'**
  String get premiumActiveInfoText;

  /// No description provided for @horseAdditionalTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional Programs Horse'**
  String get horseAdditionalTitle;

  /// No description provided for @horseAdditionalPriceDetails.
  ///
  /// In en, this message translates to:
  /// **'€9.90 / 1 month\n€49.90 / 6 months\n€89.90 / 1 year'**
  String get horseAdditionalPriceDetails;

  /// No description provided for @horseAdditionalDescription.
  ///
  /// In en, this message translates to:
  /// **'Unlocked frequency sequences:\n- Musculoskeletal System\n- Respiratory System and Skin\n- Metabolism and Organs\n- Emotion and Trauma'**
  String get horseAdditionalDescription;

  /// No description provided for @dogBasicTitle.
  ///
  /// In en, this message translates to:
  /// **'Basic Program Dog'**
  String get dogBasicTitle;

  /// No description provided for @dogBasicDescription.
  ///
  /// In en, this message translates to:
  /// **'With this subscription, 16 frequency sequences for dogs are unlocked.'**
  String get dogBasicDescription;

  /// No description provided for @dogAdditionalTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional Programs Dog'**
  String get dogAdditionalTitle;

  /// No description provided for @dogAdditionalPriceDetails.
  ///
  /// In en, this message translates to:
  /// **'€7.90 / 1 month\n€39.90 / 6 months\n€69.90 / 1 year'**
  String get dogAdditionalPriceDetails;

  /// No description provided for @dogAdditionalDescription.
  ///
  /// In en, this message translates to:
  /// **'Unlocked frequency sequences:\n- Musculoskeletal System\n- Skin, Digestive System, Ears\n- Emotion and Trauma'**
  String get dogAdditionalDescription;

  /// No description provided for @humanBasicTitle.
  ///
  /// In en, this message translates to:
  /// **'Fredi For You'**
  String get humanBasicTitle;

  /// No description provided for @humanBasicPriceDetails.
  ///
  /// In en, this message translates to:
  /// **'€4.90 / 1 month\n€24.90 / 6 months\n€39.90 / 1 year'**
  String get humanBasicPriceDetails;

  /// No description provided for @humanBasicDescription.
  ///
  /// In en, this message translates to:
  /// **'With this subscription, 16 frequency sequences for you are unlocked.'**
  String get humanBasicDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
