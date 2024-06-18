import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelguide/screens/detail/destination_detail.dart';

import '../../controllers/destination/destination_controller.dart';
import '../models/destination_model.dart';
// import '../../../../features/shop/screens/product_detail/product_detail.dart';
import '../constants/colors.dart';
import '../constants/enums.dart';
import '../constants/sizes.dart';
import '../utils/helper_functions.dart';
import '../constants/shadows.dart';
import '../widgets/shapes/rounded_container.dart';
import '../widgets/shapes/rounded_image.dart';
// import '../../texts/t_brand_title_text_with_verified_icon.dart';
import '../widgets/texts/destination_title_text.dart';
import '../widgets/icons/favourite_icon.dart';
// import 'widgets/add_to_cart_button.dart';
import '../widgets/destination_card_pricing.dart';
// import 'widgets/product_sale_tag.dart';
import 'package:logger/logger.dart';

class TDestinationCardVertical extends StatelessWidget {
  const TDestinationCardVertical(
      {super.key, required this.destination, this.isNetworkImage = true});

  final DestinationModel destination;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final destinationController = DestinationController.instance;
    // final salePercentage = destinationController.calculateSalePercentage(destination.price, destination.salePrice);
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        Get.to(DestinationDetailScreen(destination: destination));
      },

      /// Container with side paddings, color, edges, radius and shadow.
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalDestinationShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail, Wishlist Button, Discount Tag
            TRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  Center(
                      child: TRoundedImage(
                          imageUrl: destination.thumbnail,
                          applyImageRadius: true,
                          isNetworkImage: true)),

                  /// -- Sale Tag
                  // if (salePercentage != null) ProductSaleTagWidget(salePercentage: salePercentage),

                  /// -- Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TFavouriteIcon(destinationId: destination.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            /// -- Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TProductTitleText(title: destination.title, smallSize: true),
                  TProductTitleText(title: destination.title, smallSize: true),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  // TBrandTitleWithVerifiedIcon(title: product.brand!.name, brandTextSize: TextSizes.small),
                ],
              ),
            ),

            /// Price & Add to cart button
            /// Use Spacer() to utilize all the space and set the price and cart button at the bottom.
            /// This usually happens when Product title is in single line or 2 lines (Max)
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Pricing
                // PricingWidget(destination: destination),

                /// Add to cart
                // ProductCardAddToCartButton(product: product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
