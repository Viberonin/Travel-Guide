import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:travelguide/components/navbar/navigation_bar.dart';
import 'package:travelguide/repositories/authentication/signup_failure.dart';
import 'package:travelguide/screens/home/home_screen.dart';
import 'package:travelguide/screens/onboarding/onboarding_screen.dart';
import 'package:travelguide/screens/welcome/login_screen.dart';

// class AuthenticationRepository extends GetxController {
//   static AuthenticationRepository get instance => Get.find();

//   final _auth = FirebaseAuth.instance;
//   late final Rx<User?> firebaseUser;

//   @override
//   void onReady() {
//     Future.delayed(const Duration(seconds: 5));
//     firebaseUser = Rx<User?>(_auth.currentUser);
//     firebaseUser.bindStream(_auth.userChanges());
//     ever(firebaseUser, _setInitialScreen);
//   }

//   _setInitialScreen(User? user) {
//     user == null
//         ? Get.offAll(() => OnboardingScreen())
//         : Get.offAll(() => HomeScreen());
//   }

//   Future<void> createUserWithEmailAndPassword(
//       String email, String password, String fullname, String phone) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       firebaseUser.value != null
//           ? Get.offAll(() => HomeScreen())
//           : Get.to(() => LoginScreen());
//     } on FirebaseAuthException catch (e) {
//       final ex = SignUpFailure.code(e.code);
//       print('FIREBASE AUTH EXCEPTION - ${ex.message}');
//       throw ex;
//     } catch (_) {
//       const ex = SignUpFailure();
//       print('EXCEPTION - ${ex.message}');
//       throw ex;
//     }
//   }

//   Future<void> loginWithEmailAndPassword(String email, String password) async {
//   try {
//     await _auth.signInWithEmailAndPassword(email: email, password: password);
//     if (firebaseUser.value != null) {
//       Get.offAll(() => HomeScreen());
//     }
//   } on FirebaseAuthException catch (e) {
//     print('FirebaseAuthException - ${e.message}');
//     // Handle the error here
//   } catch (e) {
//     print('Exception - $e');
//     // Handle the error here
//   }
// }


//   Future<void> logout() async => await _auth.signOut();
// }

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => OnboardingScreen());
    } else {
      Get.offAll(() => NavigationMenu());
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String fullname, String phone) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser.value != null) {
        Get.offAll(() => NavigationMenu());
      } else {
        Get.to(() => LoginScreen());
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (firebaseUser.value != null) {
        Get.offAll(() => NavigationMenu());
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException - ${e.message}');
      // Handle the error here
    } catch (e) {
      print('Exception - $e');
      // Handle the error here
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
