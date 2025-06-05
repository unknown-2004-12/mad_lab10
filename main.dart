import 'package:flutter/material.dart'; // Import the material packag
void main() {
  runApp(MaterialApp(
    home : AnimatedLogoScreen(),
    debugShowCheckedModeBanner: false, // Disable debug banner
  )); // Entry point of app
}
// -------------------- MAIN ANIMATION SCREEN --------------------
class AnimatedLogoScreen extends StatefulWidget {
  const AnimatedLogoScreen({super.key});

  @override
  State<AnimatedLogoScreen> createState() => _AnimatedLogoScreenState();
}
// -------------------- ANIMATED LOGO SCREEN STATE --------------------
class _AnimatedLogoScreenState extends State<AnimatedLogoScreen> with TickerProviderStateMixin {
  late final AnimationController _rotationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 5),
  )..repeat();

  late final Animation<double> _rotationAnimation = Tween(
    begin: 0.0,
    end: 2 * 3.1415, // 2 * pi for full rotation
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
    _rotationController.dispose(); // Clean up
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Background color
      appBar: AppBar(
        title: Text("Animated Logo"), // Title
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _rotationController, // Rebuild UI every tick of rotation
          builder: (context, child) {
            return FadeTransition( // Handles fade in
              opacity: _opacityAnimation,
              child: Transform.rotate( // Handles rotation
                angle: _rotationAnimation.value,
                child: child,
              ),
            );
          },
          // child: FlutterLogo(size: 150), // Flutter logo to animate
          child: Image.asset('assets/logo.png',width: 150, height: 150,),
        ),
      ),
    );
  }
}
