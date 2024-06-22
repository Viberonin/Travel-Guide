import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:travelguide/components/navbar/navigation_bar.dart';
import 'package:travelguide/constants/image_strings.dart';
import 'package:travelguide/widgets/loaders/animation_loader.dart';

class FinishedTripScreen extends StatelessWidget {
  const FinishedTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat! Anda telah \n menyelesaikan perjalanan.',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Lottie.asset(TImages.carAnimation),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF008FA0).withOpacity(0.5), // Set the button color to green
            ),
            onPressed: () {
              Get.offAll(NavigationMenu());
            },
            child: Text('Kembali ke Beranda', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
          ),
        ),
      ),
    );
  }
}
