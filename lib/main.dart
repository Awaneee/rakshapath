import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/client/client_home.dart';
import 'screens/admin/admin_home.dart';

void main() {
  runApp(RakshapathApp());
}

class RakshapathApp extends StatelessWidget {
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
      initialRoute: '/',
      routes: {
        '/': (_) => SplashScreen(),
        '/login': (_) => LoginScreen(),
        '/client': (_) => ClientHome(),
        '/admin': (_) => AdminHome(),
      },
    );
  }
}
