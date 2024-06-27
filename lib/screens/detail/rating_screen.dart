import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:travelguide/models/paket_wisata_model.dart';
import 'package:travelguide/models/rating_model.dart';
import 'package:travelguide/constants/sizes.dart';

class RatingScreen extends StatefulWidget {
  final PaketWisataModel paket;
  const RatingScreen({Key? key, required this.paket}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 0;
  final _reviewController = TextEditingController();

  Future<void> submitRating() async {
    final rating = RatingModel(
      // userId: 'some-user-id', // Ganti dengan user ID yang sebenarnya
      paketId: widget.paket.id,
      rating: _rating,
      review: _reviewController.text,
    );

    await FirebaseFirestore.instance.collection('ratings').add(rating.toJson());

    Get.back(); // Kembali ke screen sebelumnya
    Get.snackbar('Success', 'Thank you for your rating!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate the Package', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate ${widget.paket.title}',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            TextField(
              controller: _reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your review here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF008FA0).withOpacity(0.8),
                  ),
                  child: TextButton(
                    onPressed: submitRating,
                    child: Text('Submit Rating', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
