import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:travelguide/constants/colors.dart';
import 'package:travelguide/screens/map_view/map_view_screen.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

import '../../../widgets/texts/section_heading.dart';
import '../../../constants/sizes.dart';
import '../../../utils/device_utility.dart';
import '../../models/destination_model.dart'; 
import 'destination_reviews.dart';
import 'widgets/dest_detail_image_slider.dart';
import 'widgets/rating_share_widget.dart';

class DestinationDetailScreen extends StatefulWidget {

  const DestinationDetailScreen({super.key, required this.destination});
  final DestinationModel destination;

  @override
  State<DestinationDetailScreen> createState() => _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
  String selectedPackage = 'Pilih Paket Wisata';

  void _showPackageDialog() {
    showPlatformDialog(
      context: context,
      androidBarrierDismissible: true,
      builder: (_) => BasicDialogAlert(
        title: Text("Pilih Paket Wisata", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(),
            RadioListTile(
              title: Text('Penginapan di Hotel Bintang 3, Transportasi dengan Bus Pariwisata, Kunjungan ke 3 Tempat Wisata, dan Konsumsi 2 Kali Makan Sehari.', style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 14),),
              value: 'Paket A',
              groupValue: selectedPackage,
              onChanged: (value) {
                setState(() {
                  selectedPackage = value as String;
                  Navigator.pop(context);
                });
              },
            ),
            Divider(),
            RadioListTile(
              title: Text('Penginapan di Hotel Bintang 4, Transportasi dengan Minibus atau Mobil Pribadi, Kunjungan ke 5 Tempat Wisata termasuk Tempat Rekreasi Anak, dan Konsumsi 3 Kali Makan Sehari.', style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 14),),
              value: 'Paket B',
              groupValue: selectedPackage,
              onChanged: (value) {
                setState(() {
                  selectedPackage = value as String;
                  Navigator.pop(context);
                });
              },
            ),
            Divider(),
            RadioListTile(
              title: Text('Penginapan di Hotel Bintang 5, Transportasi dengan Mobil Pribadi Premium, Kunjungan ke 7 Tempat Wisata termasuk Wisata Kuliner, dan Konsumsi 3 Kali Makan Sehari di Restoran Ternama.', style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 14),),
              value: 'Paket C',
              groupValue: selectedPackage,
              onChanged: (value) {
                setState(() {
                  selectedPackage = value as String;
                  Navigator.pop(context);
                });
              },
            ),
            Divider(),
          ],
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("Cancel", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 14),),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          BasicDialogAction(
            title: Text("OK", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 14),),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final GeoPoint? coordinate = widget.destination.coordinate;
    final double latitude = coordinate?.latitude ?? 0.0;
    final double longitude = coordinate?.longitude ?? 0.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1 - Product Image Slider
            TProductImageSlider(destination: widget.destination),
            // 2 - Product Details
            Container(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // - Rating & Share
                  const TRatingAndShare(),
                  Text(widget.destination.rating.toString()),
                  // - Price, Title, Stock, & Brand
                  // const SizedBox(height: TSizes.spaceBtwSections / 2),
                  Text(
                    widget.destination.title!,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  // - Description
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    widget.destination.description!,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  // - Dropdown Menu for Paket Wisata
                  GestureDetector(
                    onTap: _showPackageDialog,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedPackage,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: TColors.primary,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  // - Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                          title: 'Reviews (199)', showActionButton: false),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                        onPressed: () => Get.to(
                            () => const ProductReviewsScreen(),
                            fullscreenDialog: true),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusLg),
            topRight: Radius.circular(TSizes.cardRadiusLg),
          ),
        ),
        child: TextButton(
          onPressed: () {
            Get.to(MapViewScreen(
              initialLatitude: latitude,
              initialLongitude: longitude,
              destination: widget.destination,
            ));
          },
          child: Text(
            'View in Maps',
            style: GoogleFonts.poppins(
              color: TColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
