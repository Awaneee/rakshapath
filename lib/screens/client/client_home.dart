import 'package:flutter/material.dart';
import 'client_screens/dashboard.dart';
import 'client_screens/map_view.dart';
import 'client_screens/profile.dart';
import 'client_screens/settings.dart';

class ClientHome extends StatefulWidget {
  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ClientHomeDashboard(),
    ClientMapView(),
    ClientProfile(),
    ClientSettings(),
  ];

  void _onTap(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rakshapath - Tourist', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF06B6D4), Color(0xFF0284C7)],
            ),
          ),
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
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Quick SOS global action
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Global SOS: Help is on the way!')),
          );
        },
        label: Text('SOS'),
        icon: Icon(Icons.warning),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
