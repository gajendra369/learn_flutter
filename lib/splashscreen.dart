import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  final int duration;
  final Widget navigateAfterDuration;

  const SplashScreen({
    Key? key,
    required this.duration,
    required this.navigateAfterDuration,
  }) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.duration), () {
      //set timer for splash screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => widget.navigateAfterDuration,
        ),
      );
    });
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 0.0), // Slide from left to right
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully opaque
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5793ED),
      body: SafeArea(
        child: Center(
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SvgPicture.asset(
                'assets/entryPage.svg',
                width: 250,
                height: 300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}