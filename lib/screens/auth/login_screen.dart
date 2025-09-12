import 'dart:ui';
import 'package:flutter/material.dart';
import '../../services/storageService.dart';
import '../../services/locationService.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = SecureStorageService();
  final LocationService locationService = LocationService();

  bool _isLogging = false;

  @override
  void initState() {
    super.initState();
    _checkAndSaveLocation();
  }

  /// ✅ Silently checks and saves location if possible
  Future<void> _checkAndSaveLocation() async {
    try {
      final locationData = await locationService.getCurrentLocation();

      if (locationData != null &&
          locationData.latitude != null &&
          locationData.longitude != null) {
        await storage.saveLocation(
          locationData.latitude!,
          locationData.longitude!,
        );
      }
      // ❌ No UI feedback if denied or error
    } catch (_) {
      // Ignore silently
    }
  }

  /// ✅ Handles login flow
  Future<void> _login() async {
    final userId = _idController.text.trim();
    final password = _passwordController.text.trim();

    if (userId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter ID and password')),
      );
      return;
    }

    setState(() => _isLogging = true);
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() => _isLogging = false);

    // Read stored credentials
    final storedUsername = await storage.readUsername();
    final storedPassword = await storage.readPassword();
    final storedRole = await storage.readRole();

    // Check if credentials match
    if (storedUsername == userId && storedPassword == password) {
      if (storedRole != null && storedRole.toLowerCase() == 'admin') {
        Navigator.pushReplacementNamed(context, '/admin');
      } else {
        Navigator.pushReplacementNamed(context, '/client');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          SizedBox.expand(
            child: Image.asset('assets/t3.jpg', fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 0),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    border: Border.all(width: 0, color: Colors.transparent),
                  ),
                  child: Center(
                    child: Container(
                      width: size.width * 0.82,
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.height * 0.016,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size.width * 0.06),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: size.width * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          TextField(
                            controller: _idController,
                            decoration: const InputDecoration(labelText: 'User ID'),
                          ),
                          SizedBox(height: size.height * 0.015),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: 'Password'),
                          ),
                          SizedBox(height: size.height * 0.025),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLogging ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0284C7),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: _isLogging
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                "Don't have an account? Signup.",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}