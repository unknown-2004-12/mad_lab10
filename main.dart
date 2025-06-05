import 'package:flutter/material.dart'; 

void main() {
  runApp(MaterialApp(
    home: AnimatedLogoScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class AnimatedLogoScreen extends StatefulWidget {
  const AnimatedLogoScreen({super.key});

  @override
  State<AnimatedLogoScreen> createState() => _AnimatedLogoScreenState();
}

class _AnimatedLogoScreenState extends State<AnimatedLogoScreen> with TickerProviderStateMixin {
  late final AnimationController _rotationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 5),
  )..repeat();

  late final Animation<double> _rotationAnimation = Tween(
    begin: 0.0,
    end: 2 * 3.1415,
  ).animate(
    CurvedAnimation(parent: _rotationController, curve: Curves.linear),
  );

  late final AnimationController _opacityController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3),
  )..forward();

  late final Animation<double> _opacityAnimation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(parent: _opacityController, curve: Curves.easeInOut),
  );

  @override
  void dispose() {
    _rotationController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Animated Logo"),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _opacityAnimation,
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: child,
              ),
            );
          },
          child: Image.asset('assets/logo.png', width: 150, height: 150),
        ),
      ),
    );
  }
}
