// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get preferences => 'वरीयताएँ';

  @override
  String get language => 'भाषा';

  @override
  String get liveGpsTracking => 'लाइव जीपीएस ट्रैकिंग';

  @override
  String get allowLiveGpsTracking => 'लाइव लोकेशन ट्रैकिंग की अनुमति दें';

  @override
  String get appVersion => 'ऐप संस्करण';

  @override
  String get logout => 'लॉग आउट';
}
