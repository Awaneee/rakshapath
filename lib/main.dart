import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'l10n/app_localizations.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/client/client_home.dart';
import 'screens/admin/admin_home.dart';
import 'screens/auth/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rakshapath',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.light(
          primary: Color(0xFF2F382F),
          secondary: Color(0xFFBFD8AF),
          background: Color(0xFFF8FAF4),
        ),
        scaffoldBackgroundColor: Color(0xFFF8FAF4),
      ),
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('hi', ''), // Hindi, no country code
      ],
      initialRoute: '/',
      routes: {
        '/': (_) => SplashScreen(),
        '/login': (_) => LoginScreen(),
        '/signup': (_) => SignupScreen(),
        '/client': (_) => ClientHome(),
        '/admin': (_) => AdminHome(),
      },
    );
  }
}
