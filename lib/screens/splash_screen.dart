import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // Animation controllers
  late final AnimationController _pageController;
  late final AnimationController _rippleController;
  
  // Animation values
  late Animation<double> _rippleAnimation;
  
  // Current page index (0: Hello, 1: Welcome to, 2: Rakshapath)
  int _currentPage = 0;

  // Colors
  final Color _primaryColor = const Color(0xFF6C63FF);
  final Color _accentColor = const Color(0xFF00BFA6);
  final Color _backgroundColor = const Color(0xFF121212);

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers
    _pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    
    // Initialize ripple animation
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _rippleController,
        curve: Curves.easeOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          _rippleController.reset();
          _rippleController.forward();
        }
      });
    
    // Start the animation sequence
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimationSequence();
    });
  }

  Future<void> _startAnimationSequence() async {
    // Show "Hello!"
    setState(() => _currentPage = 0);
    _pageController.reset();
    await _pageController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Show "Welcome to"
    setState(() => _currentPage = 1);
    _pageController.reset();
    await _pageController.forward();
    await Future.delayed(const Duration(milliseconds: 1000));

    // Show "Rakshapath" with ripple effect
    setState(() => _currentPage = 2);
    _rippleController.forward();

    // Navigate to login after delay
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        children: [
          // Ripple effect background (only for Rakshapath screen)
          if (_currentPage == 2)
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8 * _rippleAnimation.value,
                    height: MediaQuery.of(context).size.width * 0.8 * _rippleAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _primaryColor.withOpacity(0.05 * (1 - _rippleAnimation.value)),
                          _primaryColor.withOpacity(0.01 * (1 - _rippleAnimation.value)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          
          // Main content
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              child: _currentPage == 0
                  ? const Text(
                      'Hello!',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    )
                  : _currentPage == 1
                      ? const Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // App logo/icon
                            Container(
                              width: 120,
                              height: 120,
                              margin: const EdgeInsets.only(bottom: 30),
                              decoration: BoxDecoration(
                                color: _primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _primaryColor.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.security_rounded,
                                size: 60,
                                color: _primaryColor,
                              ),
                            ),
                            
                            // App title with gradient
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [_primaryColor, _accentColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: const Text(
                                'Rakshapath',
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Subtitle
                            const Text(
                              'Your Safety Companion',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            
                            // Loading indicator
                            const SizedBox(height: 40),
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF6C63FF),
                                ),
                                strokeWidth: 2,
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
