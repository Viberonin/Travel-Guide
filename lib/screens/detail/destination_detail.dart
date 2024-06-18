import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:travelguide/constants/colors.dart';
import 'package:travelguide/screens/map_view/map_view_screen.dart';

import '../../../widgets/texts/section_heading.dart';
import '../../../constants/sizes.dart';
import '../../../utils/device_utility.dart';
import '../../models/destination_model.dart'; 
import 'destination_reviews.dart';
import 'widgets/dest_detail_image_slider.dart';
import 'widgets/rating_share_widget.dart';

class DestinationDetailScreen extends StatelessWidget {
  const DestinationDetailScreen({super.key, required this.destination});

  final DestinationModel destination;


  @override
  Widget build(BuildContext context) {

    final GeoPoint? coordinate = destination.coordinate;
    final double latitude = coordinate?.latitude ?? 0.0;
    final double longitude = coordinate?.longitude ?? 0.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1 - Product Image Slider
            TProductImageSlider(destination: destination),

            /// 2 - Product Details
            Container(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// - Rating & Share
                  const TRatingAndShare(),
                  Text(destination.rating.toString()),

                  /// - Price, Title, Stock, & Brand
                  // TProductMetaData(product: product),
                  // const SizedBox(height: TSizes.spaceBtwSections / 2),
                  Text(
                    destination.title!,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                  /// - Description
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // Read more package
                  Text(
                    destination.description!,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// - Reviews
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
              destination: destination,
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
