// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/pages/login-page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login-page.dart'; // Import your login page
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Set SplashScreen as home initially
      routes: {
        '/login': (context) => LoginPage(), // Define routes for other screens
      },
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay navigation to login page by 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      backgroundColor: Colors.white, // Set background color as needed
      body: Center(
        child: Image.asset(
          'lib/images/LogoSTTS.png',
          width: 100, // กำหนดความกว้างของรูปภาพ
          height: 100,
        ),
      ),
    );
  }
}
