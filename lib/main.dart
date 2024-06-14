// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:travelguide/firebase_options.dart';
// import 'package:get/get.dart';
// import 'package:travelguide/repositories/authentication/auth_repo.dart';
// import 'package:travelguide/screens/onboarding/onboarding_screen.dart';
// import 'package:travelguide/screens/splash/splash_screen.dart';
// import 'package:travelguide/screens/home/home_screen.dart';
// import 'package:travelguide/screens/welcome/login_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
//       .then((value) => Get.put(AuthenticationRepository()));
//   final prefs = await SharedPreferences.getInstance();
//   final onboarding = prefs.getBool("onboarding") ?? false;
//   runApp(MyApp(onboarding: onboarding));
// }

// class MyApp extends StatelessWidget {
//   final bool onboarding;
//   const MyApp({super.key, this.onboarding = false});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(375, 812),
//       child: GetMaterialApp(
//         defaultTransition: Transition.rightToLeftWithFade,
//         transitionDuration: const Duration(milliseconds: 500),
//         debugShowCheckedModeBanner: false,
//         title: 'Splash Screen Example',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: onboarding ? LoginScreen() : OnboardingScreen(),
//       ),
//     );
//   }
// }

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:travelguide/firebase_options.dart';
// import 'package:get/get.dart';
// import 'package:travelguide/repositories/authentication/auth_repo.dart';
// import 'package:travelguide/screens/onboarding/onboarding_screen.dart';
// import 'package:travelguide/screens/splash/splash_screen.dart';
// import 'package:travelguide/screens/home/home_screen.dart';
// import 'package:travelguide/screens/welcome/login_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize shared preferences
//   final prefs = await SharedPreferences.getInstance();
//   final onboardingCompleted = prefs.getBool("onboarding") ?? false;

//   // Initialize Firebase
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
//       .then((value) => Get.put(AuthenticationRepository()));

//   runApp(MyApp(onboardingCompleted: onboardingCompleted));
// }

// class MyApp extends StatelessWidget {
//   final bool onboardingCompleted;
//   const MyApp({super.key, required this.onboardingCompleted});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       defaultTransition: Transition.rightToLeftWithFade,
//       transitionDuration: const Duration(milliseconds: 500),
//       debugShowCheckedModeBanner: false,
//       title: 'Travel Guide',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: onboardingCompleted ? AuthCheck() : OnboardingScreen(),
//     );
//   }
// }

// // Check authentication state and navigate accordingly
// class AuthCheck extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final user = AuthenticationRepository.instance.firebaseUser.value;
//       return user != null ? HomeScreen() : LoginScreen();
//     });
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelguide/firebase_options.dart';
import 'package:get/get.dart';
import 'package:travelguide/repositories/authentication/auth_repo.dart';
import 'package:travelguide/screens/onboarding/onboarding_screen.dart';
import 'package:travelguide/screens/splash/splash_screen.dart';
import 'package:travelguide/screens/home/home_screen.dart';
import 'package:travelguide/screens/welcome/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;
  runApp(MyApp(onboarding: onboarding));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_, __) => GetMaterialApp(
        defaultTransition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 200),
        debugShowCheckedModeBanner: false,
        title: 'Travel Guide',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InitialScreen(onboarding: onboarding),
      ),
    );
  }
}

class InitialScreen extends StatelessWidget {
  final bool onboarding;
  const InitialScreen({super.key, required this.onboarding});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1), () {
        Get.put(AuthenticationRepository());
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator.adaptive();
        } else {
          return onboarding ? LoginScreen() : OnboardingScreen();
        }
      },
    );
  }
}
