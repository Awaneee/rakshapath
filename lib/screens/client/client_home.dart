import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'client_screens/dashboard.dart';
import 'client_screens/map_view.dart';
import 'client_screens/profile.dart';
import 'client_screens/settings.dart';
import 'client_screens/sos_view.dart';
import '../auth/storage.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int _selectedIndex = 0;
  String? _username; // <- local state variable

  final List<Widget> _screens = [
    ClientHomeDashboard(),
    ClientMapView(),
    ClientSOSView(),
    ClientProfile(),
    ClientSettings(),
  ];

  final storage = SecureStorageService();

  void _onTap(int index) => setState(() => _selectedIndex = index);

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final name = await storage.readUsername();
    if (mounted) {
      setState(() {
        _username = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Hi',
              style: GoogleFonts.roboto(
                color: Colors.black,
              ),
            ),
            Text(
              ' $_username,',
              style: GoogleFonts.roboto(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(
              Icons.person,
              color: Colors.black,
            )
          ],
        ),

        // --- MODIFICATION END ---
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.transparent),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF0284C7),
        unselectedItemColor: Color(0xFFB8B8B8),
        currentIndex: _selectedIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
          BottomNavigationBarItem(
              icon: Icon(Icons.report_problem_outlined), label: 'SOS'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}
