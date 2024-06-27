import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:travelguide/constants/colors.dart';
import 'package:travelguide/constants/sizes.dart';
import 'package:travelguide/models/paket_wisata_model.dart';
import 'package:travelguide/screens/detail/fullscreen_image_screen.dart';
import 'package:travelguide/screens/detail/rating_screen.dart';

class PaketWisataScreen extends StatefulWidget {
  const PaketWisataScreen({Key? key}) : super(key: key);

  @override
  _PaketWisataScreenState createState() => _PaketWisataScreenState();
}

class _PaketWisataScreenState extends State<PaketWisataScreen> {
  PaketWisataModel? selectedPaket;

  Future<List<PaketWisataModel>> fetchPaketWisata() async {
    final result = await FirebaseFirestore.instance.collection('paket_wisata').get();
    return result.docs.map((doc) => PaketWisataModel.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paket Wisata', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder<List<PaketWisataModel>>(
        future: fetchPaketWisata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No packages found.'));
          } else {
            final paketWisataList = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    itemCount: paketWisataList.length,
                    itemBuilder: (context, index) {
                      final paket = paketWisataList[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPaket = paket;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                            color: Colors.white,
                            border: selectedPaket == paket
                                ? Border.all(color: Colors.green, width: 3)
                                : Border.all(color: Colors.transparent),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => FullscreenImageScreen(imageUrl: paket.imageUrl));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(TSizes.cardRadiusLg)),
                                  child: Image.network(
                                    paket.imageUrl,
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, bottom: TSizes.defaultSpace, top: TSizes.defaultSpace / 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      paket.title,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                                    Text(
                                      paket.harga,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        color: TColors.primary
                                      ),
                                    ),
                                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: paket.rundown.map((item) => Text('• $item', style: GoogleFonts.poppins(fontSize: 14))).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (selectedPaket != null)
                  Container(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => RatingScreen(paket: selectedPaket!));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Lanjut Dengan Paket Yang Dipilih',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
