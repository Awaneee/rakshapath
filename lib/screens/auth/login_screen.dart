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
  final SecureStorageService storage = SecureStorageService();
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
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your User ID')),
      );
      return;
    }

    setState(() => _isLogging = true);
    await Future.delayed(const Duration(milliseconds: 700));

    await storage.saveUsername(userId);

    setState(() => _isLogging = false);

    if (userId.toLowerCase().contains('admin')) {
      Navigator.pushReplacementNamed(context, '/admin');
    } else {
      Navigator.pushReplacementNamed(context, '/client');
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
            child: Image.asset(
              'assets/t3.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Glassmorphic login card
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
                  height: size.height * 0.45,
                  color: Colors.white.withOpacity(0.2),
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
                            "Enter USER ID",
                            style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          TextField(
                            controller: _idController,
                            decoration: InputDecoration(
                              labelText: 'User ID',
                              labelStyle: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              hintText: 'Enter your user ID',
                              hintStyle: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.black54,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF1F5F9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: size.height * 0.025),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLogging ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0284C7),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
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
                                      'Continue',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
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
