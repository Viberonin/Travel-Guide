import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1 - Product Image Slider
            TProductImageSlider(destination: destination),

            /// 2 - Product Details
            Container(
              padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// - Rating & Share
                  const TRatingAndShare(),

                  /// - Price, Title, Stock, & Brand
                  // TProductMetaData(product: product),
                  // const SizedBox(height: TSizes.spaceBtwSections / 2),

                  /// -- Attributes
                  // If Product has no variations do not show attributes as well.
                  // if (product.productVariations != null && product.productVariations!.isNotEmpty) TProductAttributes(product: product),
                  // if (product.productVariations != null && product.productVariations!.isNotEmpty) const SizedBox(height: TSizes.spaceBtwSections),

                  /// -- Checkout Button
                  // SizedBox(
                  //   width: TDeviceUtils.getScreenWidth(context),
                  //   child: ElevatedButton(child: const Text('Checkout'), onPressed: () => Get.to(() => const CheckoutScreen())),
                  // ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    destination.title!,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  /// - Description
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // Read more package
                  Text(
                    destination.description!,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                  // ReadMoreText(
                  //   destination.description!,
                  //   trimLines: 2,
                  //   colorClickableText: Colors.pink,
                  //   trimMode: TrimMode.Line,
                  //   trimCollapsedText: ' Show more',
                  //   trimExpandedText: ' Less',
                  //   moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  //   lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  // ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// - Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(title: 'Reviews (199)', showActionButton: false),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                        onPressed: () => Get.to(() => const ProductReviewsScreen(), fullscreenDialog: true),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: TBottomAddToCart(product: product),
    );
  }
}
