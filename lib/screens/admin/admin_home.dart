import 'package:flutter/material.dart';
import 'admin_screens/dashboard.dart';
import 'admin_screens/alerts.dart';
import 'admin_screens/tourists.dart';
import 'admin_screens/incidents.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    AdminDashboardScreen(),
    AdminAlertPanel(),
    AdminTouristDetails(),
    AdminIncidentManagement(),
  ];

  void _onTap(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rakshapath - Admin", style: TextStyle(color: Colors.white)),
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF0284C7),
        unselectedItemColor: Color(0xFFB8B8B8),
        currentIndex: _selectedIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'Tourists'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Incidents'),
        ],
      ),
    );
  }
}
